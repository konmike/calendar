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

    var labels_item = $('#calendar .label--item');
    var now = 0; // currently shown div
    labels_item.hide().first().show();
    $("#next").click(function (e) {
        labels_item.eq(now).hide();
        now = (now + 1 < labels_item.length) ? now + 1 : 0;
        labels_item.eq(now).show(); // show next
    });
    $("#prev").click(function (e) {
        labels_item.eq(now).hide();
        now = (now > 0) ? now - 1 : labels_item.length - 1;
        labels_item.eq(now).show(); // or .css('display','block');
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

    let wrapper_image = $(".wrapper-image");
    let labels = $(".labels");
    let dates = $(".dates");
    let item = $(".item");
    let type = parseInt($('body').attr("data-custom-type"));
    let design = parseInt($('body').attr("data-custom-design"));


    setCalendarType(type);
    item.addClass("design" + design);

    if($(".section--calendar-show-one").length !== 0){
        console.log("ano, toto je fakt tisk");
        if(type === 1 || type === 2){
            item.addClass("a4-portrait-print");
        }else{
            item.addClass("landscape-print");
        }
    }

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

        if(t === 1 || t === 2){
            item.removeClass("landscape");
            if(!item.hasClass("a4-portrait")){
                item.addClass("a4-portrait");
            }
            if(t === 1)
                setWrapperImageTopDateBlock();
            else
                setWrapperImageTopDateRow();
        }else{
            item.removeClass("a4-portrait");
            if(!item.hasClass("landscape"))
                item.addClass("landscape");
            if(t === 3)
                setWrapperImageLeftDateBlock();
            else
                setWrapperImageTopDateRow();
        }
    }

    function setWrapperImageTopDateBlock(){
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

    function addCssToPrint(t){
        if(t === 3 || type === 4){
            console.log("pridej classu");
            item.addClass("landscape-print");
        }
    }
    function removeCssToPrint(t){
        if(t === 3 || t === 4){
            console.log("odeber classu");
            item.removeClass("landscape-print");
        }
    }

    $(".link--download").click(function(){
        console.log("stahni kalendar");

        let type = parseInt($('body').attr("data-custom-type"));
        let name = $('body').attr("data-custom-name");
        let orientation = "landscape";
        if(type === 1 || type === 2)
            orientation = "portrait";

        //addCssToPrint(type);

        let element = document.getElementById('calendar');
        let opt = {
            margin:       0,
            filename:     name,
            image:        { type: 'jpeg/png', quality: 1},
            html2canvas:  { dpi: 300 },
            jsPDF:        { unit: 'mm', format: 'a4', orientation: orientation }
        };

        html2pdf().set(opt).from(element).toImg().save();

        //alert("Kalendar " + name + " bude stazen, pokracovat?");

        //removeCssToPrint(type);
    });


})( jQuery );