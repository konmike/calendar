<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 07.12.19
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="utf-8">
    <title>Vítejte</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li>
                    <span class="active">Domů</span>
                </li>
                <li>
                    <c:url var="updateLink" value="/user/update">
                        <c:param name="username" value="${pageContext.request.userPrincipal.name}" />
                    </c:url>
                    <a href="${updateLink}">Editovat účet</a>
                </li>
                <li>
                    <a href="${contextPath}/image/">Editace galerie</a>
                </li>
                <li>
                    <a href="${contextPath}/image/search?name=${pageContext.request.userPrincipal.name}">Zobrazit galerii</a>
                </li>
                <security:authorize access="hasRole('ROLE_ADMIN')">
                    <li>
                        <a href="${contextPath}/users/list">Editace uživatelů</a>
                    </li>
                    <li>
                        <a href="${contextPath}/admin/list-gallery">Editace galerií</a>
                    </li>
                </security:authorize>
            </ul>
        </nav>
    </header>

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
        </ul>
    </footer>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>