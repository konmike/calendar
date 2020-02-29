(function($) {
    var autoId = 1;
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var name = $('#file')[0].files[0].name;
            reader.onload = function (e) {
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="" alt="'+ name +'" width="200" id="im' + autoId + '" draggable="true" ondragstart="dragStart(event)"/>' +
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

    $(".pagination a").on("click", function(e) {
        e.preventDefault();
        $(".label--item").eq($(this).index()).fadeIn(150).siblings(".label--item").fadeOut(250);
        $(this).addClass("active").siblings("a").removeClass("active");
    })

})( jQuery );