// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// Global Variable for set the current page of the opend PDF.
localStorage['current_pdf_page'] = 1;

$(document).ready(function() {
  setTimeout(function() {
    $('#flash').slideUp();
  }, 5000);
});

$(function () {
    $("#user_photo").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = imageIsLoaded;
            reader.readAsDataURL(this.files[0]);
        }
    });
    
    $('.popover-markup>.trigger').popover({
	    html: true,
	    title: function () {
	        return $(this).parent().find('.head').html();
	    },
	    content: function () {
	        return $(this).parent().find('.content').html();
	    }
    });
});

function imageIsLoaded(e) {
    $('#user-profile-picture').attr('src', e.target.result);
};

$(function($) {
  $("#new-comment")
    .bind("ajax:error", function(event, xhr, status, error) {
      if (xhr.status == 401) {
        $('#flash-messages').html("<div class='alert alert-alert' id='flash'><a class='close' data-dismiss='alert' href='#'>×</a><ul><li>"+ xhr.responseText +"</li></ul></div>");
        $("html, body").animate({ scrollTop: 0 }, "slow");
        setTimeout(function() {
    		window.location = '/users/sign_in';
  			}, 3000);
      }
    });
});