<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>任务详细信息</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/><script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if($(":radio:checked").length == 0){
                    alert("您还未选择需要查看详情的计划！");
                    return false;
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
                <p>您现在的位置 &gt;&gt; 查看任务 &gt;&gt; 任务详细信息</p>
                <h1>任务详细信息:</h1>

                <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                    <tr>
                        <td width="15%" class="tdcolor">任务名称</td>
                        <td width="579" colspan="5">${task.taskName}</td>
                    </tr>
                    <tr>
                        <td class="tdcolor">任务描述</td>
                        <td colspan="5">${task.taskDesc}</td>
                    </tr>
                    <tr>
                        <td class="tdcolor">开始时间</td>
                        <td width="15%">${task.beginDateStr}</td>
                        <td width="20%" class="tdcolor">结束时间</td>
                        <td width="50%" colspan="3"><p>${task.endDateStr}</p></td>
                    </tr>
                    <tr>
                        <td class="tdcolor">实际开始时间</td>
                        <td>${task.realBeginDateStr}</td>
                        <td class="tdcolor">实际结束时间</td>
                        <td colspan="3">${task.realEndDateStr}</td>
                    </tr>
                    <tr>
                        <td class="tdcolor">实施人</td>
                        <td>${task.employee.realName}</td>
                        <td class="tdcolor">任务状态</td>
                        <td>${task.status}</td>
                        <td class="tdcolor">计划数目</td>
                        <td>${fn:length(task.plans)}</td>
                    </tr>
                </table>
                <form id="form1" name="form1" method="post" action="${ctp}plan/queryPlanById">
                    <h1>实施计划：</h1>
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">计划名称</td>
                            <td width="15%" class="tdcolor">完成状态</td>
                            <td width="20%" class="tdcolor">是否反馈</td>
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
                                <td><label>
                                    <input type="radio" name="planId" value="${plan.planId}"/>
                                </label></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" type="submit" class="menu3" value="详细信息"/>
                        </label>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
