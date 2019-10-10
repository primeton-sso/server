<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page session="true" %>
<%@	taglib	prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>SSO Config Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css" media="screen">@import '<%= basePath%>css/cm.css'/**/;</style>
<style>
input { 
width:150px;
} 
</style>
<script type="text/javascript">
function loadfn(){
	var retStr = "${retStr}";
	if(retStr != null && retStr.length != ""){
		alert(retStr);
	}
}

function checkUserName(){
	var str = document.getElementById("username").value;
	if (str.length==0)
		{ 
			document.getElementById("txtUserName").innerHTML="用户名不能为空";
		 	return;
		}
	document.getElementById("txtUserName").innerHTML="";
	return;
}

function checkPassword(form){
	var password = form.password.value;
	var adminName = form.username.value;
	if(adminName.length == 0){
		document.getElementById("txtUserName").innerHTML="用户名不能为空";
		document.getElementById("txtPassword").innerHTML="";
 		return false;
	}
	if(password.length == 0){
		document.getElementById("txtPassword").innerHTML="密码不能为空";
		document.getElementById("txtUserName").innerHTML="";
 		return false;
	}
	if (password.length<6 || password.length>50)
 	{ 
  		document.getElementById("txtPassword").innerHTML="密码长度应在6~50之间";
 		return false;
  	}
	document.getElementById("txtUserName").innerHTML="";
	document.getElementById("txtPassword").innerHTML="";
	return true;
}

</script>
</head>
<body onload="loadfn();">
<div class="container">
	<div class="header"> 
    	<!-- end .header -->
	</div>
	<hr/>
	<div class="cm_login">
	<form:form onsubmit="return checkPassword(this);" id="loginform" method="POST" commandName="configManager">
		<table class="tb">
		<tr>
			<td width="35%" >&nbsp;</td>
			<td width="65%">&nbsp;</td>
		</tr>
		<tr>
			<td align="right">用户名：</td>
			<td><form:input id="username" path="username" onchange="checkUserName();"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><span id="txtUserName">${errMsgAdmin}</span></td>
		</tr>
		<tr>
			<td align="right">密码：</td>
			<td><form:password id="password" path="password"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td ><span id="txtPassword">${errMsgPwd}</span></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right"><input style="left:115px;width:50px;height:30px;margin-right:50px" type="submit" value="登录"></td>
		</tr>
		</table>
	</form:form>
	</div>
</div>
</body>
</html>
