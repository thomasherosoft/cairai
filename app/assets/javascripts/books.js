// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function () {
    $("#book_image_attributes_photo").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = bookcoverIsLoaded;
            reader.readAsDataURL(this.files[0]);
        }
    });
    
    $('#book_book_tags').tagsinput({
      maxTags: 30
    });
    
    $("#book-show-hide-details").click(function(){
	    if ($.trim($(this).text()) === 'Show More') {
	        $(".book-show-hide-information").show(1000);
	        $(this).text('Show Less');
	    } else {
	    	  $(".book-show-hide-information").hide(1000);
	        $(this).text('Show More');        
	    }
	    return false; 
		});
});

function bookcoverIsLoaded(e) {
    $('#book-cover-photo').attr('src', e.target.result);
};


