(function($) {
    var autoId = 1;
    function readURL(input) {
        // console.log(input.files);
        // console.log($('#file')[0].files[0].name);
        // console.log($('#file')[0].files[1].name);
        for(let i = 0; i < input.files.length; i++){
            let reader = new FileReader();
            let name = $('#file')[0].files[i].name;
            reader.readAsDataURL(input.files[i]);

            reader.onload = function (e) {
                let img = new Image();
                let file = input.files[i];
                img.src = e.target.result;

                img.onload = function () {
                    var height = this.height;
                    var width = this.width;
                    console.log("cuus");
                    console.log(height);
                    console.log(width);
                    if ((height >= 1200 && width >= 800) || (height >= 800 && width >= 1200)) {
                        console.log("gooood");
                        alert("Height and Width is good.");
                        return true;
                    }
                    alert("Uploaded image has invalid Height and Width.");
                    return false;
                };
                /*let objectUrl = URL.createObjectURL(file);
                img.onload = function () {
                    //alert(this.width + " " + this.height);
                    console.log(this.width);
                    console.log(this.height);
                    URL.revokeObjectURL(objectUrl);
                };
                img.src = objectUrl;
        */
                $('.preview-gallery').append(
                    '<img src="' + e.target.result + '" class="img img--preview" alt="'+ name +'" id="im' + autoId + '" />'
                    );
                //$('#blah').attr('src', e.target.result);
            };
            autoId++;
            //reader.readAsDataURL(input.files[i]);
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

        // if(!readURL(this)){
        //     alert("Height and Width must exceed 1600x1200 px or 1200x1600px.");
        //     return false;
        // }
        $('#redir').attr("value", "image");
        $('.form--calendar-update').submit();

    });

    /*$(".pagination a").on("click", function(e) {
        e.preventDefault();
        $(".label--item").eq($(this).index()).fadeIn(150).siblings(".label--item").fadeOut(250);
        $(this).addClass("active").siblings("a").removeClass("active");
    });*/

    $('#file').click(function () {
       $('.preview-gallery').html("");
    });

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
    
    $('.show-full-calendar').click(function (e) {
        for (var i = 2; i < 15; i++){
            console.log($('.label--item:nth-child('+i+')'));
            $('.label--item:nth-child('+i+')').show();
        }

        $('.pagination').hide();
    });

    $('.show-page-calendar').click(function (e) {
        for (var i = 3; i < 15; i++){
            console.log($('.label--item:nth-child('+i+')'));
            $('.label--item:nth-child('+i+')').hide();
        }

        $('.pagination').show();
    });

    $('.label--type').change(function(){
        let t = parseInt($("input[name='type']:checked").val());
        console.log("Zmena na jiny typ " + t);
        setCalendarType(t);
    });

    let item = $(".item");
    let type = parseInt($('body').attr("data-custom-type"));
    let design = parseInt($("input[name='type']:checked").val());
    setCalendarType(type);
    item.addClass("design" + design);

    $('.label--design').change(function(){
        let t = parseInt($("input[name='design']:checked").val());
        console.log("Zmena na jiny design " + t);
        setCalendarDesign(t);
    });

    function setCalendarDesign(t){
        //let item = $(".item");
        item.removeClass (function (index, className) {
            return (className.match (/(^|\s)design\S+/g) || []).join("");
        });
        item.addClass("design" + t);
    }

    $("type-of-calendar").click(function(){
       console.log("Zobraz/skryj");
       if($(".label--type:visible"))
           $(".label--type").hide();
       else
           $(".label--type").show();
    });



    function setCalendarType(t){
        //let item = $(".item");
        console.log("Itemy " + item);
        console.log("Typ " + t);
        if(t === 1){
            console.log("nastav jednicku");
            item.removeClass("landscape");
            if(!item.hasClass("a4-portrait")){
                item.addClass("a4-portrait");
                console.log("pridej tridu");
            }
            setWrapperImageTopDateBlock();
        }else if(t === 2){
            console.log("nastav dva");
            item.removeClass("landscape");
            if(!item.hasClass("a4-portrait"))
                item.addClass("a4-portrait");
            setWrapperImageTopDateRow();
        }else if(t === 3){
            console.log("nastav tri");
            item.removeClass("a4-portrait");
            if(!item.hasClass("landscape"))
                item.addClass("landscape");
            setWrapperImageLeftDateBlock();
        }else{
            console.log("nastav ctyri");
            item.removeClass("a4-portrait");
            if(!item.hasClass("landscape"))
                item.addClass("landscape");
            setWrapperImageTopDateRow();
        }
    }

    function setWrapperImageTopDateBlock(){
        let wrapper_image = $(".wrapper-image");
        let labels = $(".labels");
        let dates = $(".dates");

        wrapper_image.removeClass("wrapper-image-top-date-row wrapper-image-left-date-block");
        if(!wrapper_image.hasClass("wrapper-image-top-date-block"))
            wrapper_image.addClass("wrapper-image-top-date-block");
        labels.removeClass("labels-grid-row");
        dates.removeClass("dates-grid-row");
        if(!labels.hasClass("labels-grid-block")){
            labels.addClass("labels-grid-block");
            dates.addClass("dates-grid-block");
        }
    }

    function setWrapperImageLeftDateBlock(){
        let wrapper_image = $(".wrapper-image");
        let labels = $(".labels");
        let dates = $(".dates");

        wrapper_image.removeClass("wrapper-image-top-date-row wrapper-image-top-date-block");
        if(!wrapper_image.hasClass("wrapper-image-left-date-block"))
            wrapper_image.addClass("wrapper-image-left-date-block");
        labels.removeClass("labels-grid-row");
        dates.removeClass("dates-grid-row");
        if(!labels.hasClass("labels-grid-block")){
            labels.addClass("labels-grid-block");
            dates.addClass("dates-grid-block");
        }
    }

    function setWrapperImageTopDateRow(){
        let wrapper_image = $(".wrapper-image");
        let labels = $(".labels");
        let dates = $(".dates");

        wrapper_image.removeClass("wrapper-image-top-date-block wrapper-image-left-date-block");
        if(!wrapper_image.hasClass("wrapper-image-top-date-row"))
            wrapper_image.addClass("wrapper-image-top-date-row");
        labels.removeClass("labels-grid-block");
        dates.removeClass("dates-grid-block");
        if(!labels.hasClass("labels-grid-row")){
            labels.addClass("labels-grid-row");
            dates.addClass("dates-grid-row");
        }
    }


    $(".link--download").click(function(){
        console.log("stahni kalendar");

        //TODO addCssToPrint();

        let type = parseInt($('body').attr("data-custom-type"));
        let name = $('body').attr("data-custom-name");
        let orientation = "landscape";
        if(type === 1 || type === 2)
            orientation = "portrait";

        let element = document.getElementById('calendar');
        let opt = {
            margin:       1,
            filename:     name,
            image:        { type: 'jpeg', quality: 0.98 },
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'letter', orientation: orientation }
        };

        html2pdf().set(opt).from(element).save();

        //TODO removeCssToPrint();
    });


})( jQuery );