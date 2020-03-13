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
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="utf-8">
    <title>Tvorba kalendáře</title>

    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
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
                <span class="active">Nový kalendář</span>
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
    <div class="section section--calendar-create">
        <form:form method="post" enctype="multipart/form-data" action="/calendar/create" modelAttribute="cal" cssClass="form form--calendar-create">

                <form:label path="id" for="id">
                    <form:input type="hidden" id="id" path="id"/>
                </form:label>

                <form:label path="images" for="images">
                    <form:input type="hidden" id="images" path="images"/>
                </form:label>

                <form:label path="name" for="name" cssClass="label label--calendar-option label--name">Název kalendáře
                    <form:input type="text" id="name" path="name" cssClass="input input--text" placeholder="Název kalendáře" />
                    <form:errors path="name" />
                </form:label>

                <spring:bind path="year">
                    <label for="year" class="label label--calendar-option label--year">Rok
                        <form:input type="number" path="year" id="year" cssClass="input input--number" value="2020" placeholder="Rok" />
                        <form:errors path="year" />
                    </label>
                </spring:bind>

            <div id="wrapper-type" class="wrapper wrapper--group-radio-create">
                <span>Typ</span>
                <form:label path="type" for="type1" id="type" cssClass="label label--radio label--type">
                    <form:radiobutton path="type" value="1" id="type1" name="type" checked="checked" cssClass="radio radio--type"/>
                    <span>1</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Typ 1">
                    </div>
                </form:label>

                <form:label path="type" for="type2" id="type" cssClass="label label--radio label--type">
                    <form:radiobutton path="type" id="type2" value="2" name="type" cssClass="radio radio--type"/>
                    <span>2</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Typ 2">
                    </div>
                </form:label>

                <form:label path="type" for="type3" id="type" cssClass="label label--radio label--type">
                    <form:radiobutton path="type" id="type3" value="3" name="type" cssClass="radio radio--type"/>
                    <span>3</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Typ 3">
                    </div>
                </form:label>

                <form:label path="type" for="type4" id="type" cssClass="label label--radio label--type">
                    <form:radiobutton path="type" id="type4" value="4" name="type" cssClass="radio radio--type"/>
                    <span>4</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Typ 4">
                    </div>
                </form:label>
                <form:errors path="type" />
            </div>

            <div id="wrapper-design" class="wrapper wrapper--group-radio-create">
                <span>Design</span>
                <form:label path="design" for="design1" id="design" cssClass="label label--radio">
                    <form:radiobutton path="design" id="design1" value="1" name="design" cssClass="radio radio--design"/>
                    <span>1</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Design 1">
                    </div>
                </form:label>

                <form:label path="design" for="design2" id="design" cssClass="label label--radio">
                    <form:radiobutton path="design" id="design2" value="2" name="design" cssClass="radio radio--design"/>
                    <span>2</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Design 2">
                    </div>
                </form:label>

                <form:label path="design" for="design3" id="design" cssClass="label label--radio">
                    <form:radiobutton path="design" id="design3" value="3" name="design" cssClass="radio radio--design"/>
                    <span>3</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Design 3">
                    </div>
                </form:label>

                <form:label path="design" for="design4" id="design" cssClass="label label--radio">
                    <form:radiobutton path="design" id="design4" value="4" name="design" cssClass="radio radio--design"/>
                    <span>4</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Design 4">
                    </div>
                </form:label>

                <form:errors path="design" />
            </div>


                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="submit" class="input input--submit" value="Vytvořit" />
        </form:form>
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


</body>
</html>