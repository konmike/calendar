<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 26.03.20
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<nav id="user-menu">
    <ul>
        <li>
            <span>${user.get().username}</span>
        </li>
        <li>
            <span>${user.get().email}</span>
        </li>
        <li>
            <c:url var="updateLink" value="/user/update">
                <c:param name="id" value="${user.get().id}" />
            </c:url>
            <a href="${updateLink}">Nastavení</a>
        </li>
        <li>
            <form:form id="logoutForm" cssClass="form form--logout" method="POST" action="${contextPath}/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" class="input--submit" value="Odhlásit se" />
            </form:form>
        </li>
    </ul>
</nav>