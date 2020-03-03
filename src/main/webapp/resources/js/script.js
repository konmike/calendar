(function($) {
    var autoId = 1;
    function readURL(input) {
        // console.log(input.files);
        // console.log($('#file')[0].files[0].name);
        // console.log($('#file')[0].files[1].name);
        for(let i = 0; i < input.files.length; i++){
            let reader = new FileReader();
            let name = $('#file')[0].files[i].name;
            reader.onload = function (e) {
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="" alt="'+ name +'" width="200" id="im' + autoId + '" draggable="true" ondragstart="dragStart(event)"/>' +
                    '<a href="' + e.target.result +'">Zvětšit</a>' +
                    '</li>');
                //$('#blah').attr('src', e.target.result);
            };
            autoId++;
            reader.readAsDataURL(input.files[i]);
        }
        /*
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
        }*/
    }

    $("#file").change(function(){
        readURL(this);
    });

    /*$(".pagination a").on("click", function(e) {
        e.preventDefault();
        $(".label--item").eq($(this).index()).fadeIn(150).siblings(".label--item").fadeOut(250);
        $(this).addClass("active").siblings("a").removeClass("active");
    });*/

    var labels = $('#calendar .label--item');
    var now = 0; // currently shown div
    labels.hide().first().show();
    $("#next").click(function (e) {
        labels.eq(now).hide();
        now = (now + 1 < labels.length) ? now + 1 : 0;
        labels.eq(now).show(); // show next
    });
    $("#prev").click(function (e) {
        labels.eq(now).hide();
        now = (now > 0) ? now - 1 : labels.length - 1;
        labels.eq(now).show(); // or .css('display','block');
        //console.log(divs.length, now);
    });

})( jQuery );