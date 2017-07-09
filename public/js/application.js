$(document).ready(function() {
  $("#new-question-comment-container a").on("click", function(e) {
    e.preventDefault();
    $("#question-comment-form-container").toggle();
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
    });
    request.fail( function(data) {
      $("#question-comment-errors").html(data.responseText);
    });
  });
});
