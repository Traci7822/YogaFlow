$(document).ready(function() {
  listPoses();
})

function listPoses() {
  debugger;
  var id = parseInt(window.location.pathname.split("/")[2]);
  $.get('/sequences/' + id + '/list', function(data) {
    debugger;
    $("#poses").text(data);
  })
}
