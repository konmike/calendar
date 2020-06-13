<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 17.05.20
  Time: 10:31
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
    <title>Přístup zamítnut</title>

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
</header>

<main>
    <div class="section section--custom-error">
        <h3>Mrzí nás to, ale byl vám odepřen přístup.</h3>
        <h4>Pro vstup do dané části aplikace pravděpodobně
        nemáte dostatečná oprávnění.</h4>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${contextPath}/js/script.js"></script>
<script src="${contextPath}/js/menu.js"></script>

</body>
</html>