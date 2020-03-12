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
    <title>Vytvoření nového uživatele</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">

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
        </ul>
    </nav>
</header>

<main>
    <form:form method="post" modelAttribute="user" class="form form--registration" action="/admin/create-user">
        <span class="form--title">Vytvoření nového uživatele</span>
        <form:hidden path="id" />

        <spring:bind path="username">
            <form:input type="text" path="username" class="input input--text" placeholder="Uivatelské jméno" autofocus="true" />
            <form:errors path="username" />
        </spring:bind>

        <spring:bind path="email">
            <form:input type="text" path="email" class="input input--text" placeholder="Email" />
            <form:errors path="email" />
        </spring:bind>

        <spring:bind path="password">
            <form:input type="password" path="password" class="input input--password" placeholder="Heslo" />
            <form:errors path="password" />
        </spring:bind>

        <spring:bind path="passwordConfirm">
            <form:input type="password" path="passwordConfirm" class="input input--password" placeholder="Potvrzení hesla" />
            <form:errors path="passwordConfirm" />
        </spring:bind>

        <form:label path="admin" for="admin">
            <form:checkbox path="admin" id="admin" value="1" name="admin" class="checkbox checkbox--isAdmin"/>
            <span>Admin role</span>
        </form:label>

        <form:button class="input input--submit">Vytvořit</form:button>
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