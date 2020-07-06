<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>计划详细信息</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
</head>

<body><!-- #BeginLibraryItem "/Library/topbanner.lbi" -->
<div id="logo"><img src="${ctp}images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left.lbi" -->
            <jsp:include page="../common/managerMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 查看任务 &gt;&gt; 计划详细信息</p>
                <h1>计划详细信息：</h1>
                <%--action：返回上一步--%>
                <form id="form1" name="form1" method="post" action="javascript:history.go(-1)">

                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">计划名称</td>
                            <td width="579" colspan="3">${plan.planName}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">计划描述</td>
                            <td colspan="3">${plan.planDesc}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">开始时间</td>
                            <td width="579">${plan.beginDateStr}</td>
                            <td width="20%" class="tdcolor">结束时间</td>
                            <td width="50%"><p>${plan.endDateStr}</p></td>
                        </tr>
                        <tr>
                            <td class="tdcolor">所属任务</td>
                            <td>${plan.task.taskName}</td>
                            <td class="tdcolor">计划状态</td>
                            <td>${plan.status}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">反馈信息</td>
                            <td colspan="3">${plan.feedbackInfo}</td>
                        </tr>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" type="submit" class="menu4" value="返回"/>
                        </label>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/copyright.lbi" -->
<div class="copyright">COPYRIGHT 2007 DATANG TELECOM TECHNOLOGY CO.LTD 京ICP备06071639号</div><!-- #EndLibraryItem -->
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem -->
</body>
</html>
