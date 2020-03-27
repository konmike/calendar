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

    ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", src);
    //ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("checked", "checked");
    ev.target.removeAttribute("ondragenter");
    ev.target.removeAttribute("ondrop");
    ev.target.removeAttribute("ondragover");
    ev.target.removeAttribute("ondragleave");
    ev.target.setAttribute("onclick", "deleteImage(event)");
    ev.target.classList.replace("border-hover","border-no");
    ev.target.classList.add("wrapper-image-after");
    ev.target.firstElementChild.setAttribute("draggable", "false");
    ev.target.firstElementChild.removeAttribute("ondragstart");
    ev.target.firstElementChild.removeAttribute("width");
    ev.stopPropagation();
    return false;
}

function deleteImage(ev) {
    ev.target.setAttribute("ondragenter", "return dragEnter(event)");
    ev.target.setAttribute("ondrop", "return dragDrop(event)");
    ev.target.setAttribute("ondragover", "return dragOver(event)");
    ev.target.setAttribute("ondragleave", "return dragLeave(event)");

    ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", "null");
    ev.target.parentElement.previousElementSibling.previousElementSibling.removeAttribute("checked");
    ev.target.parentElement.previousElementSibling.previousElementSibling.checked = false;

    ev.target.classList.replace("border-no","border");
    ev.target.classList.remove("wrapper-image-after");
    ev.target.firstElementChild.remove();
    ev.target.setAttribute("onclick", "protectCheck(event)");
}
function protectCheck(ev){
    ev.target.parentElement.previousElementSibling.previousElementSibling.removeAttribute("checked");
    ev.target.parentElement.previousElementSibling.previousElementSibling.checked = false;
}