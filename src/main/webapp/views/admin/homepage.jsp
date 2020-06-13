<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 08.12.19
  Time: 14:08
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
    <title>Úvodní ADMIN stránka</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body>
<div class="se-pre-con"></div>
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
    </nav>
    <jsp:include page="../parts/user-menu.jsp" />
</header>

<main>
    <div class="section section--admin-homepage">
        <div class="sidebox sidebox--admin-search-users">
            <form action="${contextPath}/admin" class="form form--search">
                <label for="search">
                    <input type="text" class="input input--text input--search" autofocus id="search" name="name" placeholder="Hledání uživatele" />
                </label>
                <input type="submit" value="Hledat" class="input input--submit" />
                <a href="${contextPath}/admin/create-user" class="link link--create-user">Vytvořit uživatele</a>
            </form>
            <table class="table table--users">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Jméno</th>
                    <th>E-mail</th>
                    <th>Admin</th>
                    <th>Editace</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="databaseUser" items="${users}">
                    <c:url var="updateLink" value="/user/update">
                        <c:param name="id" value="${databaseUser.id}" />
                    </c:url>

                    <c:url var="deleteLink" value="/user/delete">
                        <c:param name="userId" value="${databaseUser.id}" />
                    </c:url>

                    <c:if test="${databaseUser.username != pageContext.request.userPrincipal.name}">
                        <c:set var="isAdmin" scope="request" value="${databaseUser.admin}"/>
                        <tr>
                            <td>${databaseUser.id}</td>
                            <td>${databaseUser.username}</td>
                            <td>${databaseUser.email}</td>
                            <td><span class="<c:out default="admin-icon-no" escapeXml="true" value="${isAdmin ? 'admin-icon-yes' : 'admin-icon-no'}" />"></span></td>
                            <td>
                                <a href="${updateLink}" class="link link--edit-user">Úpravy</a>
                                <a href="${deleteLink}" class="link link--delete-user"
                                   onclick="if (!(confirm('Opravdu chceš smazat uživatele ${databaseUser.username} ?'))) return false">Smazat</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="sidebox sidebox--last-calendar">
            <ul class="list list--my-calendars">
                <li class="list--item">
                    <c:choose>
                        <c:when test="${not empty lastCal.name}">
                            <c:choose>
                                <c:when test="${frontPage.contains('null')}">
                                    <h3>Váš poslední vytvořený kalendář...</h3>
                                    <div class="wrapper wrapper--calendar-item">
                                        <i class="fas fa-file-image"></i>
                                        <span>${lastCal.name}</span>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${lastCal.id}" class="link link--display">Zobrazit</a>
                                            <a href="${contextPath}/calendar/update?calId=${lastCal.id}" class="link link--edit">Editovat</a>
                                            <a href="${contextPath}/calendar/delete?calId=${lastCal.id}" class="link link--delete"
                                               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <h3>Váš poslední vytvořený kalendář</h3>
                                    <div class="wrapper wrapper--calendar-item">
                                        <img src="${frontPage}" alt="" />
                                        <span>${lastCal.name} ${lastCal.year}</span>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${lastCal.id}" class="link link--display">Zobrazit</a>
                                            <a href="${contextPath}/calendar/update?calId=${lastCal.id}" class="link link--edit">Editovat</a>
                                            <a href="${contextPath}/calendar/delete?calId=${lastCal.id}" class="link link--delete"
                                               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <h3>Doposud jste nevytvořil žádný kalendář...</h3>
                            <a href="${contextPath}/calendar/create" class="link link--create-calendar">Vytvořit nový kalendář</a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
        <h3>10 nejnovějších kalendářů</h3>
        <c:if test="${not empty lastTenCal}">
            <div id="last-ten-cal" class="sidebox sidebox--last-ten-calendars slider">
                <a href="#" class="control_next">></a>
                <a href="#" class="control_prev"><</a>
                <ul class="list list--my-calendars">
                    <c:forEach varStatus="item" items="${lastTenCal}" var="calendar">
                        <li class="list--item">
                            <c:choose>
                                <c:when test="${lastTenFront.get(item.index).contains('null')}">
                                    <div class="wrapper wrapper--calendar-item">
                                        <i class="fas fa-file-image"></i>
                                        <span>${calendar.name}</span>
<%--                                        <span>${calendar.user.username}</span>--%>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${calendar.id}" class="link link--display">Zobrazit</a>
<%--                                            <c:if test="${calendar.user.id == user.get().id}">--%>
                                            <a href="${contextPath}/calendar/update?calId=${calendar.id}" class="link link--edit">Editovat</a>
<%--                                            </c:if>--%>
                                            <a href="${contextPath}/calendar/delete?calId=${calendar.id}" class="link link--delete"
                                               onclick="if (!(confirm('Kalendář bude odstraněn, chcete určitě pokračovat?'))) return false">Smazat</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="wrapper wrapper--calendar-item">
                                        <img src="${lastTenFront.get(item.index)}" alt="" />
                                        <span>${calendar.name}</span>
<%--                                        <span>${calendar.user.username}</span>--%>
                                        <div class="box box--button box--button-calendar-edit">
                                            <a href="${contextPath}/calendar?calId=${calendar.id}" class="link link--display">Zobrazit</a>
<%--                                            <c:if test="${calendar.user.id == user.get().id}">--%>
                                            <a href="${contextPath}/calendar/update?calId=${calendar.id}" class="link link--edit">Editovat</a>
<%--                                            </c:if>--%>
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
        <c:if test="${empty lastTenCal}">
        <div id="last-ten-cal" class="sidebox sidebox--last-ten-calendars slider">
            <a href="#" class="control_next">></a>
            <a href="#" class="control_prev"><</a>
            <h3>Doposud nebyly vytvořeny žádné kalendáře...</h3>
        </div>
        </c:if>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/js/script.js"></script>
<script src="${contextPath}/js/slider.js"></script>
<script src="${contextPath}/js/menu.js"></script>
</body>
</html>