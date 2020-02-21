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
    <title>Galerie</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
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
                <a href="${contextPath}/image/">Editace galerie</a>
            </li>
            <li>
                <span class="active">Tvorba kalendáře</span>
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
<%--    <c:forEach var="user" items="${user.username}">--%>
<%--        <ul th:each="user : ${user}">--%>
<%--            <h1 align="center">--%>
<%--                    ${user}'s photos'--%>
<%--            </h1>--%>
<%--        </ul>--%>
<%--    </c:forEach>--%>

    <form:form action="${contextPath}/calendar/" modelAttribute="cal" method="post">
        <span class="form--title">Tvorba kalendáře</span>
        <form:label path="name" for="name">
            <form:input type="text" id="name" path="name" placeholder="Název kalendáře" />
        </form:label>
        <spring:bind path="year">
        <label for="year">
            <form:input type="number" path="year" id="year" placeholder="Rok" />
        </label>
        </spring:bind>
        <span>Vyberte si 12 obrázků z vaší galerie:</span>
        <ul th:each="file : ${cal.selImage}">
            <c:forEach items="${cal.selImage}" var="file">
                <li class="gallery">
                    <form:label path="selImage" for="${file}">
                        <form:checkbox path="selImage" value="${file}" id="${file}" />
                        <img src="${file}" height="200" />
                    </form:label>
                </li>
            </c:forEach>
        </ul>
        <form:button>Vytvořit kalendář</form:button>
    </form:form>

    <c:if test="${not empty user.calendars}">
        <c:forEach items="${user.calendars}" var="calendar">
            <ul>
                <li>${calendar.name}</li>
            </ul>
        </c:forEach>
    </c:if>
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