$(document).ready(function() {

// Add question to index

  $('a.ask-question-button').on('click', function(event){
    event.preventDefault();
    var url = $(this).attr('href');
    $(this).hide();

    $.ajax({
      url: url,
      type: 'GET',
      success: function(response){
        $('.ask-question-button-container').prepend(response);
      }
    });
  });

  $('body').on('submit', '#question-form', function(event){
    event.preventDefault();
    var url = $(this).attr('action');
    var data = $(this).serialize();
    $.ajax({
      url: url,
      method: 'POST',
      data: data,
      statusCode: {
        200: function(response){
        $('#question-container').append(response);
        $('#question-form').hide();
        $('a.ask-question-button').show();
      },
        422: function(){
          alert('All sections are required')
        }
      }
    })
  })

// Add new comment to question

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

  // Select best answer

  $('body').on('submit', '#choose-best-answer', function(event){
    event.preventDefault();
    var url = $('#choose-best-answer').attr('action');

    $.ajax({
      url: url,
      method: 'PUT',
      data: $(this).serialize(),
      success: function(response){
        $(".is-the-best").html("");
        var selector = "#answer-" + response.id;
        $(selector + " .is-the-best").html(response.html);
      }
    })
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

  $("#answer-container").on("click", ".new-answer-comment-container a", function(e) {
    e.preventDefault();
    $(this).parent().parent().find(".answer-comment-form-container").toggle();
    $(this).parent().parent().find(".answer-comment-errors").html("");
    $(this).parent().parent().find(".comment-form textarea").val("");
  });

  $("#answer-container").on("submit", ".comment-form", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      var selector = "#answer-" + data.id;
      $(selector + " .answer-comment-container").append(data.html);
      $(selector + " .comment-form textarea").val("");
      $(selector + " .answer-comment-form-container").hide();
      $(selector + " .answer-comment-errors").html("");
    });
    request.fail( function(data) {
      var response = JSON.parse(data.responseText);
      var selector = "#answer-" + response.id;
      $(selector + " .answer-comment-errors").html(response.html)
    });
  });

  $("#question-upvotes, #question-downvotes").on('submit', function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      $("#question-points").html(data);
    });
  });

  $("#answer-container").on("submit", ".answer-upvotes, .answer-downvotes", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      var selector = "#answer-" + data.id;
      $(selector + " .answer-points").html(data.html);
    });
  });

  $("#question-comment-container").on("submit", ".question-comment-upvotes, .question-comment-downvotes", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      var selector = "#question-comment-" + data.id;
      $(selector + " .question-comment-points").html(data.html);
    });
  });

  $("#answer-container").on("submit", ".answer-comment-upvotes, .answer-comment-downvotes", function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: this.action,
      method: "POST",
      data: $(this).serialize()
    });
    request.done( function(data) {
      var selector = "#answer-comment-" + data.id;
      $(selector + " .answer-comment-points").html(data.html);
    });
  });
});
