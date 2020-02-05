<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 07.12.19
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.liferay.portal.kernel.util.Validator"%>
<liferay-theme:defineObjects />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Create an account</title>
<%--    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body>
<div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} |
            <a onclick="document.forms['logoutForm'].submit()">Logout</a> |

            <%= int usId = request.getSession().getAttribute("currentUser") %>

            <c:url var="updateLink" value="/user/update">
                <c:param name="userId" value="${user.id}" />
            </c:url>


            <security:authorize access="hasRole('ROLE_ADMIN')">
                This text is only visible to an admin
                <br/>
                <a href="${contextPath}/admin/special">Admin Only</a> |
                <a href="${contextPath}/users/list">Users list</a>

            </security:authorize>
        </h2>

    </c:if>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>