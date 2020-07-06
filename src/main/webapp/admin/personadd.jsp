<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=5"/>
    <title>新建用户</title>
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
                        alert("请填写完整的员工信息!");
                        return false;
                    }
                }

                // 正则验证日期
                var reg = /^[1-9]\d{3}-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
                var regExp = new RegExp(reg);
                var birthday = $(":input[name='birthday']").val();
                var enrolldate = $(":input[name='enrolldate']").val();
                if(!regExp.test(birthday) || !regExp.test(enrolldate)){
                    alert("日期格式不正确，正确格式为：yyyy-MM-dd");
                    return false;
                }

                // 判断两次密码是否一致
                var ps = $(":password");
                if (ps[0].value != ps[1].value){
                    alert("两次密码输入不一致!");
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
        <td class="rightimg"><!-- #BeginLibraryItem "/Library/left3.lbi" -->
            <jsp:include page="../common/menu.jsp"/><!-- #EndLibraryItem -->
            <div id="right">
                <p>您现在的位置 &gt;&gt; 添加人员 &gt;&gt; 人员详细信息</p>
                <h1>人员详细信息:</h1>

                <form id="form1" name="form1" method="post" action="${ctp}employee/addEmp">
                    <p>用户名称：
                        <input name="employeeName" type="text" size="16"/>
                    </p>
                    <p>真实姓名：

                        <input name="realName" type="text" size="16"/>
                    </p>
                    <p>性&nbsp;&nbsp;&nbsp; 别：
                        <input name="sex" type="radio" value="男" checked="checked"/>
                        男
                        <input type="radio" name="sex" value="女"/>
                        女
                    </p>
                    <p>出生年月：
                        <input name="birthday" type="text" size="16"/>
                    </p>
                    <p>职位信息：
                        <input name="duty" type="text" size="16"/>
                    </p>
                    <p>入职时间：
                        <input name="enrolldate" type="text" size="16"/>
                    </p>
                    <p>学历信息：
                        <select name="education">
                            <option value="小学">小学</option>
                            <option value="初中">初中</option>
                            <option value="高中">高中</option>
                            <option value="大学">大学</option>
                            <option value="大专">大专</option>
                            <option value="硕士">硕士</option>
                            <option value="博士">博士</option>
                            <option value="博士后">博士后</option>
                            &nbsp;&nbsp; </select>
                        <span class="marginleft">专业信息：</span>
                        <select name="major">
                            <option value="市场营销">市场营销</option>
                            <option value="金融管理">金融管理</option>
                            <option value="会计">会计</option>
                            <option value="计算机">计算机</option>
                        </select>
                    </p>
                    <p>行业经验：
                        <label>
                            <textarea name="experience" cols="44"></textarea>
                        </label>
                    </p>
                    <p>所属角色：
                        <label>
                            <select name="roleId">
                                <option value="2">系统管理员</option>
                                <option value="3">主管</option>
                                <option value="4">员工</option>
                            </select>
                        </label>
                    </p>
                    <p>初始密码：
                        <input name="password" type="password" size="16" maxlength="6"/>
                    </p>
                    <p>确认密码：
                        <input name="" type="password" size="16" maxlength="6"/>
                    </p>
                    <p>&nbsp; </p>
                    <p>

                        <input type="reset" class="menu2" value="重置"/>

                        &nbsp;

                        <input type="submit" class="menu1" value="提交"/>
                    </p>
                </form>
            </div>
        </td>
    </tr>
</table>
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->
<div id="bottom"><img src="${ctp}images/button.jpg" width="1002" height="17"/></div><!-- #EndLibraryItem --></body>
</html>
