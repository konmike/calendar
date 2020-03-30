<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 27.02.20
  Time: 18:36
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
    <title>Mé kalendáře</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
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
                <span class="active">Mé kalendáře</span>
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
    <div id="my-calendars" class="section section--calendar-show-all slider">
        <a href="#" class="control_next">></a>
        <a href="#" class="control_prev"><</a>
        <ul th:each="calendar : ${calendars}" class="list list--my-calendars">
            <c:choose>
                <c:when test="${not empty calendars}">
                    <c:forEach varStatus="item" items="${calendars}" var="calendar">
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
                </c:when>
                <c:otherwise>
                    <li class="list--item">
                        <h3>Doposud jste nevytvořil žádný kalendář...</h3>
                        <a href="${contextPath}/calendar/create" class="link link--create-calendar">Vytvořit nový kalendář</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${contextPath}/js/script.js"></script>
<script src="${contextPath}/js/slider.js"></script>
<script src="${contextPath}/js/menu.js"></script>

</body>
</html>