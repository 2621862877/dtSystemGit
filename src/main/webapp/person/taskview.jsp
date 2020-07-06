<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>计划信息</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if($(":radio:checked").length == 0){
                    alert("您还未选择需要删除的计划！");
                    return false;
                }
                if (${task.status != '实施中'}){
                    alert("任务的状态处于“实施中”才能进行删除操作!");
                    return false;
                }
                return confirm("确定要删除这个计划吗?");
            });

            // 新建按钮单击事件
            $("#newBtn").click(function () {
                if (${task.status != '实施中'}){
                    alert("该任务${task.status},不能新建计划!");
                    return false;
                }
                // 跳往新建计划页面 传入任务ID
                location.href = "${ctp}person/newpro.jsp?taskId=${task.taskId}";
            });
        });
    </script>
</head>

<body><!-- #BeginLibraryItem "/Library/topbanner.lbi" -->
<div id="logo"><img src="${ctp}images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left2.lbi" -->
            <jsp:include page="../common/personMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 计划管理 &gt;&gt; 计划信息</p>
                <form id="form1" name="form1" method="post" action="${ctp}plan/deleteById">
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
                                ${task.status}
                            </td>
                        </tr>
                    </table>
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
                                <td><a href="#" target="_self">${plan.planName}</a></td>
                                <td>${plan.status}</td>
                                <td>${plan.isFeedback}</td>
                                <td>${plan.beginDateStr}</td>
                                <td>${plan.endDateStr}</td>
                                <%--只准删除未完成的计划--%>
                                <c:if test="${plan.status == '未实施'}">
                                    <td><label>
                                        <input type="radio" name="planId" value="${plan.planId}"/>
                                    </label></td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <input id="newBtn"  name="Submit2" type="button" class="menu2" value="新建"/>
                        <input name="Submit" type="submit" class="menu1" value="删除"/>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
