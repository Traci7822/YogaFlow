$(document).ready(function() {
  showSequence(id);
  displayComments();


  $(".js-next").on("click", function() {
    scrollSequence();
  });

  $('form').on('submit', function(event) {
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
  var nextId = id += 1;
  window.location.href = '/sequences/' + nextId;
  $(".js-next").attr("data-id", nextId);

  //is this acceptable for what the lab asks for? below ajax call was not displaying data

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
      var date = (data.comments[i].created_at).toString().replace(/UTC\s/,"");
      debugger;

      $("#display_comments").append('<h4>' + data.comments[i].user.username + " says: " + data.comments[i].content + '</h4>');
      $("#display_comments").append('<h5>' + new Date(date) + '</h5>')
    }
  });
  //need to submit comment via ajax so i can remove functionality from view
}
