<%--
  Created by IntelliJ IDEA.
  User: mike
  Date: 29.03.20
  Time: 10:55
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
    <title>Testovací návrhář - bez přihlášení</title>

    <link href="${contextPath}/css/index.css" rel="stylesheet">
    <link href="${contextPath}/css/style.css" rel="stylesheet">
    <link href="${contextPath}/css/simple-lightbox.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
</head>
<body data-custom-year="2020" data-custom-type="1" data-custom-design=""
      data-custom-color-labels="" data-custom-color-dates=""
      data-custom-color-background="" data-custom-test="true">
<div class="se-pre-con"></div>
<header>
    <nav id="main-menu">
        <ul>
            <li>
                <a href="${contextPath}/login">Přihlášení</a>
            </li>
            <li>
                <a href="${contextPath}/registration">Registrace</a>
            </li>
        </ul>
    </nav>
</header>

<main>
    <div class="section section--calendar-update">
        <form enctype="multipart/form-data" class="form form--calendar-update">
            <div class="sidebox sidebox--top sidebox--calendar-option">

                <label for="name" class="label label--calendar-option label--name">Název kalendáře
                    <input type="text" id="name" class="input input--text" placeholder="Název kalendáře" />
                </label>

                <label for="year" class="label label--calendar-option label--year">Rok
                    <input type="number" id="year" class="input input--number" value="2020" placeholder="Rok" />
                </label>


                <div id="wrapper-type" class="wrapper wrapper--group-radio-update">
                    <span>Typ</span>
                    <label for="type1" class="label label--radio label--radio-type">
                        <input type="radio" value="1" id="type1" name="type" class="input input--radio input--radio-type"/>
                        <span>1</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/portrait-block.png" alt="Typ 1">
                        </div>
                    </label>

                    <label for="type2" class="label label--radio label--radio-type">
                        <input type="radio" id="type2" value="2" name="type" class="input input--radio input--radio-type"/>
                        <span>2</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/portrait-row.png" alt="Typ 2">
                        </div>
                    </label>

                    <label for="type3" class="label label--radio label--radio-type">
                        <input type="radio" id="type3" value="3" name="type" class="input input--radio input--radio-type"/>
                        <span>3</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/landscape-block.png" alt="Typ 3">
                        </div>
                    </label>

                    <label for="type4" class="label label--radio label--radio-type">
                        <input type="radio" id="type4" value="4" name="type" class="input input--radio input--radio-type"/>
                        <span>4</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/landscape-row.png" alt="Typ 4">
                        </div>
                    </label>
                </div>

                <div id="wrapper-design" class="wrapper wrapper--group-radio-update">
                    <span>Design</span>
                    <label for="design0" class="label label--radio label--radio-design">
                        <input type="radio" id="design0" value="0" name="design" checked="checked" class="input input--radio input--radio-design"/>
                        <span>Vlastní</span>
                    </label>

                    <label for="design1" class="label label--radio label--radio-design">
                        <input type="radio" id="design1" value="1" name="design" class="input input--radio input--radio-design"/>
                        <span>1</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/portrait-row.png" alt="Design 1">
                        </div>
                    </label>

                    <label for="design2" class="label label--radio label--radio-design">
                        <input type="radio" id="design2" value="2" name="design" class="input input--radio input--radio-design"/>
                        <span>2</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/portrait-row.png" alt="Design 2">
                        </div>
                    </label>

                    <label for="design3" class="label label--radio label--radio-design">
                        <input type="radio" id="design3" value="3" name="design" class="input input--radio input--radio-design"/>
                        <span>3</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/landscape-row.png" alt="Design 3">
                        </div>
                    </label>

                    <label for="design4" id="design" class="label label--radio label--radio-design">
                        <input type="radio" id="design4" value="4" name="design" class="input input--radio input--radio-design"/>
                        <span>4</span>
                        <div class="wrapper wrapper--radio-img">
                            <img src="${contextPath}/img/landscape-row.png" alt="Design 4">
                        </div>
                    </label>

                </div>

                <div id="wrapper-color" class="wrapper wrapper--color-text wrapper--color-text-update">
                    <label for="colorLabels" class="label label--calendar-option label--colorLabels">Barva popisků
                        <input type="color" id="colorLabels" name="colorLabels" class="input input--color" value="#000000" />
                    </label>

                    <label for="colorDates" class="label label--calendar-option label--colorDates">Barva data
                        <input type="color" id="colorDates" name="colorDates" class="input input--color" value="#000000" />
                    </label>

                    <label for="backgroundColor" class="label label--calendar-option label--backgroundColor">Barva pozadí
                        <input type="color" id="backgroundColor" name="backgroundColor" class="input input--color" value="#FFFFFF" />
                    </label>
                </div>
            </div>
            <div class="sidebox sidebox--upload-image">
                <label for="file" class="label label--file">
                    <input type="file" id="file" name="files" accept="image/*" class="input input--file" multiple />
                    <span class="file--custom"></span>
                </label>


                <ul class="list list--gallery">
<%--                    <c:forEach var="image" items="${cal.images}" varStatus="item">--%>
<%--                        <li class="list--item" >--%>
<%--                            <img src="${image.path}" draggable="true" ondragstart="return dragStart(event)" width="200" alt="${image.name}" id="image${item.index}"/>--%>
<%--                            <a href="${image.path}" class="link link--full-image">Zvětšit</a>--%>
<%--                            <a href="${contextPath}/calendar/image/delete?calId=${cal.id}&imgId=${image.id}" class="link link--delete-image"--%>
<%--                               onclick="if (!(confirm('Opravdu chcete obrázek smazat?'))) return false"> Smazat</a>--%>
<%--                        </li>--%>
<%--                    </c:forEach>--%>
                </ul>
            </div>

            <div class="sidebox sidebox--calendar-preview">
                <a id="prev"></a>
                <div id="calendar">
                    <c:forEach begin="0" end="12" varStatus="item">
                        <c:choose>
                            <c:when test="${item.index == '0'}">
                                <label for="item0" class="label label--item label--item-0">
                                            <input type="checkbox" id="item0" class="input input--checkbox" value="null" checked="checked"/>
                                            <div class="item item--0 a4-portrait">
                                                <div onclick="deleteImage(event)" class="wrapper wrapper--image border"
                                                     ondragenter="return dragEnter(event)"
                                                     ondrop="return dragDrop(event)"
                                                     ondragover="return dragOver(event)"
                                                     ondragleave="return dragLeave(event)"></div>
                                                <span class="calendar-title">Kalendář 2020</span>
                                            </div>
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label for="item${item.index}" class="label label--item label--item-${item.index}">
                                            <input type="checkbox" id="item${item.index}" class="input input--checkbox" value="null" checked="checked"/>
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
                                </label>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <a id="next"></a>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input id="redir" type="hidden" name="redir" value="show" />
            <a href="${contextPath}/registration" class="input input--submit"
               onclick="if (!(confirm('Pro pokračování musíte být registrovaní, chcete si založit účet?'))) return false">Uložit a zobrazit</a>
        </form>
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
<script src="${contextPath}/js/test-calendar.js"></script>
<script src="${contextPath}/js/simple-lightbox.jquery.js"></script>
<script>
    (function($) {
        $('.list--gallery a.link--full-image').simpleLightbox({ /* options */ });
    })( jQuery );

</script>

</body>
</html>