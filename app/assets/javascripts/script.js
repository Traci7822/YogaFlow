$(document).ready(function() {
  showSequence(id);
  displayComments();

  $(".js-next").on("click", function() {
    scrollSequence();
  });

  $('.comment_form').on('submit', function(event) {
    var valuesToSubmit = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      data: valuesToSubmit,
      dataType: "json",
      success: function(response) {
        console.log(response)
        addComment(response);
      },
      error: function(xhr, textStatus, errorThrown) {
      }
    });
    event.preventDefault();
  });
});

var id = parseInt(window.location.pathname.split("/")[2])

function showSequence(id) {
  $.get('/sequences/' + id + '.json', function(data) {
    var id = data["id"];
    $("#sequence-title").html('"' + data.title + '"')
    $("#sequence-difficulty").html("Difficulty Rating: " + data.difficulty)
    $("#repititions").html("For " + data.repititions + " rounds, repeat the following sequence of poses:")
    listPoses(data);
  })
};

function listPoses(data){
  poses = data.poses
  for (var i = 0; i < poses.length; i++){
    $("#poses").append('<li>' + poses[i].name + poses[i].description + '</li>');
  }
};

function scrollSequence(){
  $.get('/sequence_ids', function(data) {
    debugger;
    var idIndex = data.indexOf(id);
    if (data[idIndex + 1] === undefined) {
      nextId = data[0];
    } else {
      var nextId = data[idIndex + 1];
    }
    window.location.href = '/sequences/' + nextId;
    $(".js-next").attr("data-id", nextId);
  })
};

function displayComments() {
  $.get('/sequences/' + id + '.json', function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      var date = new Date(data.comments[i].created_at)
      $("#display_comments").append('<h4>' + data.comments[i].user.username + " says: " + data.comments[i].content + '</h4>');
      $("#display_comments").append('<h5>' + date.toUTCString() + '</h5>')
    }
  });
}

function addComment(data){
  var response = data;
  $.get('/sequences/' + id + '.json', function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      if (data.comments[i].id == response.id) {
        var comment = new Comment(data.comments[i])
        comment.appendToDOM()
      }
    }
  })
}

function Comment(data){
  this.content = data.content;
  this.created_at = data.created_at;
  this.id = data.id;
  this.user = data.user;
}

Comment.prototype.appendToDOM = function() {
  var date = new Date(this.created_at)
  $("#display_comments").append('<h4>' + this.user.username + " says: " + this.content + '</h4>');
  $("#display_comments").append('<h5>' + date.toUTCString() + '</h5>')
  $('.comment_form').val('');
}
