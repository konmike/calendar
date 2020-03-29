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
    <title>Editace uživatele</title>

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
    <div class="section section--user-update">
        <form:form method="post" action="${contextPath}/updateUser" modelAttribute="updateUser" class="form form--update">
            <span class="form--title">Nastavení profilu ${updateUser.username}</span>

            <form:hidden path="id"/>
            <form:hidden path="username"/>
            <form:hidden path="password"/>
            <%--        <form:hidden path="calendars"/>--%>
            <%--        <form:hidden path="imageList"/>--%>

            <security:authorize access="! hasRole('ROLE_ADMIN')">
                <spring:bind path="oldPassword">
                    <div class="form-group">
                        <form:input path="oldPassword" type="password" autofocus="autofocus" id="oldPassword" name="oldPassword" class="input input--password" placeholder="Původní heslo" value="" />
                        <form:errors path="oldPassword" />
                    </div>
                </spring:bind>
            </security:authorize>

            <spring:bind path="newPassword">
                <div class="form-group">
                    <form:input path="newPassword" type="password" id="newPassword" name="newPassword" class="input input--password" placeholder="Nové heslo" value="" />
                    <form:errors path="newPassword" />
                </div>
            </spring:bind>

            <spring:bind path="passwordConfirm">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="password" path="passwordConfirm" class="input input--password" placeholder="Potvrzení nového hesla" />
                    <form:errors path="passwordConfirm" />
                </div>
            </spring:bind>

            <security:authorize access="hasRole('ROLE_ADMIN')">
                <form:label path="admin" for="admin" cssClass="label label--admin">
                    <form:checkbox path="admin" id="admin" value="1" name="admin" class="checkbox checkbox--isAdmin"/>
                    <span>Admin role</span>
                </form:label>
            </security:authorize>

            <form:button class="input input--submit">Aktualizovat údaje</form:button>
        </form:form>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../js/menu.js"></script>

</body>
</html>