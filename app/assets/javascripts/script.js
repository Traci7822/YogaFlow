$(document).ready(function() {
  listPoses();
})

function listPoses() {
  var id = parseInt(window.location.pathname.split("/")[2]);
  $.get('/sequences/' + id + '/list', function(data) {
    $("#poses").text(data);
  })
}
