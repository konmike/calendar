<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 08.12.19
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
</body>
</html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Admin</title>
    <%--    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body>
<div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <a onclick="document.forms['logoutForm'].submit()">Logout</a>
        <a href="${contextPath}/addNewUser">Add new user</a>

        <h1>Users</h1>
        <ul>
            <c:forEach var="user" items="${users}">

                <li>${user.id} - ${user.username}</li>

                <c:url var="updateLink" value="/user/update">
                    <c:param name="userId" value="${user.id}" />
                </c:url>

                <c:url var="deleteLink" value="/user/delete">
                    <c:param name="userId" value="${user.id}" />
                </c:url>

                <a href="${updateLink}">Update</a>
                |
                <a href="${deleteLink}"
                   onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Delete</a>

            </c:forEach>
        </ul>
    </c:if>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>