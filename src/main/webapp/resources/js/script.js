(function($) {
    let ok = 0;
    function validImage(input) {

        for(let i = 0; i < input.files.length; i++){
            console.log("Kontrola nactenych obrazku: ");
            //let reader = new FileReader();
            let name = $('#file')[0].files[i].name;
            //reader.readAsDataURL(input.files[i]);

            let file = input.files[i];
            let fileType = file["type"];
            let validImageTypes = ["image/jpg", "image/jpeg", "image/png"];
            // let _URL = window.URL || window.webkitURL;
            // let img = new Image();
            // let objectUrl = _URL.createObjectURL(file);
            //
            // img.onload = function () {
            //     console.log("Img onload: ");
            //     console.log("width " + this.width + " height " + this.height);
            //     if(this.width < 100 || this.height < 100){
            //         console.log("Je to v pytli.");
            //         _URL.revokeObjectURL(objectUrl);
            //         ok = 1;
            //     }
            // };
            // img.src = objectUrl;
            // console.log("OK " + ok);

            if ($.inArray(fileType, validImageTypes) < 0) {
                // invalid file type code goes here.
                console.log("chyba v metrixu");
                $('.message').text(name + " není ve formátu .jpg, .jpeg nebo .png.");
                return false;
            }

        }
        console.log("tesne pred potvrzenim OK " + ok);
        return true;
    }

    let file = $("#file");
    let _URL = window.URL || window.webkitURL;

    file.change(function(){
        // var file_load, img;
        // for(var i = 0; i < this.files.length; i++){
        //     if((file_load = this.files[i])){
        //         console.log("jsme in");
        //         img = new Image();
        //         let objectUrl = _URL.createObjectURL(file_load);
        //         img.onload = function () {
        //             if(this.width < 100) {
        //                 alert(this.width + " " + this.height);
        //                 console.log("jsme in in");
        //                 return false;
        //             }else
        //                 alert(this.width + " " + this.height);
        //             _URL.revokeObjectURL(objectUrl);
        //         };
        //         img.src = objectUrl;
        //     }
        // }

        var valid = validImage(this);
        console.log("valid: " + valid);

        if(! valid ){
            console.log("chyba");
            return false;
        }else{
            console.log("vse ok");
            $('#redir').attr("value", "image");
            $('.form--calendar-update').submit();
        }
    });


    file.click(function () {
       $('.message').html("");
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

        $('#next').hide();
        $('#prev').hide();
    });

    $('.show-page-calendar').click(function (e) {
        for (var i = 2; i < 15; i++){
            console.log($('.label--item:nth-child('+i+')'));
            $('.label--item:nth-child('+i+')').hide();
        }

        $('#next').show();
        $('#prev').show();
    });

    $('#wrapper-type').change(function(){
        let t = parseInt($("input[name='type']:checked").val());
        console.log("Zmena na jiny typ " + t);
        setCalendarType(t);
        setLabelDesign(t);
    });

    function setLabelDesign(t){
        if(t === 1 || t === 2) {
            $("#wrapper-design .label--radio:nth-child(2)").show();
            $("#wrapper-design .label--radio:nth-child(3)").show();
            $("#wrapper-design .label--radio:nth-child(4)").hide();
            $("#wrapper-design .label--radio:nth-child(5)").hide();
        }else{
            $("#wrapper-design .label--radio:nth-child(2)").hide();
            $("#wrapper-design .label--radio:nth-child(3)").hide();
            $("#wrapper-design .label--radio:nth-child(4)").show();
            $("#wrapper-design .label--radio:nth-child(5)").show();
        }
    }
    let wrapper_image = $(".wrapper-image");
    let labels = $(".labels");
    let dates = $(".dates");
    let item = $(".item");
    let type = parseInt($('body').attr("data-custom-type"));
    let design = parseInt($('body').attr("data-custom-design"));


    setCalendarType(type);

    if(isNaN(type)){
        setLabelDesign(1);
    }else{
        setLabelDesign(type);
    }
    item.addClass("design" + design);
    $("#wrapper-type input[value=" + type + "]").attr("checked","checked");
    $("#wrapper-design input[value=" + design + "]").attr("checked","checked");

    if($(".section--calendar-show-one").length !== 0){
        console.log("ano, toto je fakt tisk");
        if(type === 1 || type === 2){
            item.addClass("a4-portrait-print");
        }else{
            item.addClass("landscape-print");
        }
    }

    $('#wrapper-design').change(function(){
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

    $(".type-of-calendar").click(function(){
        let type = $("#wrapper-type");
        let design = $("#wrapper-design");
        if(type.is(":hidden")){
            if(design.is(":visible"))
                design.hide();
            type.css("display", "grid").hide().fadeIn(1000);
        }
        else
            type.fadeOut(1000);
    });
    $(".calendar-design").click(function(){
        let type = $("#wrapper-type");
        let design = $("#wrapper-design");
        if(design.is(":hidden")) {
            if (type.is(":visible"))
                type.hide();
            design.css("display", "grid").hide().fadeIn(1000);
        }
        else
            design.fadeOut(1000);
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

        html2pdf().set(opt).from(element).save();

        //alert("Kalendar " + name + " bude stazen, pokracovat?");

        //removeCssToPrint(type);
    });

    // TODO mohlo by fungovat, ale je potreba to domyslet
    // jine rozlozeni galerie, zmenseni obrazku...

    // $(window).scroll(function(){
    //     let heightHeader = $("header").height();
    //     let labVis = $('.label--item:nth-child(2)').is(":visible");
    //     console.log(labVis);
    //     console.log(heightHeader);
    //     if ( ($(this).scrollTop() > heightHeader) && (labVis)) {
    //         $('.sidebox--upload-image').css({"position":"fixed", "top":"0","left":"0"});
    //     } else {
    //         $('.sidebox--upload-image').css("position","static");
    //     }
    // });


})( jQuery );