<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/14
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${contestId eq -1}">导入比赛</c:when>
            <c:when test="${!(contestId eq -1)}">修改比赛</c:when>
        </c:choose> - ACManager
    </title>
    <script src="//cdn.bootcss.com/jquery/3.1.0/jquery.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="//cdn.bootcss.com/datatables/1.10.13/js/jquery.dataTables.min.js"></script>
    <script src="//cdn.bootcss.com/jquery-datetimepicker/2.5.4/build/jquery.datetimepicker.full.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/datatables/1.10.13/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css"
          href="//cdn.bootcss.com/jquery-datetimepicker/2.5.4/jquery.datetimepicker.css"/>
    <script>
        $(document).ready(function () {
            $('#startTime').datetimepicker({
                format: 'Y-m-d' + ' ' + 'H:i:s',
                formatDate: 'Y-m-d',
                formatTime: 'H:i',
                timepicker: true,
                //showSecond: true,
                dayOfWeekStart: 1,
                lang: 'en',
                step: 1
            });
            $('#endTime').datetimepicker({
                format: 'Y-m-d' + ' ' + 'H:i:s',
                formatDate: 'Y-m-d',
                formatTime: 'H:i',
                timepicker: true,
                //showSecond: true,
                dayOfWeekStart: 1,
                lang: 'en',
                step: 1
            });
            $("#Type option[value='${preContest.type}']").prop("selected", "selected");
            var ok = ${preContest.realContest};
            if (ok)
                $('#true_false').prop("checked", true);
            else
                $('#true_false').prop("checked", false);
        })
    </script>
</head>
<body>

<div class="container-fluid" style="margin-right: 0.7%;margin-left: 0.7%">
    <jsp:include page="topBar.jsp"/>
    <div class="row">
        <div class="col-lg-2">
        </div>
        <div class="col-lg-8">
            <div class="page-header">
                <h1>
                    <c:choose>
                        <c:when test="${contestId eq -1}">导入比赛</c:when>
                        <c:when test="${!(contestId eq -1)}">修改比赛</c:when>
                    </c:choose>
                </h1>
            </div>
            <div>
                <form class="form-horizontal" method="post" action="<c:url value="/contest/importContest"/> ">
                    <input name="stageId" value="${stageId}" hidden>
                    <div class="col-lg-10">
                        <div class="row">
                            <div class="row">
                                <div class="col-lg-11">
                                    <input type="text" value="${contestId}" name="contestId" hidden>
                                    <div class="form-group">
                                        <input type="text" value="${preContest.name}" name="contestName"
                                               class="form-control" placeholder="比赛名称*" autofocus required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <select class="form-control" name="contestType" id="Type">
                                            <option value="PERSONAL">个人</option>
                                            <option value="TEAM">组队</option>
                                            <option value="MIX_TEAM">混合</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-1"></div>
                                <div class="col-lg-5">
                                    <div class="form-group pull-light">
                                        <label>
                                            <input id="true_false"
                                                   type="checkbox"
                                                   name="realContest" value="true">
                                            Real Contest
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <input type="text" value="${preContest.startTimeStr}" id="startTime"
                                               name="stTime" class="form-control" placeholder="开始时间" autofocus required>
                                    </div>
                                </div>
                                <div class="col-lg-1"></div>
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <input type="text" value="${preContest.endTimeStr}" id="endTime" name="edTime"
                                               class="form-control" placeholder="结束时间" autofocus required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-11">
                                    <div class="form-group">
                                        <textarea name="vjContest" class="form-control" rows="15" placeholder="VJudge榜单"
                                                  required>${preContest.rawData.left}</textarea>
                                    </div>
                                </div>
                                <div class="col-lg-11">
                                    <div class="form-group">
                                        <textarea name="myConfig" class="form-control" rows="8"
                                                  placeholder="配置文件">${preContest.rawData.right}</textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <input type="text" value="${preContest.source}" name="source"
                                               class="form-control" placeholder="比赛来源" autofocus>
                                    </div>
                                </div>
                                <div class="col-lg-1"></div>
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <input type="text" value="${preContest.sourceDetail}" name="sourceDetail"
                                               class="form-control" placeholder="比赛全称" autofocus>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-11">
                                    <div class="form-group">
                                        <input type="text" value="${preContest.sourceUrl}" name="sourceUrl"
                                               class="form-control" placeholder="比赛链接" autofocus>
                                    </div>
                                </div>
                                <div class="col-lg-1">

                                </div>
                            </div>
                            <div class="col-lg-11">
                                <div class="form-group pull-right">
                                    <button class="btn btn-lg btn-primary btn-block" type="submit">导入</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="co-lg-2">
            </div>
        </div>
    </div>

    <c:if test="${!empty tip}">
    <script>
        alert('${tip}');
    </script>
    </c:if>
    <jsp:include page="footerInfo.jsp"/>
</body>
</html>
