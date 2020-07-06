<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>未实施任务</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if($(":radio:checked").length == 0){
                    alert("您还未选择需要删除的任务！");
                    return false;
                }
                return confirm("删除任务会一并删除任务下的所有计划,您确定要删除此任务吗?");
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
                <p>您现在的位置 &gt;&gt; 查看任务 &gt;&gt; 未实施任务信息</p>
                <h1>未实施任务信息:</h1>
                <form id="form1" name="form1" method="post" action="${ctp}task/deleteById">
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor"><a href="#" target="_self">任务名称</a></td>
                            <td class="tdcolor"><a href="#" target="_self">实施人</a></td>
                            <td class="tdcolor"><a href="#" target="_self">开始时间</a></td>
                            <td class="tdcolor"><a href="#" target="_self">结束时间</a></td>
                            <td class="tdcolor"><a href="#" target="_self">任务状态</a></td>
                            <td class="tdcolor">&nbsp;</td>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="task">
                            <tr>
                                <td><a style="color:blue;" href="${ctp}task/queryTaskById/adjust?taskId=${task.taskId}">${task.taskName}</a></td>
                                <td>${task.employee.realName}</td>
                                <td>${task.beginDateStr}</td>
                                <td>${task.endDateStr}</td>
                                <td>${task.status}</td>
                                <td><label>
                                    <% // TODO 可以改为复选框批量删除%>
                                    <input type="radio" name="taskId" value="${task.taskId}"/>
                                </label></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" type="submit" class="menu4" value="删除"/>
                        </label>
                    </p>
                </form>
                <div style="text-align: center;font-size: 16px;">
                    <a href="${ctp}task/queryTaskundoneByParentId?page=1&size=${pageInfo.pageSize}">首页</a>
                    <a href="${ctp}task/queryTaskundoneByParentId?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页</a>
                    <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                        <a href="${ctp}task/queryTaskundoneByParentId?page=${pageNum}&size=${pageInfo.pageSize}" ${pageNum == pageInfo.pageNum ? "style='color:red;font-weight: bold'" : ''}>${pageNum}</a>
                    </c:forEach>
                    <a href="${ctp}task/queryTaskundoneByParentId?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">下一页</a>
                    <a href="${ctp}task/queryTaskundoneByParentId?page=${pageInfo.pages}&size=${pageInfo.pageSize}">尾页</a>
                    当前是第${pageInfo.pageNum}页/共${pageInfo.pages}页/共${pageInfo.total}条数据
                </div>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
