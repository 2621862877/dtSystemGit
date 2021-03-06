<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>用户管理</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if ($(":radio:checked").length == 0) {
                    alert("您还未选择需要删除的员工!");
                    return false;
                }
                var val = $(":radio:checked").val();
                if (val == ${user.employeeId}){
                    alert("不能删除自己!");
                    return false;
                }
                return confirm("删除该员工对应的所有任务和计划都会一并删除，确认删除吗？");
            });
        });
    </script>
</head>

<body><!-- #BeginLibraryItem "/Library/topbanner.lbi" -->
<div id="logo"><img src="${ctp}images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left3.lbi" -->
            <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
            <jsp:include page="../common/menu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 员工管理 &gt;&gt; 员工列表</p>
                <h1>用户详细信息:</h1>

                <form id="form1" name="form1" method="post" action="${ctp}employee/deleteById">
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">用户名称</td>
                            <td class="tdcolor">用户密码</td>
                            <td class="tdcolor">用户角色</td>
                            <td class="tdcolor">真实姓名</td>
                            <td class="tdcolor">入职时间</td>
                            <td class="tdcolor">职位信息</td>
                            <td class="tdcolor">&nbsp;</td>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="emp">
                            <tr>
                                <td>${emp.employeeName}</td>
                                <td>${emp.password}</td>
                                <td>${emp.role.roleName}</td>
                                <td>${emp.realName}</td>
                                <td>${emp.enrolldateStr}</td>
                                <td>${emp.duty}</td>
                                <td><label>
                                    <input type="radio" name="id" value="${emp.employeeId}"/>
                                </label></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <p>
                        <label>
                            <input name="Submit" type="submit" class="menu3" value="删除人员"/>
                        </label>
                        <label></label>
                    </p>
                </form>
                <div style="text-align: center;font-size: 16px;">
                    <a href="${ctp}employee/userManager/empadmin?page=1&size=${pageInfo.pageSize}">首页</a>
                    <a href="${ctp}employee/userManager/empadmin?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页</a>
                    <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                        <a ${pageNum == pageInfo.pageNum ? "style='color:red;font-weight: bold'" : ''} href="${ctp}employee/userManager/empadmin?page=${pageNum}&size=${pageInfo.pageSize}">${pageNum}</a>
                    </c:forEach>
                    <a href="${ctp}employee/userManager/empadmin?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">下一页</a>
                    <a href="${ctp}employee/userManager/empadmin?page=${pageInfo.pages}&size=${pageInfo.pageSize}">尾页</a>
                    当前是第${pageInfo.pageNum}页/共${pageInfo.pages}页/共${pageInfo.total}条数据
                </div>
                <p>&nbsp;</p>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
