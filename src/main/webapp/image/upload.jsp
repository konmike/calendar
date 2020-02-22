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
    <form:form method="post" modelAttribute="files" enctype="multipart/form-data" class="form form--upload-image" action="/image/">
            <span class="form--title">Editace galerie</span>
            <label for="file" class="label label--file">
                <input type="file" id="file" name="file" class="input input--file" />
                <span class="file--custom"></span>
            </label>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="submit" class="input input--submit" value="Nahrát" />
    </form:form>

    <ul class="list list--gallery">
        <c:forEach var="file" items="${files}">
        <li class="list--item">
            <img src="${file}" height="200" alt="image"/>
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