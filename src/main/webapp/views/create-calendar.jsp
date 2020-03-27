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

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body>
<div class="se-pre-con"></div>
<header>
    <nav id="main-menu">
        <ul>
            <li>
                <a href="${contextPath}/">Domů</a>
            </li>
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
    <jsp:include page="parts/user-menu.jsp" />
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
                <form:label path="type" for="type1" id="type" cssClass="label label--radio label--radio-type">
                    <form:radiobutton path="type" value="1" id="type1" name="type" checked="checked" cssClass="input input--radio input--radio-type"/>
                    <span>1</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-block.png" alt="Typ 1">
                    </div>
                </form:label>

                <form:label path="type" for="type2" id="type" cssClass="label label--radio label--radio-type">
                    <form:radiobutton path="type" id="type2" value="2" name="type" cssClass="input input--radio input--radio-type"/>
                    <span>2</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Typ 2">
                    </div>
                </form:label>

                <form:label path="type" for="type3" id="type" cssClass="label label--radio label--radio-type">
                    <form:radiobutton path="type" id="type3" value="3" name="type" cssClass="input input--radio input--radio-type"/>
                    <span>3</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-block.png" alt="Typ 3">
                    </div>
                </form:label>

                <form:label path="type" for="type4" id="type" cssClass="label label--radio label--radio-type">
                    <form:radiobutton path="type" id="type4" value="4" name="type" cssClass="input input--radio input--radio-type"/>
                    <span>4</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Typ 4">
                    </div>
                </form:label>
                <form:errors path="type" />
            </div>

            <div id="wrapper-design" class="wrapper wrapper--group-radio-create">
                <span>Design</span>
                <form:label path="design" for="design0" id="design" cssClass="label label--radio label--radio-design">
                    <form:radiobutton path="design" id="design0" value="0" name="design" cssClass="input input--radio input--radio-design"/>
                    <span>Vlastní</span>
                </form:label>

                <form:label path="design" for="design1" id="design" cssClass="label label--radio label--radio-design">
                    <form:radiobutton path="design" id="design1" value="1" name="design" cssClass="input input--radio input--radio-design"/>
                    <span>1</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Design 1">
                    </div>
                </form:label>

                <form:label path="design" for="design2" id="design" cssClass="label label--radio label--radio-design">
                    <form:radiobutton path="design" id="design2" value="2" name="design" cssClass="input input--radio input--radio-design"/>
                    <span>2</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/portrait-row.png" alt="Design 2">
                    </div>
                </form:label>

                <form:label path="design" for="design3" id="design" cssClass="label label--radio label--radio-design">
                    <form:radiobutton path="design" id="design3" value="3" name="design" cssClass="input input--radio input--radio-design"/>
                    <span>3</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Design 3">
                    </div>
                </form:label>

                <form:label path="design" for="design4" id="design" cssClass="label label--radio label--radio-design">
                    <form:radiobutton path="design" id="design4" value="4" name="design" cssClass="input input--radio input--radio-design"/>
                    <span>4</span>
                    <div class="wrapper wrapper--radio-img">
                        <img src="${contextPath}/img/landscape-row.png" alt="Design 4">
                    </div>
                </form:label>

                <form:errors path="design" />
            </div>

            <div class="wrapper wrapper--color-text wrapper--color-text-create">
                <form:label path="colorLabels" for="colorLabels" cssClass="label label--calendar-option label--colorLabels">Barva popisků
                    <form:input type="color" id="colorLabels" path="colorLabels" cssClass="input input--color" />
                    <form:errors path="colorLabels" />
                </form:label>

                <form:label path="colorDates" for="colorDates" cssClass="label label--calendar-option label--colorDates">Barva data
                    <form:input type="color" id="colorDates" path="colorDates" cssClass="input input--color" />
                    <form:errors path="colorDates" />
                </form:label>

                <form:label path="backgroundColor" for="backgroundColor" cssClass="label label--calendar-option label--backgroundColor">Barva pozadí
                    <form:input type="color" id="backgroundColor" path="backgroundColor" cssClass="input input--color" value="#FFFFFF" />
                    <form:errors path="backgroundColor" />
                </form:label>
            </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="submit" class="input input--submit" value="Vytvořit" />
        </form:form>
        <div class="sidebox sidebox--preview-create">
            <div id="calendar-date-block" class="month item a4-portrait">
                <div class="wrapper wrapper--image border"></div>
                <div class="wrapper wrapper--dates">
                    <h3>Leden</h3>
                    <div class="labels">
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                        <span>ČT</span>
                        <span>PÁ</span>
                        <span>SO</span>
                        <span>NE</span>
                    </div>
                    <div class="dates">
                        <c:forEach begin="1" end="31" varStatus="date">
                            <span>${date.index}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div id="calendar-date-row" class="month item a4-portrait">
                <div class="wrapper wrapper--image border"></div>
                <div class="wrapper wrapper--dates">
                    <h3>Leden</h3>
                    <div class="labels" style="grid-template-columns: repeat(31, 1fr);">
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                        <span>ČT</span>
                        <span>PÁ</span>
                        <span>SO</span>
                        <span>NE</span>
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                        <span>ČT</span>
                        <span>PÁ</span>
                        <span>SO</span>
                        <span>NE</span>
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                        <span>ČT</span>
                        <span>PÁ</span>
                        <span>SO</span>
                        <span>NE</span>
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                        <span>ČT</span>
                        <span>PÁ</span>
                        <span>SO</span>
                        <span>NE</span>
                        <span>PO</span>
                        <span>ÚT</span>
                        <span>ST</span>
                    </div>
                    <div class="dates" style="grid-template-columns: repeat(31, 1fr);">
                        <c:forEach begin="1" end="31" varStatus="date">
                            <span>${date.index}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${contextPath}/js/script.js"></script>
<script src="${contextPath}/js/menu.js"></script>
</body>
</html>