<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>跟踪计划信息</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                var status = $("#status").val();
                if (${task.status == '实施中'} && status == '未实施'){
                    alert("不能将实施中的任务更改为未实施！");
                    return false;
                }
            });
            // 勾选复选框后点击反馈信息就是显示选中的计划的反馈信息
            $("#feedBack").click(function () {
                // 选中的所有复选框数组 存的是反馈信息tr的ID
                var ckbs = $(":checkbox:checked");
                $("tr[id]").hide();
                if (ckbs.length == 0){
                    alert("请选择需要查看反馈信息的复选框！");
                    return;
                }
                for (var i = 0; i < ckbs.length; i++){
                    var id = ckbs[i].value;
                    $("#"+id).show();
                }
            });
        });
    </script>
</head>

<body><!-- #BeginLibraryItem "/Library/topbanner.lbi" -->
<div id="logo"><img src="${ctp}images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left.lbi" -->
            <jsp:include page="../common/managerMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 跟踪任务 &gt;&gt; 跟踪计划信息</p>
                <form id="form1" name="form1" method="post" action="${ctp}task/updateTaskStatus">
                    <input type="hidden" name="taskId" value="${task.taskId}"/>
                    <h1>任务详细信息:</h1>

                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">任务名称</td>
                            <td width="579" colspan="3">${task.taskName}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">任务描述</td>
                            <td colspan="3">${task.taskDesc}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">开始时间</td>
                            <td width="579">${task.beginDateStr}</td>
                            <td width="579" class="tdcolor">结束时间</td>
                            <td width="579"><p>${task.endDateStr}</p></td>
                        </tr>

                        <tr>
                            <td class="tdcolor">实施人</td>
                            <td>${task.employee.realName}</td>
                            <td class="tdcolor">任务状态</td>
                            <td>
                                <select id="status" name="status">
                                    <option ${'未实施' == task.status ? 'selected' : ''}>未实施</option>
                                    <option ${'实施中' == task.status ? 'selected' : ''}>实施中</option>
                                    <option ${'已完成' == task.status ? 'selected' : ''}>已完成</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <input name="Submit" type="submit" class="menu4" value="提交"/>
                </form>
                <form id="form2" name="form1" method="post" action="#">
                    <h1>计划信息：</h1>
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">计划名称</td>
                            <td width="15%" class="tdcolor">完成状态</td>
                            <td class="tdcolor">是否反馈</td>
                            <td class="tdcolor">开始时间</td>
                            <td class="tdcolor">结束时间</td>
                            <td class="tdcolor">&nbsp;</td>
                        </tr>
                        <c:forEach items="${task.plans}" var="plan">
                            <tr>
                                <td>${plan.planName}</td>
                                <td>${plan.status}</td>
                                <td>${plan.isFeedback}</td>
                                <td>${plan.beginDateStr}</td>
                                <td>${plan.endDateStr}</td>
                                <c:if test="${'已反馈' == plan.isFeedback}">
                                    <td><label>
                                        <input type="checkbox" name="isFeedback" value="${plan.planId}"/>
                                    </label></td>
                                </c:if>
                            </tr>
                            <tr id="${plan.planId}" style="display: none">
                                <td colspan="6">${plan.feedbackInfo}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" id="feedBack" type="button" class="menu3" value="反馈信息"/>
                        </label>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/copyright.lbi" -->
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem -->
</body>
</html>
