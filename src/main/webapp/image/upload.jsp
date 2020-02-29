<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 07.12.19
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="utf-8">
    <title>Tvorba kalendáře</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/simple-lightbox.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
<%--    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">--%>

</head>
<script>
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
        ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("checked", "checked");
        ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", src);
        ev.target.removeAttribute("ondragenter");
        ev.target.removeAttribute("ondrop");
        ev.target.removeAttribute("ondragover");
        ev.target.removeAttribute("ondragleave");
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

        ev.target.parentElement.previousElementSibling.previousElementSibling.removeAttribute("checked");
        ev.target.parentElement.previousElementSibling.previousElementSibling.removeAttribute("value");

        ev.target.classList.replace("border-no","border");
        ev.target.classList.remove("wrapper-image-after");
        ev.target.firstElementChild.remove();
    }
</script>
<body>
<header>
    <nav>
        <ul>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/">Domů</a>
                </li>
            </security:authorize>
            <security:authorize access="!hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/">Domů</a>
                </li>
            </security:authorize>
            <li>
                <span class="active">Tvorba kalendáře</span>
            </li>
            <li>
                <a href="${contextPath}/calendar/myCalendars">Mé kalendáře</a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/list-gallery">Editace galerií</a>
                </li>
            </security:authorize>
        </ul>
    </nav>
</header>

<main>
    <h2 class="">Tvorba kalendáře</h2>
    <div class="section section--calendar-create">
        <div class="sidebox sidebox--upload-image">
            <form:form method="post" modelAttribute="files" enctype="multipart/form-data" class="form form--upload-image" action="/image/">
                    <label for="file" class="label label--file">
                        <input type="file" id="file" name="file" class="input input--file" />
                        <span class="file--custom"></span>
                    </label>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" class="input input--submit" value="Nahrát" />
            </form:form>

            <ul class="list list--gallery" ondragenter="return dragEnter(event)"
                ondrop="return dragDrop(event)"
                ondragover="return dragOver(event)"
                ondragleave="return dragLeave(event)">
                <h3>Vaše obrázky k výběru:</h3>
                <c:forEach var="file" items="${files}">
                    <li class="list--item" >
                        <img src="${file}" draggable="true" ondragstart="return dragStart(event)" height="200" alt="image" id="im1"/>
                        <a href="${file}">Zvětšit</a>

                        <form:form action="/image/delete" method="POST" class="form form--delete-image">

                            <input type="hidden" value="${file}" name="name" readonly="readonly" />
                            <input type="hidden" name="${_csrf.parameterName}"
                                   value="${_csrf.token}" />

                            <input type="submit" class="input input--submit" value="Smazat" />

                        </form:form>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="sidebox sidebox--calendar-preview">
            <form:form method="post" action="/calendar/create" modelAttribute="cal" class="form--calendar-create">
                <div id="calendar">
                    <div class="pagination pagination-control">
                        <a class="link title active" href="#">Titulní strana</a>
                        <a class="link january" href="#">Leden</a>
                        <a class="link february" href="#">Únor</a>
                        <a class="link march" href="#">Březen</a>
                        <a class="link april" href="#">Duben</a>
                        <a class="link may" href="#">Květen</a>
                        <a class="link june" href="#">Červen</a>
                        <a class="link july" href="#">Červenec</a>
                        <a class="link august" href="#">Srpen</a>
                        <a class="link september" href="#">Září</a>
                        <a class="link october" href="#">Říjen</a>
                        <a class="link november" href="#">Listopad</a>
                        <a class="link december" href="#">Prosinec</a>
                    </div>

                    <form:label path="selImage" for="item0" class="label label--item label--item-0">
                        <form:checkbox path="selImage" id="item0" class="input input--checkbox" value=""/>
                        <div class="item item--0 a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                        </div>

                    </form:label>

                    <form:label path="selImage" for="item1" class="label label--item label--item-1">
                        <form:checkbox path="selImage" id="item1" class="input input--checkbox" value=""/>
                        <div class="month month--1 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item2" class="label label--item label--item-2">
                        <form:checkbox path="selImage" id="item2" class="input input--checkbox" value=""/>
                        <div class="month month--2 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item3" class="label label--item label--item-3">
                        <form:checkbox path="selImage" id="item3" class="input input--checkbox" value="" />
                        <div class="month month--3 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item4" class="label label--item label--item-4">
                        <form:checkbox path="selImage" id="item4" class="input input--checkbox" value="" />
                        <div class="month month--4 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item5" class="label label--item label--item-5">
                        <form:checkbox path="selImage" id="item5" class="input input--checkbox" value="" />
                        <div class="month month--5 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item6" class="label label--item label--item-6">
                        <form:checkbox path="selImage" id="item6" class="input input--checkbox" value="" />
                        <div class="month month--6 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item7" class="label label--item label--item-7">
                        <form:checkbox path="selImage" id="item7" class="input input--checkbox" value="" />
                        <div class="month month--7 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item8" class="label label--item label--item-8">
                        <form:checkbox path="selImage" id="item8" class="input input--checkbox" value="" />
                        <div class="month month--8 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item9" class="label label--item label--item-9">
                        <form:checkbox path="selImage" id="item9" class="input input--checkbox" value="" />
                        <div class="month month--9 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"  ondragenter="return dragEnter(event)"
                             ondrop="return dragDrop(event)"
                             ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item10" class="label label--item label--item-10">
                        <form:checkbox path="selImage" id="item10" class="input input--checkbox" value="" />
                        <div class="month month--10 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                ondragenter="return dragEnter(event)"
                                ondrop="return dragDrop(event)"
                                ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item11" class="label label--item label--item-11">
                        <form:checkbox path="selImage" id="item11" class="input input--checkbox" value="" />
                        <div class="month month--11 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>
                    <form:label path="selImage" for="item12" class="label label--item label--item-12">
                        <form:checkbox path="selImage" id="item12" class="input input--checkbox" value="" />
                        <div class="month month--12 item a4-portrait">
                            <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                 ondragenter="return dragEnter(event)"
                                 ondrop="return dragDrop(event)"
                                 ondragover="return dragOver(event)"
                                 ondragleave="return dragLeave(event)"></div>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </form:label>

                    <form:label path="name" for="name">
                        <form:input type="text" id="name" path="name" class="input input--text" placeholder="Název kalendáře" />
                    </form:label>

                    <spring:bind path="year">
                        <label for="year">
                            <form:input type="number" path="year" id="year" class="input input--number" value="2020" placeholder="Rok" />
                        </label>
                    </spring:bind>


                    <form:label path="lang" for="lang">Jazyk:
                        <form:select path="lang" id="lang">
                            <option value="cs" selected>Čeština</option>
                            <option value="en">English</option>
                        </form:select>
                    </form:label>


                    <form:label path="offset" for="offset">Týden začíná:
                        <form:select path="offset" id="offset">
                            <option value="1" selected>Pondělí</option>
                            <option value="0">Neděle</option>
                        </form:select>
                    </form:label>

                </div>
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}" />
                <input type="submit" class="input input--submit" value="Vytvořit" />
            </form:form>
        </div>
    </div>
</main>

<footer>
    <ul>
        <li>
            <span>Přihlášen jako ${pageContext.request.userPrincipal.name}</span>
        </li>
        <li>
            <form:form id="logoutForm" method="POST" action="${contextPath}/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Odhlásit se" />
            </form:form>
        </li>
        <li>
            <c:url var="updateLink" value="/user/update">
                <c:param name="username" value="${pageContext.request.userPrincipal.name}" />
            </c:url>
            <a href="${updateLink}">Změnit heslo</a>
        </li>
    </ul>
</footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://unpkg.com/calendarize"></script>
<script src="https://unpkg.com/sublet"></script>
<script src="${contextPath}/resources/js/calendar.js"></script>
<script src="${contextPath}/resources/js/script.js"></script>

<script src="${contextPath}/resources/js/simple-lightbox.jquery.js"></script>
<script>
    (function($) {
        $('.gallery a').simpleLightbox({ /* options */ });
    })( jQuery );

</script>

</body>
</html>