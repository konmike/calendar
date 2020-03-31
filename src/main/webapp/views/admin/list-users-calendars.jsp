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
    <title>ADMIN - Kalendáře všech uživatelů</title>

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
    <div class="section section--calendar-show-all-users-calendar">
    <c:forEach var="databaseUser" items="${users}" varStatus="item">
        <c:if test="${not empty databaseUser.calendars}">
            <div id="wrapper-calendar-${item.index}" class="wrapper wrapper--users-calendar slider">
                <a href="#" class="control_next">></a>
                <a href="#" class="control_prev"><</a>
                <h3>${databaseUser.username}</h3>
                <ul th:each="calendar : ${databaseUser.calendars}" class="list list--my-calendars">
                    <c:forEach varStatus="item" items="${databaseUser.calendars}" var="calendar">
                        <li class="list--item">
                            <c:choose>
                                <c:when test="${frontPages.get(item.index).contains('null')}">
                                    <div class="wrapper wrapper--calendar-item">
                                        <i class="fas fa-file-image"></i>
                                        <span>${calendar.name}</span>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${calendar.id}" class="link link--display">Zobrazit</a>
                                            <a href="${contextPath}/calendar/update?calId=${calendar.id}" class="link link--edit">Editovat</a>
                                            <a href="${contextPath}/calendar/delete?calId=${calendar.id}" class="link link--delete"
                                               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="wrapper wrapper--calendar-item">
                                        <img src="${frontPages.get(item.index)}" alt="" />
                                        <span>${calendar.name}</span>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${calendar.id}" class="link link--display">Zobrazit</a>
                                            <a href="${contextPath}/calendar/update?calId=${calendar.id}" class="link link--edit">Editovat</a>
                                            <a href="${contextPath}/calendar/delete?calId=${calendar.id}" class="link link--delete"
                                               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </c:forEach>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../../js/menu.js"></script>
<script src="../../js/slider.js"></script>
</body>
</html>