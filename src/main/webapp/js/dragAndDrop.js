function dragStart(ev) {
    ev.dataTransfer.effectAllowed='copyMove';
    ev.dataTransfer.setData("Text", ev.target.getAttribute('id'));
    ev.dataTransfer.setDragImage(ev.target,100,100);
    return true;
}
function dragEnter(ev) {
    event.preventDefault();
    return true;
}
function dragOver(ev) {
    ev.target.classList.replace("border","border-hover");
    event.preventDefault();
}
function dragLeave(ev) {
    ev.target.classList.replace("border-hover","border");
    event.preventDefault();
}
function dragDrop(ev) {
    //var autoId = 1;
    var data = ev.dataTransfer.getData("Text");

    var nodeCopy = document.getElementById(data).cloneNode(true);
    nodeCopy.id = "im" + Math.ceil(Math.random() * 1000); /* We cannot use the same ID */
    ev.target.appendChild(nodeCopy);

    //console.log()
    ev.target.prepend(document.getElementById(nodeCopy.id));
    var src = document.getElementById(nodeCopy.id).getAttribute("src");
    // console.log(src);
    // //
    // console.log(ev.target);
    // console.log(ev.target.parentElement.previousElementSibling);
    // console.log(ev.parentElement);

    ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", src);
    //ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("checked", "checked");
    ev.target.removeAttribute("ondragenter");
    ev.target.removeAttribute("ondrop");
    ev.target.removeAttribute("ondragover");
    ev.target.removeAttribute("ondragleave");
    ev.target.setAttribute("onclick", "deleteImage(event)");
    ev.target.classList.replace("border-hover","border-no");
    ev.target.classList.add("wrapper--image-after");
    ev.target.firstElementChild.setAttribute("draggable", "false");
    ev.target.firstElementChild.removeAttribute("ondragstart");
    ev.target.firstElementChild.removeAttribute("width");
    ev.stopPropagation();
    return false;
}

function deleteImage(ev) {
    // console.log(ev.target);
    ev.target.setAttribute("ondragenter", "return dragEnter(event)");
    ev.target.setAttribute("ondrop", "return dragDrop(event)");
    ev.target.setAttribute("ondragover", "return dragOver(event)");
    ev.target.setAttribute("ondragleave", "return dragLeave(event)");

    // console.log(ev.target.parentElement.previousElementSibling);
    // console.log(ev.target.parentElement);
    ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", "null");
    // ev.target.parentElement.previousElementSibling.removeAttribute("checked");
    // ev.target.parentElement.previousElementSibling.checked = false;

    ev.target.classList.replace("border-no","border");
    ev.target.classList.remove("wrapper--image-after");
    ev.target.firstElementChild.remove();
    // ev.target.setAttribute("onclick", "protectCheck(event)");
    ev.preventDefault();
}

function hideImage(e){
    if (!(confirm('Opravdu chcete obrázek smazat?')))
        return false;
    else{
        let el = e.parentElement.parentElement;
        el.parentNode.removeChild(el);
        let errors = document.getElementById("file.errors");
        errors.innerText = "";
        errors.setAttribute("style", "background-color: transparent");

        // e.parentElement.parentElement.setAttribute("style", "display:none");
        // console.log(e.parentElement);
        //e.target.parentElement
    }
}