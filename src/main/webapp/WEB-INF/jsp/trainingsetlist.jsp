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
    <title>集训列表 - ACManager</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <script src="//cdn.bootcss.com/jquery/3.1.0/jquery.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="//cdn.bootcss.com/jquery-datetimepicker/2.5.4/build/jquery.datetimepicker.full.js"></script>
    <script src="//cdn.bootcss.com/datatables/1.10.13/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/datatables/1.10.13/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="//cdn.bootcss.com/jquery-datetimepicker/2.5.4/jquery.datetimepicker.css"/>

    <c:url value="/training/doAddTraining" var="url_doAddTraining"/>
    <c:url value="/training/doApplyJoinTraining" var="url_applyjoin"/>
    <c:url value="/training/modifyTraining" var="url_modify"/>
    <script>
        $(document).ready(function () {
            $('#mytable').DataTable({
                "order": [[2, "desc"]]
            });
            $('#savabutton').click(function () {
                $.post("${url_doAddTraining}", {
                    name: $('#name').val(),
                    startDate: $('#beginTime').val(),
                    endDate: $('#endTime').val(),
                    remark: $('#remark').val()
                }, function (data) {
                    alert(data);
                    location.reload();
                })
            });
            $('#savabutton2').click(function () {
                $.post("${url_modify}", {
                    id:$('#id2').val(),
                    name: $('#name2').val(),
                    startDate: $('#beginTime2').val(),
                    endDate: $('#endTime2').val(),
                    remark:$('#remark2').val(),
                    standard:$('#standard2').val(),
                    expand:$('#expand2').val(),
                    mergeLimit:$('#mergeLimit2').val(),
                    waCapcity:$('#waCapcity2').val(),
                    ratingBase:$('#ratingBase2').val(),
                    ratingMultiple:$('#ratingMultiple2').val(),
                    tauMultiple:$('#tauMultiple2').val(),
                    teamScoreRate1:$('#teamScoreRate1_2').val(),
                    teamScoreRate2:$('#teamScoreRate2_2').val(),
                    teamScoreRate3:$('#teamScoreRate3_2').val(),
                    teamScoreRate0:$('#teamScoreRate0_2').val()
                }, function (data) {
                    alert(data);
                    location.reload();
                })
            });
            $('#beginTime').datetimepicker({
                format:'Y-m-d',
                formatDate:'Y-m-d',
                timepicker:false,
                dayOfWeekStart : 1,
                lang:'en',
            });
            $('#beginTime2').datetimepicker({
                format:'Y-m-d',
                formatDate:'Y-m-d',
                timepicker:false,
                dayOfWeekStart : 1,
                lang:'en',
            });
            $('#endTime').datetimepicker({
                format:'Y-m-d',
                formatDate:'Y-m-d',
                timepicker:false,
                dayOfWeekStart : 1,
                lang:'en',
            });
            $('#endTime2').datetimepicker({
                format:'Y-m-d',
                formatDate:'Y-m-d',
                timepicker:false,
                dayOfWeekStart : 1,
                lang:'en',
            });
        });
        function applyJoin(trainingId) {
            $.post("${url_applyjoin}",{
                userId: '${user.id}',
                trainingId: trainingId
            },function (date) {
                alert(date);
                location.reload();
            });
        }
        function updata(obj,id) {
            var tds=$(obj).parent().parent().find('td');
            var str=tds.eq(0).text();
            var str1=$.trim(str);
            $('#name2').val(str1);
            $('#beginTime2').val(tds.eq(1).text());
            $('#endTime2').val(tds.eq(2).text());
            $('#remark2').val(tds.eq(4).text());
            $('#standard2').val(tds.eq(5).text());
            $('#expand2').val(tds.eq(6).text());
            $('#mergeLimit2').val(tds.eq(7).text());
            $('#waCapcity2').val(tds.eq(8).text());
            $('#ratingBase2').val(tds.eq(9).text());
            $('#ratingMultiple2').val(tds.eq(10).text());
            $('#tauMultiple2').val(tds.eq(11).text());
            var num1 = parseFloat(tds.eq(12).text());
            var num2 = parseFloat(tds.eq(13).text());
            var num3 = parseFloat(tds.eq(14).text());
            $('#teamScoreRate1_2').val(num1.toFixed(2));
            $('#teamScoreRate2_2').val(num2.toFixed(2));
            $('#teamScoreRate3_2').val(num3.toFixed(2));
            $('#teamScoreRate0_2').val((1.0-num1-num2-num3).toFixed(2));
            $('#id2').val(id);
        }

        function exportTable() {
            $("#mytable").table2excel({
                name: "doc1",
                filename: "所有集训"
            });
        }
    </script>
</head>
<body>

<div class="container-fluid"  style="margin-right: 0.7%;margin-left: 0.7%">
    <jsp:include page="topBar.jsp"/>
    <div class="row">
        <ol class="breadcrumb">
            <li>您所在的位置：</li>
            <li class="active">集训列表</li>
        </ol>
    </div>



    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">所有集训</h3>
            </div>
            <div class="panel-body">
                    <div class="row" style="padding-left: 20px">
                        <div class="pull-left">
                            <c:url value="/training/searchContest" var="url_search"/>
                            <a class="btn btn-info btn-sm" href="${url_search}">搜索比赛</a>
                            <c:if test="${user.isAdmin()}">
                                <button class="btn btn-info btn-sm" id="addbutton" data-toggle="modal"
                                        data-target="#myModal">添加集训</button>
                            </c:if>
                            <button class="btn btn-info btn-sm" onclick="exportTable()">导出表格</button>
                        </div>
                    </div>
                    <hr style="margin:10px "/>

                <table class="table table-condensed table-striped table-hover display" id="mytable">
                    <thead class="tab-header-area">
                    <tr>
                        <th>集训名称</th>
                        <th>开始时间</th>
                        <th>结束时间</th>
                        <th hidden>添加时间</th>
                        <th hidden>备注</th>
                        <th hidden>基准分</th>
                        <th hidden>标准距离</th>
                        <th hidden>mergeLimit</th>
                        <th hidden>waCapcity</th>
                        <td hidden>ratingBase</td>
                        <td hidden>ratingMultiple</td>
                        <td hidden>tauMultiple</td>
                        <td hidden>teamScoreRate1</td>
                        <td hidden>teamScoreRate2</td>
                        <td hidden>teamScoreRate3</td>
                        <th>阶段</th>
                        <th>比赛</th>
                        <th>创建者</th>
                        <c:if test="${!empty user}">
                            <th>状态</th>
                        </c:if>
                        <c:if test="${(!empty user) and (user.isAdmin())}">
                            <th>操作</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tfoot>

                    </tfoot>

                    <tbody>
                    <c:set value="Success" var="success"/>
                    <c:set value="Pending" var="pending"/>
                    <c:set value="Reject" var="reject"/>

                    <c:forEach items="${allList}" var="training">
                        <c:set value="${ujointMap.get(training.id).status.name()}" var="curUStatus"/>
                        <tr>
                            <td>
                                <a href="<c:url value="/training/detail/${training.id}"/> ">${training.name}</a>
                            </td>
                            <td>${training.startDate}</td>
                            <td>${training.endDate}</td>
                            <td hidden>${training.addTime}</td>
                            <td hidden>${training.remark}</td>
                            <td hidden>${training.standard}</td>
                            <td hidden>${training.expand}</td>
                            <td hidden>${training.mergeLimit}</td>
                            <td hidden>${training.waCapcity}</td>
                            <td hidden>${training.ratingBase}</td>
                            <td hidden>${training.ratingMultiple}</td>
                            <td hidden>${training.tauMultiple}</td>
                            <td hidden>${training.teamScoreRate1}</td>
                            <td hidden>${training.teamScoreRate2}</td>
                            <td hidden>${training.teamScoreRate3}</td>
                            <td>${training.stageList.size()}</td>
                            <td>${training.contestCount()}</td>
                            <td>${trainingAddUserList.get(training.addUid).username}</td>
                            <c:if test="${!empty user}">
                                <td>
                                    <c:choose>
                                        <c:when test="${(!empty user) && (user.isAdmin())}">
                                            <a href="<c:url value="/training/trainingUser/${training.id}"/>">审核队员</a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${!empty ujointMap.get(training.id)}">
                                                <c:choose>
                                                    <c:when test="${curUStatus eq success}">
                                                        <span>成功加入</span>
                                                    </c:when>
                                                    <c:when test="${curUStatus eq pending}">
                                                        <span>申请中</span>
                                                    </c:when>
                                                    <c:when test="${curUStatus eq reject}">
                                                        <span>被拒绝</span>
                                                    </c:when>
                                                </c:choose>
                                                <c:if test="${curUStatus eq reject}">
                                                    <span><a href="javascript:void(0);" onclick="applyJoin(${training.id})">(重新申请)</a></span>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${empty ujointMap.get(training.id)}">
                                                <a href="javascript:void(0);" onclick="applyJoin(${training.id})">申请加入</a>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </c:if>
                            <c:if test="${(!empty user) and (user.isAdmin())}">
                                <td>
                                    <a  id="modifybutton" data-toggle="modal" data-target="#myModal2"
                                        onclick="updata(this,${training.id})">编辑</a>
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加集训</h4>
            </div>
            <div class="modal-body">
                <form class="form" action="" method="post"><!--填写提交地址-->
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="名称" id="name" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="开始时间" id="beginTime" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="截止时间" id="endTime" required>
                    </div>
                    <div class="form-group">
                        <textarea rows="5" class="form-control" placeholder="备注" id="remark"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="savabutton">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modifyModalLabel">编辑属性</h4>
            </div>
            <div class="modal-body">
                <form class="form" action="" method="post"><!--填写提交地址-->
                    <div class="form-group">
                        集训名称：<input type="text" class="form-control" placeholder="名称" id="name2" required>
                    </div>
                    <div class="form-group">
                        开始日期:<input type="text" class="form-control" placeholder="开始时间" id="beginTime2" required>
                    </div>
                    <div class="form-group">
                        截止时间:<input type="text" class="form-control" placeholder="截止时间" id="endTime2" required>
                    </div>
                    <div class="form-group">
                        备注：<textarea rows="5" class="form-control" placeholder="备注" id="remark2"></textarea>
                    </div>
                    <div class="row">
                        <div class="form-group col-lg-4">
                            基准分：<input type="number" class="form-control" id="standard2" required>
                        </div>
                        <div class="form-group col-lg-4">
                            标准距离：<input type="number" class="form-control" id="expand2" required>
                        </div>
                        <div class="form-group col-lg-4">
                            平局偏差距离：<input type="number" class="form-control"  id="mergeLimit2" required>
                        </div>
                    </div>
                    <div class="form-group">
                        WACapcity：<input type="text" class="form-control" id="waCapcity2" required>
                    </div>
                    <div class="row">
                        <%--<div class="form-group col-lg-4">--%>
                            <%--RatingBase：<input type="number" class="form-control" id="ratingBase2" required>--%>
                        <%--</div>--%>
                        <%--<div class="form-group col-lg-4">--%>
                            <%--RatingMultiple：<input type="number" class="form-control" id="ratingMultiple2" required>--%>
                        <%--</div>--%>
                        <div class="form-group col-lg-12">
                            TAUMultiple：<input type="number" class="form-control" id="tauMultiple2" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-lg-3">
                            Team：<input type="number" class="form-control" id="teamScoreRate0_2" required>
                        </div>
                        <div class="form-group col-lg-3">
                            BestMember：<input type="number" class="form-control" id="teamScoreRate1_2" required>
                        </div>
                        <div class="form-group col-lg-3">
                            MiddleMember：<input type="number" class="form-control" id="teamScoreRate2_2" required>
                        </div>
                        <div class="form-group col-lg-3">
                            LastMember：<input type="number" class="form-control" id="teamScoreRate3_2" required>
                        </div>
                    </div>
                    <div class="form-group" hidden>
                        集训id：<input type="text" class="form-control" placeholder="id" id="id2" hidden>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="savabutton2">保存</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footerInfo.jsp"/>
</body>
</html>
