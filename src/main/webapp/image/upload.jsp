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

        ev.target.parentElement.previousElementSibling.previousElementSibling.setAttribute("value", "null");

        ev.target.classList.replace("border-no","border");
        ev.target.classList.remove("wrapper-image-after");
        ev.target.firstElementChild.remove();
    }

</script>
<body data-custom-year="${cal.year}" data-custom-offset="${cal.offset}" data-custom-lang="${cal.lang}">
<header>
    <nav>
        <ul>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/calendar/deleteNullCalendar?calId=${cal.id}&redir=${contextPath}/admin/"
                       onclick="if (!(confirm('Kalendář není uložen, chcete přesto pokračovat?'))) return false">Domů</a>
                </li>
            </security:authorize>
            <security:authorize access="!hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/calendar/deleteNullCalendar?calId=${cal.id}&redir=${contextPath}/"
                       onclick="if (!(confirm('Kalendář není uložen, chcete přesto pokračovat?'))) return false">Domů</a>
                </li>
            </security:authorize>
            <li>
                <span class="active">Tvorba kalendáře</span>
            </li>
            <li>
                <a href="${contextPath}/calendar/deleteNullCalendar?calId=${cal.id}&redir=${contextPath}/calendar/myCalendars"
                   onclick="if (!(confirm('Kalendář není uložen, chcete přesto pokračovat?'))) return false">Mé kalendáře</a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/calendar/deleteNullCalendar?calId=${cal.id}&redir=${contextPath}/admin/list-gallery"
                       onclick="if (!(confirm('Kalendář není uložen, chcete přesto pokračovat?'))) return false">Editace galerií</a>
                </li>
            </security:authorize>
        </ul>
    </nav>
</header>

<main>
    <div class="section section--calendar-create">
        <div class="sidebox sidebox--upload-image">
            <form:form method="post" enctype="multipart/form-data" class="form form--upload-image" action="/image/?calId=${cal.id}">
                    <label for="file" class="label label--file">
                        <input type="file" id="file" name="files" class="input input--file" multiple />
                        <span class="file--custom"></span>
                    </label>
                    <div class="preview-gallery"></div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="calId" value="${cal.id}" />
                            <input type="submit" class="input input--submit" value="Nahrát" />
            </form:form>

            <ul class="list list--gallery">
                <h3>Vaše obrázky k výběru:</h3>

                <c:forEach varStatus="item" var="image" items="${cal.images}">
                    <li class="list--item">
                        <img src="${image.path}" draggable="true" ondragstart="return dragStart(event)" width="200" alt="${image.name}" id="image${item.index}"/>
                        <a href="${image.path}">Zvětšit</a>

                        <form:form action="/image/delete" method="POST" class="form form--delete-image">
                            <input type="hidden" value="${cal.id}" name="calId" readonly="readonly" />
                            <input type="hidden" value="${image.id}" name="imgId" readonly="readonly" />
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
                    <div class="pagination pagination--control">
                        <a id="prev">Předchozí</a>
                        <a id="next">Další</a>
                    </div>

                    <c:forEach begin="0" end="12" varStatus="item">
                        <c:choose>
                            <c:when test="${item.index == '0'}">
                                <form:label path="selImage" for="item0" class="label label--item label--item-0">
                                    <form:checkbox path="selImage" id="item0" class="input input--checkbox" value="null" checked="checked"/>
                                    <div class="item item--0 a4-portrait">
                                        <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                             ondragenter="return dragEnter(event)"
                                             ondrop="return dragDrop(event)"
                                             ondragover="return dragOver(event)"
                                             ondragleave="return dragLeave(event)"></div>
                                    </div>
                                </form:label>
                            </c:when>
                            <c:otherwise>
                                <form:label path="selImage" for="item${item.index}" class="label label--item label--item-${item.index}">
                                    <form:checkbox path="selImage" id="item${item.index}" class="input input--checkbox" value="null" checked="checked"/>
                                    <div class="month month--${item.index} item a4-portrait">
                                        <div onclick="deleteImage(event)" class="wrapper wrapper-image border"
                                             ondragenter="return dragEnter(event)"
                                             ondrop="return dragDrop(event)"
                                             ondragover="return dragOver(event)"
                                             ondragleave="return dragLeave(event)"></div>
                                        <div class="labels"></div>
                                        <div class="dates"></div>
                                    </div>
                                </form:label>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <form:label path="id" for="id">
                        <form:input type="hidden" id="id" path="id"/>
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
                        <form:select path="lang" id="lang" class="${cal.lang}">
                            <c:choose>
                                <c:when test="${(empty cal.lang)}">
                                    <option value="cs" selected>Čeština</option>
                                    <option value="en">English</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="cs">Čeština</option>
                                    <option value="en" selected>English</option>
                                </c:otherwise>
                            </c:choose>
                        </form:select>
                    </form:label>


                    <form:label path="offset" for="offset">Týden začíná:
                        <form:select path="offset" id="offset">
                        <c:choose>
                            <c:when test="${(cal.offset == '0')}">
                                <option value="1" selected>Pondělí</option>
                                <option value="7">Neděle</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">Pondělí</option>
                                <option value="7" selected>Neděle</option>
                            </c:otherwise>
                        </c:choose>
                        </form:select>
                    </form:label>

                </div>
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}" />
                <input type="submit" class="input input--submit" value="Vytvořit" />
            </form:form>
            <a class="show-full-calendar">Celý kalendář</a>
            <a class="show-page-calendar">Stránkový kalendář</a>
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