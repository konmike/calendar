(function($) {
    $(document).ready(function() {
        // Animate loader off screen
        $(".se-pre-con").fadeOut("slow");
    });

    let body = $("body");
    let file = $("#file");
    file.attr("value","");

    file.change(function(){
        let test = body.attr("data-custom-test");
        if(test === "false"){
            $('#redir').attr("value", "image");
            $('.form--calendar-update').submit();
            file.attr("value","");
        }
    });


    file.click(function () {
       $('span[id="file.errors"]').text("");
        $('span[id="file.errors"]').css("background-color", "transparent");
    });

    if($('span[id="file.errors"]').text().length > 0)
        $('span[id="file.errors"]').css("background-color", "rgb(0,0,0)");

    let labels_item = $('#calendar .label--item');
    let now = 0; // currently shown div
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
    
    $('.link--show-full-calendar').click(function (e) {
        for (var i = 1; i < 14; i++){
            console.log($('#calendar .label--item:nth-child('+i+')'));
            $('#calendar .label--item:nth-child('+i+')').show();
        }
        item.css("margin-bottom","1rem");
        $('#next').hide();
        $('#prev').hide();
    });

    $('.link--show-page-calendar').click(function (e) {
        for (var i = 1; i < 14; i++){
            console.log($('#calendar .label--item:nth-child('+i+')'));
            $('#calendar .label--item:nth-child('+i+')').hide();
        }

        item.css("margin-bottom","0");
        $('#calendar .label--item-0').show();
        now = 0;
        $('#next').show();
        $('#prev').show();
    });

    $('#wrapper-type').change(function(){
        let t = parseInt($("input[name='type']:checked").val());
        console.log("Zmena na jiny typ " + t);
        setCreatePreview(t);
        setCalendarType(t);
        setLabelDesign(t);
    });

    function setCreatePreview(t){
        let t1 = $("#calendar-date-block");
        let t2 = $("#calendar-date-row");
        if( (t === 1 || t === 3) ) {
            t2.hide();
            // t1.show();
            t1.css("display", "grid").hide().fadeIn(1000);
        }else{
            t1.hide();
            //t2.show();
            t2.css("display", "grid").hide().fadeIn(1000);
        }
    }

    function setLabelDesign(t){
        if(t === 1 || t === 2) {
            $("#wrapper-design .label--radio:nth-child(3)").show();
            $("#wrapper-design .label--radio:nth-child(4)").show();
            $("#wrapper-design .label--radio:nth-child(5)").hide();
            $("#wrapper-design .label--radio:nth-child(6)").hide();
        }else{

            $("#wrapper-design .label--radio:nth-child(3)").hide();
            $("#wrapper-design .label--radio:nth-child(4)").hide();
            $("#wrapper-design .label--radio:nth-child(5)").show();
            $("#wrapper-design .label--radio:nth-child(6)").show();
        }
    }
    let wrapper_image = $(".wrapper--image");
    let monthLabels = $(".wrapper--dates h3");
    let labels = $(".labels");
    let calendarTitle = $(".calendar-title");
    let dates = $(".dates");
    let item = $(".item");
    let type = parseInt(body.attr("data-custom-type"));
    let design = parseInt(body.attr("data-custom-design"));
    let colorLabels = body.attr("data-custom-color-labels");
    let colorDates = body.attr("data-custom-color-dates");
    let backgroundColor = body.attr("data-custom-color-background");

    if(design === 0){
        labels.css( "color", colorLabels);
        calendarTitle.css( "color", colorLabels);
        monthLabels.css( "color", colorLabels);
        dates.css( "color", colorDates);
        item.css("background-color", backgroundColor);
    }
    // $('.label--colorLabels').attr("style", "background-color: " + colorLabels);
    // $('.label--colorDates').attr("style", "background-color: " + colorDates);


    $('#colorLabels').change(function(){
        let t = $("input[name='colorLabels']").val();
        console.log("Zmena label color " + t);
        labels.css("color", t);
        calendarTitle.css( "color", t);
        monthLabels.css("color", t);
    });
    $('#colorDates').change(function(){
        let t = $("input[name='colorDates']").val();
        console.log("Zmena dates color " + t);
        dates.css("color", t);
    });
    $('#backgroundColor').change(function(){
        let t = $("input[name='backgroundColor']").val();
        console.log("Zmena dates color " + t);
        item.css("background-color", t);
    });


    if(isNaN(type)){
        setCalendarType(1);
    }else{
        $("#wrapper-type input[value=" + type + "]").attr("checked","checked");
        setCalendarType(type);
    }

    if(isNaN(design)){
        setLabelDesign(1);
    }else{
        setLabelDesign(type);
    }
    if(isNaN(design)){
        console.log("Design: " + design);
        setCalendarDesign(0);
    }else{
        $("#wrapper-design input[value=" + design + "]").attr("checked","checked");
        console.log("Design: " + design);
        setCalendarDesign(design);
    }
    //item.addClass("design" + design);



    if($(".section--calendar-show-one").length !== 0){
        console.log("ano, toto je fakt tisk");
        if(type === 1 || type === 2){
            item.addClass("a4-portrait-print");
        }else{
            item.addClass("landscape-print");
        }
    }

    function setColorsOnChangeDesignOrType(){
        let colLab = $("#colorLabels").val();
        // console.log(colLab);
        // console.log(monthLabels);
        // console.log($(".wrapper--dates h3"));

        labels.css( "color", colLab);
        calendarTitle.css( "color", colLab);
        //monthLabels.css( "color", colLab);
        $(".wrapper--dates h3").css( "color", colLab);
        dates.css( "color", $("#colorDates").val());
        item.css("background-color", $("#backgroundColor").val());
    }

    $('#wrapper-design').change(function(){
        let t = parseInt($("input[name='design']:checked").val());
        console.log("Zmena na jiny design " + t);
        setCalendarDesign(t);
        if(t === 0){
            console.log("Zobraz custom ladeni");
            if($(".wrapper--group-radio-update").is(":visible")){
                $(this).hide();
            }
            $(".wrapper--color-text").css("display", "grid").hide().fadeIn(1000);

            setColorsOnChangeDesignOrType();
        }else{
            console.log("Skryj custom ladeni");
            $(".wrapper--color-text").hide();
            delFixColorStyle();

        }
    });

    function delFixColorStyle() {
        console.log("Mažu barvičky styly");
        labels.css("color", "");
        dates.css("color", "");
        $(".wrapper--dates h3").css("color", "");
        calendarTitle.css("color", "");
        item.css("background-color", "");
    }
    function setInputColors(t){
        let cL = $("#colorLabels");
        let cD = $("#colorDates");
        let bG = $("#backgroundColor");

        let pcL  = rgb2hex($(".design" + t + " .labels").css("color"));
        let pcD  = rgb2hex($(".design" + t + " .dates").css("color"));
        let pbG  = rgb2hex(item.css("background-color"));
        console.log(pcL);
        console.log(pcD);
        console.log(pbG);
        cL.attr("value", pcL);
        cD.attr("value", pcD);
        bG.attr("value", pbG);
    }
    function setCalendarDesign(t){
        //let item = $(".item");
        console.log("Design: " + t);
        item.removeClass (function (index, className) {
            return (className.match (/(^|\s)design\S+/g) || []).join("");
        });
        item.addClass("design" + t);
        if(t === 0){
            $(".link--calendar-custom-color").show();
        }else{
            $(".link--calendar-custom-color").hide();
        }
    }

    $(".link--type-of-calendar").click(function(){
        let type = $("#wrapper-type");
        let design = $("#wrapper-design");
        let colorText = $("#wrapper-color");
        if(type.is(":hidden")){
            if(design.is(":visible"))
                design.hide();
            if (colorText.is(":visible"))
                colorText.hide();
            type.css("display", "grid").hide().fadeIn(1000);
        }
        else
            type.fadeOut(1000);
    });
    $(".link--calendar-design").click(function(){
        let type = $("#wrapper-type");
        let design = $("#wrapper-design");
        let colorText = $("#wrapper-color");
        if(design.is(":hidden")) {
            if (type.is(":visible"))
                type.hide();
            if (colorText.is(":visible"))
                colorText.hide();
            design.css("display", "grid").hide().fadeIn(1000);
        }
        else
            design.fadeOut(1000);
    });

    $(".link--calendar-custom-color").click(function(){
        let type = $("#wrapper-type");
        let design = $("#wrapper-design");
        let colorText = $("#wrapper-color");
        if(colorText.is(":hidden")) {
            if (type.is(":visible"))
                type.hide();
            if (design.is(":visible"))
                design.hide();
            colorText.css("display", "grid").hide().fadeIn(1000);
        }
        else
            colorText.fadeOut(1000);
    });



    function setCalendarType(t){
        //let item = $(".item");
        let design = parseInt($("input[name='design']:checked").val());
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
        if(design === 0){
            console.log("Zmeni se barvy");
            setColorsOnChangeDesignOrType();
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

        let type = parseInt(body.attr("data-custom-type"));
        let name = body.attr("data-custom-name");
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

    $(window).scroll(function(){
        let heightHeader = $("header").height();
        let labVis = $('.label--item:nth-child(2)').is(":visible");
        console.log(labVis);
        console.log(heightHeader);
        if ( ($(this).scrollTop() > heightHeader) && (labVis)) {
            $('.sidebox--upload-image').addClass("sidebox--upload-image-fixed");
        } else {
            $('.sidebox--upload-image').removeClass("sidebox--upload-image-fixed");
        }
    });


    //https://stackoverflow.com/questions/1740700/how-to-get-hex-color-value-rather-than-rgb-value
    function rgb2hex(rgb) {
        if (/^#[0-9A-F]{6}$/i.test(rgb)) return rgb;

        rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
        function hex(x) {
            return ("0" + parseInt(x).toString(16)).slice(-2);
        }
        return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
    }

    $.fn.preload = function() {
        console.log("Preload image");
        this.each(function(){
            $('<img/>')[0].src = this;
        });
    };

// Usage:

    $(['/img/loginback.jpg']).preload();

})( jQuery );