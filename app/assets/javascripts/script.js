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
var jsonData = '/sequences/' + id + '.json';

function showSequence(id) {
  $.get(jsonData, function(data) {
    showSequenceData(data);
    listPoses(data);
  })
};

function showSequenceData(data){
  $("#sequence-title").html('"' + data.sequence.title + '"')
  $("#sequence-difficulty").html("Difficulty Rating: " + data.sequence.difficulty)
  $("#repititions").html("For " + data.sequence.repititions + " rounds, repeat the following sequence of poses:")
}

function listPoses(data){
  for (var i = 0; i < data.sequence.poses.length; i++){
    addPoseToDOM(data.sequence.poses[i]);
  }
};

function addPoseToDOM(pose){
  $("#poses").append('<li>' + pose.name + pose.description + '</li>');
}

function scrollSequence(){
  $.get(jsonData, function(data) {
    nextId = setNextId(data.ids);
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
  $.get(jsonData, function(data) {
    for (var i = 0; i < data.comments.length; i++) {
      showData(data.comments[i], "#display_comments");
    }
  });
}

function addComment(data){
  var response = data;
  $.get(jsonData, function(data) {
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
  showComment(this, "#display_comments");
  clearForm('.comment_form');
}

function showData(data, tagId){
  $(tagId).append('<h4>' + data.user.username + " says: " + data.content + '</h4>');
  $(tagId).append('<h5>' + readableDate(data) + '</h5>')
}

function clearAttribute(attribute) {
  $(attribute).val('');
}

function readableDate(data) {
  var getDate = new Date(data.created_at)
  return getDate.toUTCString()
}
