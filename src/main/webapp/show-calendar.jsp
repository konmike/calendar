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
<body data-custom-year="${cal.year}" data-custom-offset="${cal.offset}" data-custom-lang="${cal.lang}">
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
                <a href="${contextPath}/image/">Tvorba kalendáře</a>
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
    <h2 class="">${cal.name} - ${cal.year}</h2>
    <div class="section section--calendar-show-one">
        <div id="calendar">
            <div class="item item--0 a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(0).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(0)}" alt="Front Page" />
                    </c:otherwise>
                </c:choose>
                </div>
            </div>

            <div class="month month--1 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(1).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(1)}" alt="January" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--2 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(2).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(2)}" alt="February" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--3 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(3).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(3)}" alt="March" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--4 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(4).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(4)}" alt="April" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--5 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(5).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                        <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                        <img src="${calImage.get(5)}" alt="May" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--6 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(6).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(6)}" alt="June" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--7 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(7).contains('nothing')}">
                    <div class="wrapper wrapper-image border-no">
                        <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(7)}" alt="July" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--8 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(8).contains('nothing')}">
                    <div class="wrapper wrapper-image border-no">
                        <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(8)}" alt="August" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--9 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(9).contains('nothing')}">
                    <div class="wrapper wrapper-image border-no">
                        <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(9)}" alt="September" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--10 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(10).contains('nothing')}">
                    <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(10)}" alt="October" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--11 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(11).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(11)}" alt="November" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
            <div class="month month--12 item a4-portrait">
                <c:choose>
                    <c:when test="${calImage.get(12).contains('nothing')}">
                        <div class="wrapper wrapper-image border-no">
                            <i class="fas fa-file-image"></i>
                    </c:when>
                    <c:otherwise>
                        <div class="wrapper wrapper-image border-no">
                            <img src="${calImage.get(12)}" alt="December" />
                    </c:otherwise>
                </c:choose>
                </div>
                <div class="labels"></div>
                <div class="dates"></div>
            </div>
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
<script src="https://unpkg.com/calendarize"></script>
<script src="https://unpkg.com/sublet"></script>
<script src="${contextPath}/resources/js/calendar.js"></script>
<script src="${contextPath}/resources/js/script.js"></script>
<script src="${contextPath}/resources/js/simple-lightbox.jquery.js"></script>

</body>
</html>