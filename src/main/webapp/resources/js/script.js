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