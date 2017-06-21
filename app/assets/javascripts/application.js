//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
jQuery(document).ready(function($) {
  $('.new_comment').submit(function(event) {
      event.preventDefault();
      var params = $(this).serialize();
      var form = $(this);
       $.ajax({
         url: form.attr('action'),
         type: 'post',
         dataType: 'json',
         data: params,
       })
       .done(function(response) {
        if(response.status == 'success'){
          $('#comments-section').append(response.html);
          $('#comment_content').val('');
        }else {

        }
        })
       .fail(function() {
         console.log("error");
       })
       .always(function() {
         console.log("complete");
       });

  });
});
