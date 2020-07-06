<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>新建计划</title>
    <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctp}js/jquery-1.8.2.js"></script>
    <script type="text/javascript">
        $(function () {
            // 获取查询字符串中传过来的任务ID
            var str = window.location.search.split("=")[1];
            $("#taskId").val(str);

            $("#form1").submit(function () {
                var inputs = $(":input[name]");
                // 只要有一个的value值为空就禁止提交
                for (var i = 0; i < inputs.length; i++) {
                    var inp = inputs[i];
                    if ($(inp).val() == "" ){
                        alert("请填写完整的计划信息!");
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
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left2.lbi" -->
            <link href="${ctp}css/css.css" rel="stylesheet" type="text/css"/>
            <jsp:include page="../common/personMenu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 计划管理 &gt;&gt; 新建计划</p>
                <h1>输入新计划信息</h1>

                <form id="form1" name="form1" method="post" action="${ctp}plan/newPlan">
                    <input type="hidden" id="taskId" name="taskId"/>
                    <p>计划名称：
                        <label>
                            <input name="planName" type="text" size="50"/>
                        </label></p>
                    <p>计划描述：
                        <label>
                            <textarea name="planDesc"></textarea>
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
                    <p>计划状态：未实施 </p>
                    <input type="hidden" name="status" value="未实施"/>
                    <p>是否反馈：未反馈</p>
                    <input type="hidden" name="isFeedback" value="未反馈"/>
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
