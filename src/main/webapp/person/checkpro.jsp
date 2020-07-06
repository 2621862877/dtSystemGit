<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>查询计划</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}/js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                // 正则验证日期
                var reg = /^[1-9]\d{3}-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
                var regExp = new RegExp(reg);
                var beginDate = $(":input[name='beginDate']").val();
                var beginDateEnd = $(":input[name='beginDateEnd']").val();
                var endDate = $(":input[name='endDate']").val();
                var endDateEnd = $(":input[name='endDateEnd']").val();
                if(    (beginDate != '' && !regExp.test(beginDate))
                    || (beginDateEnd != '' && !regExp.test(beginDateEnd))
                    || (endDate != '' && !regExp.test(endDate))
                    || (endDateEnd != '' && !regExp.test(endDateEnd))){
                    alert("日期格式不正确，正确格式为：yyyy-MM-dd");
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
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left2.lbi" -->
            <jsp:include page="../common/personMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 查询计划 &gt;&gt; 查询</p>
                <form id="form1" name="form1" method="post" action="${ctp}plan/queryPlansByPersonId">
                    <input type="hidden" name="form" value="true"/>
                    <h1>查询信息:</h1>
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <%--所属任务和计划名称必须满足 因为查询计划只能在用户所分配的任务下进行--%>
                            <td width="15%" class="tdcolor">计划名称</td>
                            <td width="579">
                                <input type="text" name="planName" value="${plan.planName}"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdcolor">所属任务</td>
                            <td><select name="taskId">
                                <c:forEach items="${tasks}" var="task">
                                    <option ${plan.taskId == task.taskId ? 'selected' : ''} value="${task.taskId}">${task.taskName}</option>
                                </c:forEach>
                            </select></td>
                        </tr>

                        <tr>
                            <td class="tdcolor">开始时间</td>
                            <td>从
                                <input name="beginDate" type="text" value="${plan.beginDateStr}" size="15"/>
                                到
                                <input name="beginDateEnd" type="text" value="${plan.beginDateEndStr}" size="15"/></td>
                        </tr>
                        <tr>
                            <td class="tdcolor">结束时间</td>
                            <td>从
                                <input name="endDate" value="${plan.endDateStr}" type="text" size="15"/>
                                到
                                <input name="endDateEnd" value="${plan.endDateEndStr}" type="text" size="15"/></td>
                        </tr>
                        <tr>
                            <td class="tdcolor">是否反馈</td>
                            <td><label>
                                <select name="isFeedback">
                                    <option value="">请选择</option>
                                    <option ${plan.isFeedback == '未反馈' ? 'selected' : ''}>未反馈</option>
                                    <option ${plan.isFeedback == '已反馈' ? 'selected' : ''}>已反馈</option>
                                </select>
                            </label></td>
                        </tr>
                    </table>
                    <p>
                        <input name="Submit" type="submit" class="menu3" value="查询计划"/>
                    </p>
                    <h1>计划信息：</h1>
                    <table width="700" border="0" cellpadding="0" cellspacing="0" class="table">
                        <tr>
                            <td width="15%" class="tdcolor">计划名称</td>
                            <td width="15%" class="tdcolor">所属任务</td>
                            <td class="tdcolor">开始时间</td>
                            <td class="tdcolor">结束时间</td>
                            <td class="tdcolor">计划状态</td>
                            <td class="tdcolor">是否反馈</td>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="plan">
                            <tr>
                                    <%--跳往反馈计划页面 需要用计划id查出计划全部信息--%>
                                <td><a style="color:blue;" href="${ctp}plan/queryPlanById?planId=${plan.planId}" target="_self">${plan.planName}</a></td>
                                <td>${plan.task.taskName}</td>
                                <td>${plan.beginDateStr}</td>
                                <td>${plan.endDateStr}</td>
                                <td>${plan.status}</td>
                                <td><label>${plan.isFeedback}</label></td>
                            </tr>
                        </c:forEach>

                       <%-- &lt;%&ndash;默认查询所有的情况&ndash;%&gt;
                        <c:if test="${tasks != null && plans == null}">
                            <c:forEach items="${tasks}" var="task">
                                <c:forEach items="${task.plans}" var="plan">
                                    <tr>
                                        &lt;%&ndash;跳往反馈计划页面 需要用计划id查出计划全部信息&ndash;%&gt;
                                        <td><a style="color:blue;" href="${ctp}plan/queryPlanById?planId=${plan.planId}" target="_self">${plan.planName}</a></td>
                                        <td>${task.taskName}</td>
                                        <td>${plan.beginDateStr}</td>
                                        <td>${plan.endDateStr}</td>
                                        <td>${plan.status}</td>
                                        <td><label>${plan.isFeedback}</label></td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </c:if>--%>
                    </table>
                </form>
                <div style="text-align: center;font-size: 16px;">
                    <a href="${ctp}plan/queryPlansByPersonId?page=1&size=${pageInfo.pageSize}">首页</a>
                    <a href="${ctp}plan/queryPlansByPersonId?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页</a>
                    <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                        <a href="${ctp}plan/queryPlansByPersonId?page=${pageNum}&size=${pageInfo.pageSize}" ${pageNum == pageInfo.pageNum ? "style='color:red;font-weight: bold'" : ''}>${pageNum}</a>
                    </c:forEach>
                    <a href="${ctp}plan/queryPlansByPersonId?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">下一页</a>
                    <a href="${ctp}plan/queryPlansByPersonId?page=${pageInfo.pages}&size=${pageInfo.pageSize}">尾页</a>
                    当前是第${pageInfo.pageNum}页/共${pageInfo.pages}页/共${pageInfo.total}条数据
                </div>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
