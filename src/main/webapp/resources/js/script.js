(function($) {

    $('#file').change(function() {
        var i = $(this).prev('label').clone();
        var file = $('#file')[0].files[0].name;
        //$(this).prev('label').text(file);

        var file_name = $('.file-name');
        if(file_name.length){
            file_name.text(file);
        }else{
            $('.label--file').after('<span class="file-name">' + file + '</span>');
        }
        console.log(file);
    });

})( jQuery );

/*
function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
            $('.label--file').append('<img src="' + e.target.result + '" class="file-name" width="200"/>');
                //$('#blah').attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#imgInp").change(function(){
        readURL(this);
    });
    
$('#imgInp').change(function() {
        var i = $(this).prev('label').clone();
        var file = $('#imgInp')[0].files[0].name;
        //$(this).prev('label').text(file);

				$('.label--file').append('<span class="file-name">' + file + '</span>');

        /*var file_name = $('.file-name');
        if(file_name.length){
            file_name.text(file);
        }else{
            
        }*/
        //console.log(file);
    });
*/