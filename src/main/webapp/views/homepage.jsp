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
    <title>Vítejte</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
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
            </ul>
        </nav>
        <jsp:include page="parts/user-menu.jsp" />
    </header>

    <main>

    </main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../js/menu.js"></script>

</body>
</html>