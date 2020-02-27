<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 08.12.19
  Time: 14:08
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
    <title>Admin - edit uivatelů</title>

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
                <a href="${contextPath}/image/">Tvorba kalendáře</a>
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
    <form action="${contextPath}/admin" class="form form--search">
        <label for="search">
            <input type="text" class="input input--text input--search" autofocus id="search" name="name" placeholder="Hledání uživatele" />
        </label>
        <input type="submit" value="Hledat" class="input input--submit" />
    </form>
    <table class="table table--users">
        <thead>
        <tr>
            <th>Id</th>
            <th>Jméno</th>
            <th>Editace</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">

            <c:url var="updateLink" value="/user/update">
                <c:param name="username" value="${user.username}" />
            </c:url>

            <c:url var="deleteLink" value="/user/delete">
                <c:param name="userId" value="${user.id}" />
            </c:url>

            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>
                    <a href="${updateLink}">Úpravy</a>/
                    <a href="${deleteLink}"
                       onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Smazat</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>