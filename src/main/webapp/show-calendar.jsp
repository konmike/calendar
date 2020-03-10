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
    <title>${cal.name} - ${cal.year}</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/simple-lightbox.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
    <%--    <link href="${contextPath}/resources/css/form.css" rel="stylesheet">--%>
</head>
<body data-custom-year="${cal.year}" data-custom-type="${cal.type}" data-custom-name="${cal.name}">
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
                <a href="${contextPath}/calendar/myCalendars">Mé kalendáře</a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/list-gallery">Editace galerií</a>
                </li>
            </security:authorize>
        </ul>
    </nav>
</header>

<main>
    <c:choose>
        <c:when test="${empty cal.name}">
            <h2 class="">${cal.year}</h2>
        </c:when>
        <c:otherwise>
            <h2 class="">${cal.name} - ${cal.year}</h2>
        </c:otherwise>
    </c:choose>

    <div class="section section--calendar-show-one">
        <div class="calendar-edit-option">
            <a href="${contextPath}/calendar/update?calId=${cal.id}" class="link link--edit-option link--edit">Editovat</a>
            <a class="link link--edit-option link--download">Stáhnout</a>
            <a href="${contextPath}/calendar/delete?calId=${cal.id}" class="link link--edit-option link--delete"
               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
        </div>
        <div id="calendar">
            <c:forEach begin="0" end="12" varStatus="item">
                <c:choose>
                    <c:when test="${item.index == '0'}">
                        <div class="item item--0 a4-portrait html2pdf__page-break">
                            <c:choose>
                                <c:when test="${cal.selImage.get(0).contains('null') or (empty cal.selImage)}">
                                    <div class="wrapper wrapper-image border-no">
                                        <i class="fas fa-file-image"></i>
                                    </div>
                                    <span class="calendar-title">Kalendář ${cal.year}</span>
                                </c:when>
                                <c:otherwise>
                                    <div class="wrapper wrapper-image border-no">
                                        <img src="${cal.selImage.get(0)}" alt="Front Page" />
                                    </div>
                                    <span class="calendar-title">Kalendář ${cal.year}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="month month--${item.index} item a4-portrait html2pdf__page-break">
                            <c:choose>
                                <c:when test="${cal.selImage.get(item.index).contains('null') or (empty cal.selImage)}">
                                    <div class="wrapper wrapper-image border-no">
                                        <i class="fas fa-file-image"></i>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="wrapper wrapper-image border-no">
                                        <img src="${cal.selImage.get(item.index)}" alt="Image${item.index}" />
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="labels"></div>
                            <div class="dates"></div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
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
<%--<script src="https://unpkg.com/calendarize"></script>--%>
<script src="https://unpkg.com/sublet"></script>
<script src="resources/js/html2pdf.bundle.min.js"></script>
<%--<script src="${contextPath}/resources/js/calendar.js"></script>--%>
<script src="${contextPath}/resources/js/calendar2.js"></script>
<script src="${contextPath}/resources/js/script.js"></script>
<script src="${contextPath}/resources/js/simple-lightbox.jquery.js"></script>

</body>
</html>