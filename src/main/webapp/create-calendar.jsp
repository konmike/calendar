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
                <span class="active">Nový kalendář</span>
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
    <div class="section section--calendar-create">
        <form:form method="post" enctype="multipart/form-data" action="/calendar/create" modelAttribute="cal" cssClass="form form--calendar-create">

                <form:label path="id" for="id">
                    <form:input type="hidden" id="id" path="id"/>
                </form:label>

                <form:label path="images" for="images">
                    <form:input type="hidden" id="images" path="images"/>
                </form:label>

                <form:label path="name" for="name" cssClass="label label--calendar-option label--name">Název kalendáře
                    <form:input type="text" id="name" path="name" cssClass="input input--text" placeholder="Název kalendáře" />
                </form:label>

                <spring:bind path="year">
                    <label for="year" class="label label--calendar-option label--year">Rok
                        <form:input type="number" path="year" id="year" cssClass="input input--number" value="2020" placeholder="Rok" />
                    </label>
                </spring:bind>

                <form:label path="lang" for="lang" cssClass="label label--calendar-option label--lang">Popisky
                    <form:select path="lang" id="lang" cssClass="select select--lang">
                        <option value="cs" selected>ČEŠTINA</option>
                        <option value="en">ANGLIČTINA</option>
                    </form:select>
                </form:label>

                <form:label path="offset" for="offset" cssClass="label label--calendar-option label--offset">Týden začíná
                    <form:select path="offset" id="offset" cssClass="select select--offset">
                        <option value="1" selected>PONDĚLÍ</option>
                        <option value="7">NEDĚLE</option>
                    </form:select>
                </form:label>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="submit" class="input input--submit" value="Vytvořit" />
        </form:form>
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