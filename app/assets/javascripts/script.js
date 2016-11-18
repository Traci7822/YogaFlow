$(document).ready(function() {
  showSequence(id);
  displayComments();
  console.log('hello')


  $(".js-next").on("click", function() {
    //when clicking next, code runs twice and poses show twice
    scrollSequence();
  });

  $('form').on('submit', function(event) {
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
    event.preventDefault();
  });
});

var id = parseInt(window.location.pathname.split("/")[2])

function showSequence(id) {
  $.get('/sequences/' + id + '/list', function(data) {
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

  })
  var nextId = id += 1;
  window.location.href = '/sequences/' + nextId;
  $(".js-next").attr("data-id", nextId);

  //is this acceptable for what the lab asks for? below ajax call was not displaying data
  //check what id's are available and select from these to prevent missing id's

  // $.get("/sequences/" + nextId + "/list", function(data) {
  //   $("#sequence-title").html(data.title);
  //   $("#sequence-difficulty").html("Difficulty Rating: " + data.difficulty)
  //   $("#repititions").html("For " + data.repititions + " rounds, repeat the following sequence of poses:")
  //   listPoses(data);
  //   $(".js-next").attr("data-id", id)
  // });
};

function displayComments() {
  $.get('/sequences/' + id + '/list', function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      var date = new Date(data.comments[i].created_at)
      $("#display_comments").append('<h4>' + data.comments[i].user.username + " says: " + data.comments[i].content + '</h4>');
      $("#display_comments").append('<h5>' + date.toUTCString() + '</h5>')
    }
  });
  //need to submit comment via ajax so i can remove functionality from view
}

function addComment(data){
  var response = data;
  $.get('/sequences/' + id + '/list', function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      if (data.comments[i].id == response.id) {
        var date = new Date(data.comments[i].created_at)
        $("#display_comments").append('<h4>' + data.comments[i].user.username + " says: " + data.comments[i].content + '</h4>');
        $("#display_comments").append('<h5>' + date.toUTCString() + '</h5>')
        $('.comment_form').val('');
      }
  }

})
}
