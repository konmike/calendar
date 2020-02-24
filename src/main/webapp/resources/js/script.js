(function($) {

    /*$('#file').change(function() {
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
    });*/

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var name = $('#file')[0].files[0].name;
            reader.onload = function (e) {
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="file-name" alt="'+ name +'" width="200"/>' +
                    '<a href="' + e.target.result +'">Zvětšit</a>' +
                    '</li>');
                //$('#blah').attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#file").change(function(){
        readURL(this);
    });

})( jQuery );