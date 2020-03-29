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
    <title>Úvodní stránka</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>


<body>
<main>
    <div class="section section--login">
        <div class="sidebox sidebox--introduction">
            <h1>Návrhář kalendáře</h1>
            <p class="paragraph paragraph--introduction">
                Vyzkoušejte si návrhář na výrobu nástěnného kalendáře.<br>
                Stačí pár kroků:
            </p>
            <ol>
            <li>Nahrát fotografie</li>
            <li>Vybrat rozložení</li>
            <li>Zvolit design</li>
                <ul>
                    <li>předpřipravený</li>
                    <li>nebo vlastní</li>
                </ul>
            <li>Uložit</li>
            <li>Stáhnout do PC ve formátu pdf</li>
            </ol>
            <a href="${contextPath}/test-calendar" class="link link--test-calendar">Vyzkoušejte si návrhář</a>
        </div>
        <div class="sidebox sidebox--login">
            <form:form method="POST" action="${contextPath}/login" class="form form--login">
                <span class="form--title">Přihlášení</span>
                <span class="message">${message}</span>
                <label for="username">
                    <input id="username" name="username" type="text" class="input input--text" placeholder="Uživatelské jméno"
                           autofocus="autofocus"/>
                </label>


                <label for="password">
                    <input id="password" name="password" type="password" class="input input--password" placeholder="Heslo"/>
                </label>
                <span class="message">${error}</span>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <input type="submit" value="Přihlásit se" class="input input--submit" />
            </form:form>
            <a href="${contextPath}/registration" class="link link--registration"><span class="registration">Ještě nemáte svůj účet?</span> Registrace</a>
        </div>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

</body>
</html>