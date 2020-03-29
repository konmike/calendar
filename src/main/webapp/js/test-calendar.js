(function($) {
    let autoId = 1;

    let file = $("#file");
    file.change(function(){
        for(let i = 0; i < this.files.length; i++){
            let reader = new FileReader();
            let name = $('#file')[0].files[i].name;
            reader.onload = function (e) {
                $('.list--gallery').append(
                    '<li class="list--item">' +
                    '<img src="' + e.target.result + '" class="" alt="'+ name +'" width="200" id="im' + autoId + '" draggable="true" ondragstart="dragStart(event)"/>' +
                    '<a href="' + e.target.result +'" class="link link--full-image">Zvětšit</a>' +
                    '<a onclick="hideImage(this)" class="link link--delete-image">Smazat</a>' +
                    '</li>');
                //$('#blah').attr('src', e.target.result);
            };
            autoId++;
            reader.readAsDataURL(this.files[i]);
        }
    });
    file.click(function () {
        console.log(file[0].value);
        file[0].value="";
    });
})( jQuery );