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

    <link href="${contextPath}/css/index.css" rel="stylesheet">

</head>
<body>
<header>
    <nav id="main-menu">
        <ul>
            <li>
                <a href="${contextPath}/">Domů</a>
            </li>
        </ul>
    </nav>
</header>

<main>
    <div class="section section--registration">
        <form:form method="post" modelAttribute="user" name="registration" class="form form--registration" action="/registration">
            <span class="form--title">Registrace nového uživatele</span>
            <form:hidden path="id" />

            <spring:bind path="username">
                <form:input type="text" path="username" class="input input--text" placeholder="Uživatelské jméno" autofocus="true" />

            </spring:bind>

            <spring:bind path="email">
                <form:input type="text" path="email" class="input input--text" placeholder="Email" />

            </spring:bind>

            <spring:bind path="password">
                <form:input type="password" path="password" id="password" class="input input--password" placeholder="Heslo" />

            </spring:bind>

            <spring:bind path="passwordConfirm">
                <form:input type="password" path="passwordConfirm" class="input input--password" placeholder="Potvrzení hesla" />

            </spring:bind>

            <form:button class="input input--submit">Registrovat</form:button>

            <form:errors path="username" />
            <form:errors path="email" />
            <form:errors path="password" />
            <form:errors path="passwordConfirm" />
        </form:form>
    </div>
</main>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
<script src="../js/form-validation.js"></script>

</body>
</html>