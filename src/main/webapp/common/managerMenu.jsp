<%--
  User: JiangJun
  Date: 2020/6/10
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="left">
    <p><a href="${ctp}task/queryAll" target="_self">查看任务</a></p>
    <p><a href="${ctp}employee/queryEmpByParentId/task" target="_self">制定任务</a></p>
    <p><a href="${ctp}task/queryTaskundoneByParentId" target="_self">调整任务</a></p>
    <p><a href="${ctp}task/queryIntendanceByParentId" target="_self">跟踪任务</a></p>
    <p><a href="${ctp}employee/queryEmpByParentId/checkper" target="_self">查看人员</a></p>
    <p><a href="${ctp}logout" target="_self">退出系统</a></p>
</div>
