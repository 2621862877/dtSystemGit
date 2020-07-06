<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>分配人员</title>
    <link href="../css/css.css" rel="stylesheet" type="text/css"/>
</head>

<body><!-- #BeginLibraryItem "/Library/topbanner.lbi" -->
<div id="logo"><img src="../images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left3.lbi" -->
            <jsp:include page="../common/menu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 分配人员</p>
                <h1>用户详细信息:</h1>
                <form id="form0" name="form1" method="post" action="${ctp}employee/empManager">
                    <input type="hidden" name="employeeId" value="${emp.employeeId}"/>
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td class="tdcolor">用户名称</td>
                            <td>${emp.employeeName}</td>
                        </tr>
                        <tr>
                            <td width="15%" class="tdcolor">真实姓名</td>
                            <td>${emp.realName}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">员工角色</td>
                            <td>${emp.role.roleName}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">性&nbsp;&nbsp;&nbsp; 别</td>
                            <td>${emp.sex}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">入职时间</td>
                            <td>${emp.enrolldateStr}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">职位信息</td>
                            <td>${emp.duty}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">出生年月</td>
                            <td>${emp.birthdayStr}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">学历信息</td>
                            <td>${emp.education}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">专业信息</td>
                            <td>${emp.major}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">行业经验</td>
                            <td>${emp.experience}</td>
                        </tr>
                        <tr>
                            <td class="tdcolor">上级主管</td>
                            <td><label>
                                <select name="parentId">
                                    <c:forEach items="${managers}" var="manager">
                                        <%--员工的主管id等于遍历的主管id则默认选中--%>
                                        <option value="${manager.employeeId}" ${manager.employeeId == emp.parentId ? "selected" :""}>${manager.realName}</option>
                                    </c:forEach>
                                </select>
                            </label></td>
                        </tr>
                    </table>

                    <p>&nbsp;</p>

                    <p>
                        <input name="Submit" type="reset" onclick="location.href='${ctp}employee/userManager/empdistribute'" class="menu2" value="返回"/>
                        <label>
                            <input name="Submit2" type="submit" class="menu1" value="提交"/>
                        </label>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="../images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
