(function($) {
    var autoId = 1;
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var name = $('#file')[0].files[0].name;
            reader.onload = function (e) {
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="file-name" alt="'+ name +'" width="200" id="im' + autoId + '" draggable="true" ondragstart="return dragStart(event)"/>' +
                    '<a href="' + e.target.result +'">Zvětšit</a>' +
                    '</li>');
                //$('#blah').attr('src', e.target.result);
            };
            autoId++;
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#file").change(function(){
        readURL(this);
    });



})( jQuery );