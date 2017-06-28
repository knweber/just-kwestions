$(document).ready(function() {
  $('#hams').on('click', function(e) {
    e.preventDefault();
    var request = $.ajax({
      url: '/hams',
      method: 'GET',
    });

    // request.done();
  });
});
