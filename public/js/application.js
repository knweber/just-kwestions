$(document).ready(function() {

  // Add a comment to a question
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
      $("#question-comment-errors").html('');

    });
    request.fail( function(data) {
      $("#question-comment-errors").html(data.responseText);
    });
  });


  // Select best answer
  $('body').on('submit', '#choose-best-answer' function(event){
    event.preventDefault();
    var url = $('#choose-best-answer').attr('action');

    $.ajax({
      url: url,
      method: 'PUT',
      success: function(response){
        
      }

    })
  })

});
