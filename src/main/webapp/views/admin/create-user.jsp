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
    <title>ADMIN - Nový uživatel</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body>
<header>
    <nav id="main-menu">
        <ul>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin">Domů</a>
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
    <jsp:include page="../parts/user-menu.jsp" />
</header>

<main>
    <div class="section section--user-create">
        <form:form method="post" modelAttribute="newUser" name="registration" class="form form--registration" action="/admin/create-user">
            <span class="form--title">Vytvoření nového uživatele</span>
            <form:hidden path="id" />

            <spring:bind path="username">
                <form:input type="text" path="username" class="input input--text" placeholder="Uživatelské jméno" autofocus="true" />

            </spring:bind>

            <spring:bind path="email">
                <form:input type="text" path="email" class="input input--text" placeholder="E-mail" />

            </spring:bind>

            <spring:bind path="password">
                <form:input type="password" id="password" path="password" class="input input--password" placeholder="Heslo" />

            </spring:bind>

            <spring:bind path="passwordConfirm">
                <form:input type="password" path="passwordConfirm" class="input input--password" placeholder="Potvrzení hesla" />

            </spring:bind>

            <form:label path="admin" for="admin" cssClass="label label--admin">
                <form:checkbox path="admin" id="admin" value="1" name="admin" class="checkbox checkbox--isAdmin"/>
                <span>Admin role</span>
            </form:label>

            <form:button class="input input--submit">Vytvořit</form:button>

            <form:errors path="username" />
            <form:errors path="email" />
            <form:errors path="password" />
            <form:errors path="passwordConfirm" />
        </form:form>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../../js/menu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
<script src="../../js/form-validation.js"></script>
</body>
</html>