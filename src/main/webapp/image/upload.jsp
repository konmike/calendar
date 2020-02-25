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
    <title>Editace galerie</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/simple-lightbox.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">
</head>
<script>
    function dragStart(ev) {
        ev.dataTransfer.effectAllowed='move';
        ev.dataTransfer.setData("Text", ev.target.getAttribute('id'));
        ev.dataTransfer.setDragImage(ev.target,100,100);
        return true;
    }
    function dragEnter(ev) {
        event.preventDefault();
        return true;
    }
    function dragOver(ev) {
        event.preventDefault();
    }
    function dragDrop(ev) {
        var data = ev.dataTransfer.getData("Text");
        ev.target.prepend(document.getElementById(data));
        ev.stopPropagation();
        return false;
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
                <span class="active">Editace galerie</span>
            </li>
            <li>
                <a href="${contextPath}/image/search?name=${pageContext.request.userPrincipal.name}">Tvorba kalendáře</a>
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
    <div class="calendar">
        <form:form method="post" modelAttribute="files" enctype="multipart/form-data" class="form form--upload-image" action="/image/">
                <span class="form--title">Editace galerie</span>
                <label for="file" class="label label--file">
                    <input type="file" id="file" name="file" class="input input--file" />
                    <span class="file--custom"></span>
                </label>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="submit" class="input input--submit" value="Nahrát" />
        </form:form>

        <ul class="list list--gallery" ondragenter="return dragEnter(event)"
            ondrop="return dragDrop(event)"
            ondragover="return dragOver(event)">
            <h3>Vase obrazky k vyberu:</h3>
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

        <form:form method="post" action="/calendar/create" class="form--create-calendar">
            <label for="item1">
                <input type="checkbox" id="item1"/>
                <div class="item item--1" ondragenter="return dragEnter(event)"
                     ondrop="return dragDrop(event)"
                     ondragover="return dragOver(event)">
                    <span>1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30</span>
                </div>
            </label>
            <label for="item2">
                <input type="checkbox" id="item2" />
                <div class="item item--2" ondragenter="return dragEnter(event)"
                     ondrop="return dragDrop(event)"
                     ondragover="return dragOver(event)">
                    <span>1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30</span>
                </div>
            </label>
            <label for="item3">
                <input type="checkbox" id="item3" />
                <div class="item item--3" ondragenter="return dragEnter(event)"
                     ondrop="return dragDrop(event)"
                     ondragover="return dragOver(event)">
                    <span>1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30</span>
                </div>
            </label>
            <input type="submit" class="input input--submit" value="Vytvořit" />
        </form:form>
<%--    <ul class="list list--gallery">--%>
<%--        <c:forEach var="file" items="${files}">--%>
<%--        <li class="list--item">--%>
<%--            <img src="${file}" height="200" alt="image"/>--%>
<%--            <a href="${file}">Zvětšit</a>--%>



<%--            <form:form action="/image/delete" method="POST" class="form form--delete-image">--%>

<%--                <input type="hidden" value="${file}" name="name" readonly="readonly" />--%>
<%--                <input type="hidden" name="${_csrf.parameterName}"--%>
<%--                       value="${_csrf.token}" />--%>

<%--                <input type="submit" class="input input--submit" value="Smazat" />--%>

<%--            </form:form>--%>
<%--        </li>--%>
<%--        </c:forEach>--%>
<%--    </ul>--%>
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
<script src="${contextPath}/resources/js/script.js"></script>
<script src="${contextPath}/resources/js/simple-lightbox.jquery.js"></script>
<script>
    (function($) {
        $('.gallery a').simpleLightbox({ /* options */ });
    })( jQuery );

</script>

</body>
</html>