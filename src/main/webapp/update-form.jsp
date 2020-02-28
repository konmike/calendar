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
    <title>Editace uživatele</title>

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
    <form:form method="post" action="${contextPath}/updateUser" modelAttribute="user" class="form form--update">
        <span class="form--title">Změnit heslo</span>

        <form:hidden path="id"/>
        <form:hidden path="username"/>
        <form:hidden path="password"/>
<%--        <form:hidden path="calendars"/>--%>
<%--        <form:hidden path="imageList"/>--%>

        <spring:bind path="oldPassword">
            <div class="form-group">
                <form:input path="oldPassword" type="password" autofocus="autofocus" id="oldPassword" name="oldPassword" class="input input--password" placeholder="Původní heslo" value="" />
                <form:errors path="oldPassword" />
            </div>
        </spring:bind>

        <spring:bind path="newPassword">
            <div class="form-group">
                <form:input path="newPassword" type="password" id="newPassword" name="newPassword" class="input input--password" placeholder="Nové heslo" value="" />
                <form:errors path="newPassword" />
            </div>
        </spring:bind>

        <spring:bind path="passwordConfirm">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="passwordConfirm" class="input input--password" placeholder="Potvrzení nového hesla" />
                <form:errors path="passwordConfirm" />
            </div>
        </spring:bind>

        <form:button class="input input--submit">Aktualizovat údaje</form:button>
    </form:form>
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
            <span class="active">Změnit heslo</span>
        </li>
    </ul>
</footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>