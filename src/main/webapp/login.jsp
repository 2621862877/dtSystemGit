<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=5"/>
<title>登录页面</title>
<link href="${pageContext.request.contextPath}/css/css.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
  <script type="text/javascript">
      $(function () {
          $("#form001").submit(function () {
             if ($("#uname").val() == "" || $("#upass").val() == ""){
                 alert("请填写登录信息！");
                 return false;
             }
             if ($("option:selected").val() == "请选择角色"){
                 alert("请选择角色信息！");
                 return false;
             }
          });
      });
  </script>
</head>

<body>
<div id="logo"><img src="${pageContext.request.contextPath}/images/logo.jpg" alt="大唐电信首页" width="1002" height="392" /></div>
<div class="login" id="middle">
  <p style="color: red">${msg}</p>

  <form action="${pageContext.request.contextPath}/login" method="post" name="form001" id="form001">
    <p>
      <label>
      用户名：<input value="zhaoliu" id="uname" name="employeeName" type="text" />
    </label></p>
    <p>  密 码：     
      <label>
    <input type="password" value="123" id="upass" name="password" />
    </label></p>
    <p>角 色：
      <label>
      <select name="roleId">
        <option selected="selected">请选择角色</option>
        <option value="2">系统管理员</option>
        <option value="3">主管</option>
        <option value="4">员工</option>
      </select>
      </label>
    </p>
    <p>
      <label class="left007-bg">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <input name="Submit" type="submit" class="menu1" value="登录" />
      </label>
    </p>
  </form>
</div>
<div id="nutton"><img src="${pageContext.request.contextPath}/images/button.jpg" width="1002" height="17" /></div>
</body>
</html>
