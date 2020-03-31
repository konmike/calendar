<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 02.03.20
  Time: 21:36
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
    <title>Editace kalendáře - ${cal.name}</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/simple-lightbox.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body data-custom-year="${cal.year}" data-custom-type="${cal.type}" data-custom-design="${cal.design}"
      data-custom-color-labels="${cal.colorLabels}" data-custom-color-dates="${cal.colorDates}"
      data-custom-color-background="${cal.backgroundColor}" data-custom-test="false">
<div class="se-pre-con"></div>
<header>
    <nav id="main-menu">
        <ul>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin"
                       onclick="if (!(confirm('Změny nemusí být uloženy, chcete přesto pokračovat?'))) return false">Domů</a>
                </li>
            </security:authorize>
            <li>
                <a href="${contextPath}/calendar/create"
                   onclick="if (!(confirm('Změny nemusí být uloženy, chcete přesto pokračovat?'))) return false">Nový kalendář</a>
            </li>
            <li>
                <a href="${contextPath}/calendar/myCalendars"
                   onclick="if (!(confirm('Změny nemusí být uloženy, chcete přesto pokračovat?'))) return false">Mé kalendáře</a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
                <li>
                    <a href="${contextPath}/admin/list-calendars"
                       onclick="if (!(confirm('Změny nemusí být uloženy, chcete přesto pokračovat?'))) return false">Kalendáře</a>
                </li>
            </security:authorize>
        </ul>
    </nav>
    <jsp:include page="parts/user-menu.jsp" />
</header>

<main>
    <div class="section section--calendar-update">
        <form:form method="post" enctype="multipart/form-data" modelAttribute="cal" cssClass="form form--calendar-update" action="/calendar/update">
            <div class="sidebox sidebox--top sidebox--calendar-option">
                <form:label path="id" for="id">
                    <form:input type="hidden" id="id" path="id" />
                </form:label>

                <form:label path="images" for="images">
                    <form:input type="hidden" id="images" path="images" />
                </form:label>

                <form:label path="name" for="name" cssClass="label label--calendar-option label--name">Název kalendáře
                    <form:input type="text" id="name" path="name" class="input input--text" placeholder="Název kalendáře" />
                    <form:errors path="name" />
                </form:label>

                <spring:bind path="year">
                    <label for="year" class="label label--calendar-option label--year">Rok
                        <form:input type="number" path="year" id="year" class="input input--number" value="2020" placeholder="Rok" />
                        <form:errors path="year" />
                    </label>
                </spring:bind>


                <div id="wrapper-type" class="wrapper wrapper--group-radio-update">
                    <span>Typ</span>
                    <form:label path="type" for="type1" id="type" cssClass="label label--radio label--radio-type">
                        <form:radiobutton path="type" value="1" id="type1" name="type" cssClass="input input--radio input--radio-type"/>
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

                <div id="wrapper-design" class="wrapper wrapper--group-radio-update">
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

                <div id="wrapper-color" class="wrapper wrapper--color-text wrapper--color-text-update">
                    <form:label path="colorLabels" for="colorLabels" cssClass="label label--calendar-option label--colorLabels">Barva popisků
                        <form:input type="color" id="colorLabels" path="colorLabels" cssClass="input input--color" value="${cal.colorLabels}" />
                        <form:errors path="colorLabels" />
                    </form:label>

                    <form:label path="colorDates" for="colorDates" cssClass="label label--calendar-option label--colorDates">Barva data
                        <form:input type="color" id="colorDates" path="colorDates" cssClass="input input--color" value="${cal.colorDates}" />
                        <form:errors path="colorDates" />
                    </form:label>

                    <form:label path="backgroundColor" for="backgroundColor" cssClass="label label--calendar-option label--backgroundColor">Barva pozadí
                        <form:input type="color" id="backgroundColor" path="backgroundColor" cssClass="input input--color" value="${cal.backgroundColor}" />
                        <form:errors path="backgroundColor" />
                    </form:label>
                </div>
            </div>
            <div class="sidebox sidebox--upload-image">
                <label for="file" class="label label--file">
                    <input type="file" id="file" name="files" accept="image/*" class="input input--file" multiple />
                    <span class="file--custom"></span>
                    <span id="file.errors" class="${fileErrors}">${fileErrors}</span>
                </label>


                <ul class="list list--gallery">
                    <c:forEach var="image" items="${cal.images}" varStatus="item">
                        <li class="list--item" >
                            <img src="${image.path}" draggable="true" ondragstart="return dragStart(event)" width="50" alt="${image.name}" id="image${item.index}"/>
                            <div class="wrapper wrapper--image-control">
                                <a href="${image.path}" class="link link--full-image"></a>
                                <a href="${contextPath}/calendar/image/delete?calId=${cal.id}&imgId=${image.id}" class="link link--delete-image"
                                   onclick="if (!(confirm('Opravdu chcete obrázek smazat?'))) return false"></a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="sidebox sidebox--calendar-preview">
                <a id="prev"></a>
                <div id="calendar">
                    <c:forEach begin="0" end="12" varStatus="item">
                        <c:choose>
                            <c:when test="${item.index == '0'}">
                                <form:label path="selImage" for="item0" cssClass="label label--item label--item-0">
                                    <c:choose>
                                        <c:when test="${(cal.selImage.get(0).contains('null')) or (empty cal.selImage)}">
                                        <form:checkbox path="selImage" id="item0" cssClass="input input--checkbox" value="null" checked="checked"/>
                                        <div class="item item--0 a4-portrait">

                                            <div onclick="deleteImage(event)" class="wrapper wrapper--image border"
                                                     ondragenter="return dragEnter(event)"
                                                     ondrop="return dragDrop(event)"
                                                     ondragover="return dragOver(event)"
                                                     ondragleave="return dragLeave(event)"></div>
                                            <span class="calendar-title">Kalendář ${cal.year}</span>
                                        </div>
                                        </c:when>
                                        <c:otherwise>
                                        <form:checkbox path="selImage" id="item0" cssClass="input input--checkbox" value="${cal.selImage.get(0)}" checked="checked"/>
                                        <div class="item item--0 a4-portrait">
                                            <div onclick="deleteImage(event)" class="wrapper wrapper--image wrapper--image-after border-no">
                                                <img src="${cal.selImage.get(0)}" alt=""/>
                                            </div>
                                            <span class="calendar-title">Kalendář ${cal.year}</span>
                                        </div>
                                        </c:otherwise>
                                    </c:choose>
                                </form:label>
                            </c:when>
                            <c:otherwise>
                                <form:label path="selImage" for="item${item.index}" cssClass="label label--item label--item-${item.index}">
                                        <c:choose>
                                            <c:when test="${(cal.selImage.get(item.index).contains('null')) or (empty cal.selImage)}">
                                            <form:checkbox path="selImage" id="item${item.index}" cssClass="input input--checkbox" value="null" checked="checked"/>
                                            <div class="month month--${item.index} item a4-portrait">
                                                <div onclick="deleteImage(event)" class="wrapper wrapper--image border"
                                                     ondragenter="return dragEnter(event)"
                                                     ondrop="return dragDrop(event)"
                                                     ondragover="return dragOver(event)"
                                                     ondragleave="return dragLeave(event)"></div>
                                                <div class="wrapper wrapper--dates">
                                                    <div class="labels"></div>
                                                    <div class="dates"></div>
                                                </div>
                                            </div>
                                            </c:when>
                                            <c:otherwise>
                                            <form:checkbox path="selImage" id="item${item.index}" cssClass="input input--checkbox" value="${cal.selImage.get(item.index)}" checked="checked"/>
                                            <div class="month month--${item.index} item a4-portrait">
                                                <div onclick="deleteImage(event)" class="wrapper wrapper--image wrapper--image-after border-no">
                                                    <img src="${cal.selImage.get(item.index)}" alt=""/>
                                                </div>
                                                <div class="wrapper wrapper--dates">
                                                    <div class="labels"></div>
                                                    <div class="dates"></div>
                                                </div>
                                            </div>
                                            </c:otherwise>
                                        </c:choose>
                                </form:label>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                </div>
                <a id="next"></a>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input id="redir" type="hidden" name="redir" value="show" />
            <input type="submit" class="input input--submit" value="Uložit a zobrazit" />
        </form:form>
        <div class="box box--button box--button-calendar-update">
            <a class="link link--show-full-calendar">Všechny strany</a>
            <a class="link link--show-page-calendar">Jedna strana</a>
            <a class="link link--type-of-calendar">Orientace</a>
            <a class="link link--calendar-design">Design</a>
            <a class="link link--calendar-custom-color">Barvy</a>
        </div>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${contextPath}/js/dragAndDrop.js"></script>
<script src="${contextPath}/js/calendar.js"></script>
<script src="${contextPath}/js/script.js"></script>
<script src="../js/menu.js"></script>
<script src="${contextPath}/js/simple-lightbox.jquery.js"></script>
<script>
    (function($) {
        $('.list--gallery a.link--full-image').simpleLightbox({ /* options */ });
    })( jQuery );

</script>

</body>
</html>