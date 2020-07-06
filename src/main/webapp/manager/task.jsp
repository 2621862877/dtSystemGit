<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>制定任务</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}/js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                var inputs = $(":input[name]");
                // 只要有一个的value值为空就禁止提交
                for (var i = 0; i < inputs.length; i++) {
                    var inp = inputs[i];
                    if ($(inp).val() == "" ){
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
<link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
<div id="logo"><img src="${ctp}images/top.jpg" width="1002" height="258"/></div>
<!-- #EndLibraryItem -->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left.lbi" -->
            <jsp:include page="../common/managerMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 制定任务 &gt;&gt; 新建任务</p>
                <h1>输入新任务信息</h1>

                <form id="form1" name="form1" method="post" action="${ctp}task/addTask">
                    <p>任务名称：<label>
                        <input name="taskName" type="text" size="50"/>
                    </label></p>
                    <p>任务描述：
                        <label>
                            <textarea name="taskDesc"></textarea>
                        </label>
                    </p>
                    <p>开始时间：
                        <label>
                            <input name="beginDate" type="text" size="16"/>
                        </label>
                        <span class="marginleft1">结束时间：
              <label>
                <input name="endDate" type="text" size="16"/>
              </label></span>
                    </p>
                    <p>实施人员：
                        <label>
                            <select name="implementorId">
                                <c:forEach items="${pageInfo.list}" var="emp">
                                    <option value="${emp.employeeId}">${emp.realName}</option>
                                </c:forEach>
                            </select>
                        </label>
                        <input type="hidden" name="status" value="未实施"/>
                        <input type="hidden" name="assignerId" value="${sessionScope.user.employeeId}"/>
                        <span class="marginleft">任务状态：
             未实施
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
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
