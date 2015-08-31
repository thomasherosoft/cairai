// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function () {
    $("#comic_image_attributes_photo").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = comiccoverIsLoaded;
            reader.readAsDataURL(this.files[0]);
        }
    });
    
    $('#comic_comic_tags').tagsinput({
      maxTags: 30
    });
    
    $("#comic-show-hide-details").click(function(){
	    if ($.trim($(this).text()) === 'Show More') {
	        $(".comic-show-hide-information").show(1000);
	        $(this).text('Show Less');
	    } else {
	    	  $(".comic-show-hide-information").hide(1000);
	        $(this).text('Show More');        
	    }
	    return false; 
		});
		
});

function comiccoverIsLoaded(e) {
    $('#comic-cover-photo').attr('src', e.target.result);
};

