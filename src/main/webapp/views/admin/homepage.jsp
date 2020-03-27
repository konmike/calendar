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
    <title>Úvodní ADMIN stránka</title>

    <link href="${contextPath}/css/style.css" rel="stylesheet">
    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body>
<header>
    <nav id="main-menu">
        <ul>
            <li>
                <span class="active">Domů</span>
            </li>
            <li>
                <a href="${contextPath}/calendar/create">Nový kalendář</a>
            </li>
            <li>
                <a href="${contextPath}/calendar/myCalendars">Mé kalendáře</a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/list-calendars">Kalendáře</a>
                </li>
            </security:authorize>
    </nav>
    <jsp:include page="../parts/user-menu.jsp" />
</header>

<main>
    <div class="section section--admin-homepage">
        <div class="sidebox sidebox--admin-search-users">
            <form action="${contextPath}/admin" class="form form--search">
                <label for="search">
                    <input type="text" class="input input--text input--search" autofocus id="search" name="name" placeholder="Hledání uživatele" />
                </label>
                <input type="submit" value="Hledat" class="input input--submit" />
                <a href="${contextPath}/admin/create-user" class="link link--create-user">Vytvořit uživatele</a>
            </form>
            <table class="table table--users">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Jméno</th>
                    <th>E-mail</th>
                    <th>Admin</th>
                    <th>Editace</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="databaseUser" items="${users}">
                    <c:url var="updateLink" value="/user/update">
                        <c:param name="id" value="${databaseUser.id}" />
                    </c:url>

                    <c:url var="deleteLink" value="/user/delete">
                        <c:param name="userId" value="${databaseUser.id}" />
                    </c:url>

                    <c:if test="${databaseUser.username != pageContext.request.userPrincipal.name}">
                        <c:set var="isAdmin" scope="request" value="${databaseUser.admin}"/>
                        <tr>
                            <td>${databaseUser.id}</td>
                            <td>${databaseUser.username}</td>
                            <td>${databaseUser.email}</td>
                            <td><span class="<c:out default="admin-icon-no" escapeXml="true" value="${isAdmin ? 'admin-icon-yes' : 'admin-icon-no'}" />"></span></td>
                            <td>
                                <a href="${updateLink}" class="link link--edit-user">Úpravy</a>
                                <a href="${deleteLink}" class="link link--delete-user"
                                   onclick="if (!(confirm('Opravdu chceš smazat uživatele ${databaseUser.username} ?'))) return false">Smazat</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/js/menu.js"></script>
</body>
</html>