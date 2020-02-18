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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="utf-8">
    <title>Přihlašovací formulář</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">
</head>


<body>
<main>
    <form:form method="POST" action="${contextPath}/login">
            <span class="form--title">Přihlašovací formulář</span>
            <span class="message">${message}</span>
            <label for="username">
                <input id="username" name="username" type="text" placeholder="Uživatelské jméno"
                       autofocus="true"/>
            </label>


            <label for="password">
                <input id="password" name="password" type="password" placeholder="Heslo"/>
            </label>
            <span class="message">${error}</span>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <input type="submit" value="Přihlásit se" />
    </form:form>
</main>

<footer>
    <span>Ještě nemáte svůj účet? <a href="${contextPath}/registration">Registrace</a></span>
</footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>