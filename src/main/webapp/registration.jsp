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
    <title>Registrace nového uživatele</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">
</head>
<body>
<header>
    <nav>
        <ul>
            <li>
                <a href="${contextPath}/">Domů</a>
            </li>
        </ul>
    </nav>
</header>

<main>
    <form:form method="post" modelAttribute="userForm" class="form-signin" action="/registration">
        <span class="form--title">Registrace nového uživatele</span>
        <form:hidden path="id" />

        <spring:bind path="username">
                <form:input type="text" path="username" class="form-control" placeholder="Uivatelské jméno"
                            autofocus="true" />
                <form:errors path="username" />
        </spring:bind>

        <spring:bind path="password">
                <form:input type="password" path="password" class="form-control" placeholder="Heslo" />
                <form:errors path="password" />
        </spring:bind>

        <spring:bind path="passwordConfirm">
                <form:input type="password" path="passwordConfirm" class="form-control"
                            placeholder="Potvrzení hesla" />
                <form:errors path="passwordConfirm" />
        </spring:bind>

        <form:button>Registrovat</form:button>
    </form:form>

</main>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>