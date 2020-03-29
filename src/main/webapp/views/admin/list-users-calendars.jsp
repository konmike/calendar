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
    <title>ADMIN Kalendáře všech uživatelů</title>

    <link href="${contextPath}/css/style.css" rel="stylesheet">
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
                    <span class="active">Kalendáře</span>
                </li>
            </security:authorize>
        </ul>
    </nav>
    <jsp:include page="../parts/user-menu.jsp" />
</header>

<main>
    <c:forEach var="databaseUser" items="${users}">
        <c:if test="${not empty databaseUser.calendars}">
            <h3>${databaseUser.username} calendars</h3>
            <div class="section section--calendar-show-all">
                <ul th:each="calendar : ${databaseUser.calendars}" class="list list--my-calendars">
                    <c:forEach varStatus="item" items="${databaseUser.calendars}" var="calendar">
                        <li class="list--item">
                            <c:choose>
                                <c:when test="${frontPages.get(item.index).contains('null')}">
                                    <a href="${contextPath}/calendar?calId=${calendar.id}">
                                        <i class="fas fa-file-image"></i>
                                        <span>${calendar.name}</span>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${contextPath}/calendar?calId=${calendar.id}">
                                        <img src="${frontPages.get(item.index)}" alt="" />
                                        <span>${calendar.name}</span>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </c:forEach>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../../js/menu.js"></script>
</body>
</html>