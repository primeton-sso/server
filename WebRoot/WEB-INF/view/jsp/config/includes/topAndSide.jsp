<%@ page language="java" contentType="text/html; charset=utf-8"
 %>
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
<script type="text/javascript">
<!--
function loadfn(){
	var retStr = "${retStr}";
	
	if((retStr != null) && (retStr != "") && (retStr != "null")){
		alert(retStr);
		return;
	}
}
-->
</script>
</head>
<body onload="loadfn();">
<div class="container">
	<div class="header"> 
    	<!-- end .header -->
	</div>
	<hr/>
	<div class="outter">
	 <div class="sidebar1">
   		<ul class="nav">
      	<li><a href="<%= basePath%>config/basic">基础设置配置</a></li>
      	<li><a href="<%= basePath%>config/authenticate">认证模式配置</a></li>
      	<li><a href="<%= basePath%>config/dataSource">数据源配置</a></li>
      	<li><a href="<%= basePath%>config/logout">登出</a></li>
    	</ul>
    </div>
    <div class="content">
	