(function($) {
    let autoId = parseInt("1");

    let file = $("#file");
    file.change(function(){
        for(let i = 0; i < this.files.length; i++){
            let reader = new FileReader();
            let name = $('#file')[0].files[i].name;
            reader.onload = function (e) {
                //console.log("Index: " + autoId);
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="" alt="'+ name +'" width="50" id="im' + autoId + '" draggable="true" ondragstart="dragStart(event)"/>' +
                    '<div class="wrapper wrapper--image-control">' +
                    '<a onclick="if (!(confirm(\'Tato funkce je dostupná pouze pro registrované uživatele, chcete si založit účet?\'))) return false" class="link link--full-image"></a>' +
                    '<a onclick="hideImage(this)" class="link link--delete-image"></a>' +
                    '</div></li>');
                //$('#blah').attr('src', e.target.result);
                autoId = autoId + 1;
            };

            reader.readAsDataURL(this.files[i]);
        }
    });
    file.click(function () {
        console.log(file[0].value);
        file[0].value="";
    });
})( jQuery );