$(document).ready(function() {
  showSequence();
})


function showSequence() {
  var id = parseInt(window.location.pathname.split("/")[2]);
  $.get('/sequences/' + id + '/list', function(data) {
    $("#sequence-title").html('"' + data.title + '"')
    $("#sequence-difficulty").html("Difficulty Rating: " + data.difficulty)
    $("#repititions").html("For " + data.repititions + " rounds, repeat the following sequence of poses:")
    listPoses(data);
  })
  };

function listPoses(data){
  debugger;
  poses = data.poses
  for (var i = 0; i < poses.length; i++){
    $("#poses").append('<li>' + poses[i].name + '</li>');
  }
};
