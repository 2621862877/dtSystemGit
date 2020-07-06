<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>调整任务</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}/js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                var inputs = $(":input[name]");
                // 只要有一个的value值为空就禁止提交
                for (var i = 0; i < inputs.length; i++) {
                    var inp = inputs[i];
                    if ($(inp).val() == "" && $(inp).prop("name") != 'taskDesc'){
                        alert("请填写完整的任务信息!");
                        return false;
                    }
                }

                // 正则验证日期
                var reg = /^[1-9]\d{3}-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
                var regExp = new RegExp(reg);
                var beginDate = $(":input[name='beginDate']").val();
                var endDate = $(":input[name='endDate']").val();
                if(!regExp.test(beginDate) || !regExp.test(endDate)){
                    alert("日期格式不正确，正确格式为：yyyy-MM-dd");
                    return false;
                }

                // 判断开始日期是否小于结束日期
                var date1 = new Date(beginDate.replace(/-/g,"/"));
                var date2 = new Date(endDate.replace(/-/g,"/"));
                if (date1 - date2  > 0){
                    alert("开始日期不能小于结束日期！");
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
                <p>您现在的位置 &gt;&gt; 调整任务 &gt;&gt; 调整任务信息</p>
                <h1>调整任务信息</h1>

                <form id="form1" name="form1" method="post" action="${ctp}task/updateTask">
                    <input type="hidden" name="taskId" value="${task.taskId}"/>
                    <p>任务名称：<label>
                        <input name="taskName" value="${task.taskName}" type="text" size="50"/>
                    </label></p>
                    <p>任务描述：
                        <label>
                            <textarea name="taskDesc">${task.taskDesc}</textarea>
                        </label>
                    </p>
                    <p>开始时间：
                        <label>
                            <input name="beginDate" value="${task.beginDateStr}" type="text" size="16"/>
                        </label>
                        <span class="marginleft1">结束时间：
              <label>
                <input name="endDate" value="${task.endDateStr}" type="text" size="16"/>
              </label></span>
                    </p>
                    <p>实施人员：
                        <label>
                            <select name="implementorId">
                                <c:forEach items="${emps}" var="emp">
                                    <%--默认选中原有的实施人--%>
                                    <option ${emp.employeeId == task.implementorId ? "selected" : ""}
                                            value="${emp.employeeId}">${emp.realName}</option>
                                </c:forEach>
                            </select>
                        </label>
                        <%--主管可以修改任务状态 --%>
                        <span class="marginleft">任务状态：
                            <label>
                                <select name="status">
                                    <option ${'未实施' == task.status ? 'selected' : ''}>未实施</option>
                                    <option ${'实施中' == task.status ? 'selected' : ''}>实施中</option>
                                    <option ${'已完成' == task.status ? 'selected' : ''}>已完成</option>
                                </select>
                            </label>
            </span></p>
                    <p>
                        <label>
                            <input type="reset" class="menu2" value="重置"/>
                        </label>
                        &nbsp;
                        <label>
                            <input type="submit" class="menu1" value="提交"/>
                        </label>
                    </p>
                </form>
                <p>&nbsp;</p>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
