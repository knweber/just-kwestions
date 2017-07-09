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

  $('body').on('submit', '#question-form', function(event){
    event.preventDefault();
    console.log(this)
    var url = $(this).attr('action');
    var data = $(this).serialize();
    $('#question-form').hide();
    $('a.ask-question-button').show();

    $.ajax({
      url: url,
      method: 'POST',
      data: data
    }).done(function(response){
        console.log(response)
        $('#question-container').append(response);
      })
  })
});
