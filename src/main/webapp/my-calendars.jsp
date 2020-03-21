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

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/simple-lightbox.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
    <%--    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">--%>
</head>
<body>
<header>
    <nav>
        <ul>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/">Domů</a>
                </li>
            </security:authorize>
            <security:authorize access="!hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/">Domů</a>
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
</header>

<main>
    <h2 class="">Mé kalendáře</h2>
    <div class="section section--calendar-show-all">
        <ul th:each="calendar : ${calendars}" class="list list--my-calendars">

            <c:forEach varStatus="item" items="${calendars}" var="calendar">
                <li class="list--item">
                <c:choose>
                    <c:when test="${frontPages.get(item.index).contains('null')}">
                        <a href="${contextPath}/calendar?calId=${calendar.id}">
                            <i class="fas fa-file-image"></i>
                            <span>${calendar.name} ${calendar.year}</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${contextPath}/calendar?calId=${calendar.id}">
                            <img src="${frontPages.get(item.index)}" alt="" />
                            <span>${calendar.name} ${calendar.year}</span>
                        </a>
                    </c:otherwise>
                </c:choose>
                </li>
            </c:forEach>
        </ul>
    </div>
</main>

<footer>
    <ul>
        <li>
            <span>Přihlášen jako ${pageContext.request.userPrincipal.name}</span>
        </li>
        <li>
            <form:form id="logoutForm" method="POST" action="${contextPath}/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Odhlásit se" />
            </form:form>
        </li>
        <li>
            <c:url var="updateLink" value="/user/update">
                <c:param name="username" value="${pageContext.request.userPrincipal.name}" />
            </c:url>
            <a href="${updateLink}">Změnit heslo</a>
        </li>
    </ul>
</footer>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${contextPath}/resources/js/script.js"></script>
<script src="${contextPath}/resources/js/simple-lightbox.jquery.js"></script>

</body>
</html>