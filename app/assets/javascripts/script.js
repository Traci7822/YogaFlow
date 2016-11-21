$(document).ready(function() {
  showSequence(id);
  displayComments();

  $(".js-next").on("click", function() {
    scrollSequence();
  });

  $('.comment_form').on('submit', function(event) {
    event.preventDefault();
    var valuesToSubmit = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      data: valuesToSubmit,
      dataType: "json",
      success: function(response) {
        addComment(response);
      },
      error: function(xhr, textStatus, errorThrown) {
      }
    });
  });
});

var id = parseInt(window.location.pathname.split("/")[2])

function showSequence(id) {
  $.get('/sequences/' + id + '.json', function(data) {
    showSequenceData(data);
    listPoses(data);
  })
};

function showSequenceData(data){
  $("#sequence-title").html('"' + data.title + '"')
  $("#sequence-difficulty").html("Difficulty Rating: " + data.difficulty)
  $("#repititions").html("For " + data.repititions + " rounds, repeat the following sequence of poses:")
}

function listPoses(data){
  for (var i = 0; i < data.poses.length; i++){
    addPoseToDOM(data.poses[i]);
  }
};

function addPoseToDOM(pose){
  $("#poses").append('<li>' + pose.name + pose.description + '</li>');
}

function scrollSequence(){
  $.get('/sequence_ids', function(data) {
    nextId = setNextId(data);
    window.location.href = '/sequences/' + nextId;
    $(".js-next").attr("data-id", nextId);
  })
};

function setNextId(data) {
  var nextId = 0;
  var idIndex = data.indexOf(id);
  if (data[idIndex + 1] === undefined) {
    nextId = data[0];
  } else {
    nextId = data[idIndex + 1];
  }
  return nextId
}

function displayComments() {
  $.get('/sequences/' + id + '.json', function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      showComment(data.comments[i]);
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
  });
}

function Comment(data){
  this.content = data.content;
  this.created_at = data.created_at;
  this.id = data.id;
  this.user = data.user;
}

Comment.prototype.appendToDOM = function() {
  showComment(this);
  clearForm();
}

function showComment(data){
  $("#display_comments").append('<h4>' + data.user.username + " says: " + data.content + '</h4>');
  $("#display_comments").append('<h5>' + readableDate(data) + '</h5>')
}

function clearForm() {
  $('.comment_form').val('');
}

function readableDate(data) {
  var getDate = new Date(data.created_at)
  return getDate.toUTCString()
}
