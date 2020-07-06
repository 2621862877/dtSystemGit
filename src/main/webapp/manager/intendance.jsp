<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>跟踪任务</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if($(":radio:checked").length == 0){
                    alert("您还未选择需要计划信息的任务！");
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
                <p>您现在的位置 &gt;&gt; 跟踪任务 &gt;&gt; 跟踪任务信息</p>
                <h1>跟踪任务:</h1>
                <form id="form1" name="form1" method="post" action="${ctp}task/queryTaskById/programinten">
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">任务名称</td>
                            <td class="tdcolor">实施人</td>
                            <td class="tdcolor">开始时间</td>
                            <td class="tdcolor">结束时间</td>
                            <td class="tdcolor">任务状态</td>
                            <td class="tdcolor">&nbsp;</td>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="task">
                            <tr>
                                <td>${task.taskName}</td>
                                <td>${task.employee.realName}</td>
                                <td>${task.beginDateStr}</td>
                                <td>${task.endDateStr}</td>
                                <td>${task.status}</td>
                                <td><label>
                                    <input type="radio" name="taskId" value="${task.taskId}"/>
                                </label></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" type="submit" class="menu3" value="计划信息"/>
                        </label>
                    </p>
                </form>
                <div style="text-align: center;font-size: 16px;">
                    <a href="${ctp}task/queryIntendanceByParentId?page=1&size=${pageInfo.pageSize}">首页</a>
                    <a href="${ctp}task/queryIntendanceByParentId?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页</a>
                    <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                        <a href="${ctp}task/queryIntendanceByParentId?page=${pageNum}&size=${pageInfo.pageSize}" ${pageNum == pageInfo.pageNum ? "style='color:red;font-weight: bold'" : ''}>${pageNum}</a>
                    </c:forEach>
                    <a href="${ctp}task/queryIntendanceByParentId?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">下一页</a>
                    <a href="${ctp}task/queryIntendanceByParentId?page=${pageInfo.pages}&size=${pageInfo.pageSize}">尾页</a>
                    当前是第${pageInfo.pageNum}页/共${pageInfo.pages}页/共${pageInfo.total}条数据
                </div>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
