

// Step 1, this file runs when <head> is parsed

// Step 2 Pass a callback to document.ready to be notified when the page loads.
$(document).ready(function() {
  // Step 4 the 'ready' event fires'

  // Step 5 get the hams selector and pass a callback for when it is clicked
  $('#hams').on('click', function(e) {
    // Step 7: Prevent the browser from doing what it wants, and send a GET request to /hams
    e.preventDefault();
    var request = $.ajax({
      url: '/hams',
      method: 'GET',
    });

    // Step 8: Pass a callback to the done function to let us know when the server gets back to us
    request.done(function(response) {
      // Step 9: Append the response
      $('#ham-holder').append(response);
    });
  });

  // Step 6: Return from the on ready callback
});

// Step 3 Finish parsing this file
