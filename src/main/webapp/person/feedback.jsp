<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>反馈信息</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#form1").submit(function () {
                if (${plan.isFeedback == '已反馈'}) {
                    alert("已反馈的计划不得再修改!");
                    return false;
                }
                var status = $("#status").val();
                var isFeedback = $("#isFeedback").val();
                // 如果反馈修改为已反馈则必须计划状态改为已完成一并提交
                if (isFeedback == "已反馈" && status != '已完成'){
                    alert('计划状态为已完成的情况下才可以将反馈状态修改为已反馈');
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
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left2.lbi" -->
            <jsp:include page="../common/personMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 计划管理 &gt;&gt; 反馈信息</p>
                <form id="form1" name="form1" method="post" action="${ctp}plan/updatePlan">
                    <input type="hidden" name="planId" value="${plan.planId}"/>
                    <h1>输入反馈信息:</h1>

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
                            <td width="579" class="tdcolor">结束时间</td>
                            <td width="579"><p>${plan.endDateStr}</p></td>
                        </tr>

                        <tr>
                            <td class="tdcolor">计划状态</td>
                            <td colspan="3">
                                <select id="status" name="status">
                                    <option ${plan.status == '未实施' ? 'selected' : ''}>未实施</option>
                                    <option ${plan.status == '实施中' ? 'selected' : ''}>实施中</option>
                                    <option ${plan.status == '已完成' ? 'selected' : ''}>已完成</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td class="tdcolor">是否反馈</td>
                            <td colspan="3"><select id="isFeedback" name="isFeedback">
                                <option ${plan.isFeedback == '未反馈' ? 'selected' : ''}>未反馈</option>
                                <option ${plan.isFeedback == '已反馈' ? 'selected' : ''}>已反馈</option>
                            </select></td>
                        </tr>
                        <tr>
                            <td class="tdcolor">反馈信息</td>
                            <td colspan="3"><label>
                                <textarea name="feedbackInfo" cols="60" rows="4">${plan.feedbackInfo}</textarea>
                            </label></td>
                        </tr>
                    </table>
                    <p>
                        <input name="Submit" type="button" onclick="history.go(-1)" class="menu2" value="取消"/>
                        <input name="Submit" type="submit" class="menu1" value="提交"/>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
