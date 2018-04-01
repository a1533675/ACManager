<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/9
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>比赛列表 - ACManager</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="//cdn.bootcss.com/datatables/1.10.13/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/datatables/1.10.13/css/jquery.dataTables.min.css">


    <script>
        $(document).ready(function () {
            $('#mytable').DataTable({
                "order": [[2, "desc"]],
            });
        });
    </script>

    <script>
        function exportTable() {
            $("#mytable").table2excel({
                name: "doc1",
                filename: "比赛列表"
            });
        }
    </script>

</head>
<body>

<div class="container-fluid"  style="margin-right: 0.7%;margin-left: 0.7%">
    <jsp:include page="topBar.jsp" />
    <div class="row">
        <ol class="breadcrumb">
            <li>您所在的位置：</li>
            <li><a href="<c:url value="/training/list"/> ">集训列表</a></li>
            <li><a href="<c:url value="/training/detail/${info.training.id}"/>">阶段列表</a></li>
            <li class="active">${info.name}</li>
        </ol>
    </div>



    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">比赛列表</h3>
            </div>
            <div class="panel-body">
                <div class="row" style="padding-left: 20px">
                    <div class="pull-left">
                        <c:if test="${user.isAdmin()}">
                            <button class="btn btn-info btn-sm" id="addbutton">添加比赛</button>
                        </c:if>
                        <button class="btn btn-info btn-sm" onclick="exportTable()">导出表格</button>
                    </div>
                </div>
                <hr style="margin:10px "/>

                <table class="table table-condensed table-striped table-hover display" id="mytable">
                    <thead class="tab-header-area">
                    <tr>
                        <th>比赛名称</th>
                        <th>开始时间</th>
                        <th>结束时间</th>
                        <th>时长</th>
                        <th>类型</th>
                        <th>来源</th>
                        <th>队伍</th>
                        <th>创建者</th>
                        <c:if test="${(!empty user) && (user.isAdmin())}">
                            <th>操作</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tfoot>

                    </tfoot>

                    <tbody>
                    <c:forEach items="${contestList}" var="contest">
                        <tr>
                            <c:url value="/contest/showContest/${contest.id}" var="url_curcontest"/>
                            <c:url value="/contest/showScore/${contest.id}" var="url_curcontestScore"/>
                            <td><a href="${url_curcontestScore}">${contest.name}</a></td>
                            <td>${contest.startTimeStr}</td>
                            <td>${contest.endTimeStr}</td>
                            <td>${contest.lengeh()}</td>
                            <c:set value="PERSONAL" var="Personal"/>
                            <c:set value="TEAM" var="Team"/>
                            <c:set value="MIX_TEAM" var="MixTeam"/>
                            <td>
                                <c:choose>
                                    <c:when test="${contest.type eq Personal}">
                                        个人
                                    </c:when>
                                    <c:when test="${contest.type eq Team}">
                                        组队
                                    </c:when>
                                    <c:when test="${contest.type eq MixTeam}">
                                        混合
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty contest.sourceUrl}">
                                        ${contest.source}
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${contest.sourceUrl}" target="_blank">${contest.source}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${contest.ranks.size()}</td>
                            <td>${contestAddUserList.get(contest.addUid).username}</td>
                            <c:if test="${(!empty user) && (user.isAdmin())}">
                                <td>
                                    <a href="<c:url value="/contest/modify/${contest.id}"/> ">编辑</a>&nbsp;
                                    <%--<a href="<c:url value="/contest/deleteContest/${contest.id}"/> ">删除</a>--%>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<script>
    $(document).ready(function () {
        $("#addbutton").click(function () {
            location.href="<c:url value="/contest/add1/${info.id}"/>";
        })
    })
</script>
<c:if test="${!empty tip}">
    <script>
        alert('${tip}');
    </script>
</c:if>
<jsp:include page="footerInfo.jsp"/>
</body>
</html>
