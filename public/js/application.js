$(document).ready(function() {

  $('a.ask-question-button').on('click', function(event){
    event.preventDefault();
    var url = $(this).attr('href');
    $(this).hide();

    $.ajax({
      url: url,
      type: 'GET',
      success: function(response){
        $('#question-container').append(response);
      }
    });
  });

  $('#kwest-button').on('click', function(event){
    event.preventDefault();
    var url = $(this).parent().attr('action');

    $.ajax({
      url: url,
      type: 'POST',
      success: function(response){
        $('#question-container').append(response);
      }
    })
  })
});
