(function($) {
    let sliders = $(".slider");
    //console.log(sliders);

    var sliderUl, sliderUlLi, slideCount, slideWidth, slideHeight, sliderUlWidth;
    for(let i = 0; i < sliders.length; i++){
        let id = $(sliders[i]).attr("id");
        //console.log(id);
        sliderUl = $("#" + id + ' ul');
        //console.log($("#" + id + ' > ul'));
        sliderUlLi = $("#" + id + ' ul li');

        slideCount = sliderUlLi.length;
        //console.log("sliderCount: " + slideCount);

        slideWidth = sliderUlLi.width();
        //console.log("Sirka: " + slideWidth);


        slideHeight = sliderUlLi.height();
        sliderUlWidth = slideCount * (5*slideWidth);

        sliderUl.css({ width: "100%" });
        if(slideCount > 5)
            $("#" + id + ' ul li:last-child').prependTo("#" + id + ' ul');
    }
    console.log("Sirka po cyklu: " + slideWidth);
    //$('.slider').css({ width: "100%", height: slideHeight });


    //sliderUl.css({ width: "100%", marginLeft: - (5*slideWidth) });



    function moveLeft(par_id) {
        console.log($("#" + par_id + " ul"));
        // console.log(slideWidth);
        $("#" + par_id + " ul").animate({
            left: + (5*slideWidth)
        }, 200, function () {
            $("#" + par_id + " ul li:last-child").prependTo("#" + par_id + " ul");
            $("#" + par_id + " ul").css('left', '');
        });
    }
    function moveRight(par_id) {
        console.log($("#" + par_id + " ul"));
        // console.log(slideWidth);
        $("#" + par_id + " ul").animate({
            left: - (5*slideWidth)
        }, 200, function () {
            $("#" + par_id + " ul li:first-child").appendTo("#" + par_id + " ul");
            $("#" + par_id + " ul").css('left', '');
        });
    }
    $('a.control_prev').click(function (e) {
        let par_id = $(this).parent().attr("id");
        let count = $(this).siblings("ul").find("li").length;
        if(count > 5)
            moveLeft(par_id);
        e.preventDefault();
    });

    $('a.control_next').click(function (e) {
        let par_id = $(this).parent().attr("id");
        let count = $(this).siblings("ul").find("li").length;
        if(count > 5)
            moveRight(par_id);
        e.preventDefault();
    });

})( jQuery );
