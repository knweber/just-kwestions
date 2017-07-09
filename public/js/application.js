$(document).ready(function() {
  $("#new-question-comment-container a").on("click", function(e) {
    e.preventDefault();
    $("#question-comment-form-container").toggle();
    $(".comment-form textarea").val('');
    $("#question-comment-errors").html('');
  });

  $("#new-question-comment-container .comment-form").on("submit", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: '/comments',
      method: 'POST',
      data: $(this).serialize()
    });
    request.done( function(data) {
      $("#question-comment-container").append(data);
      $(".comment-form textarea").val('');
      $("#question-comment-form-container").hide();
      $("#question-comment-errors").html('');

    });
    request.fail( function(data) {
      $("#question-comment-errors").html(data.responseText);
    });
  });

  $("#new-answer-container a").on("click", function(e) {
    e.preventDefault();
    $("#answer-form-container").toggle();
    $("#answer-errors").html('');
    $("#answer-form textarea").val('');
  });

  $("#answer-form").on("submit", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      $("#answer-container").append(data);
      $("#answer-form textarea").val('');
      $("#answer-form-container").hide();
      $("#answer-errors").html('');
    });
    request.fail( function(data) {
      $('#answer-errors').html(data.responseText);
    });
  });
});
