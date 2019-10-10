<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.eos.system.utility.StringUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- Minimal Web pages, starting point for Web Designers -->

<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
	 <title>统一身份认证登录</title>
	 <link rel="stylesheet" href="css/reset.css" />
	 <link rel="stylesheet" href="css/common.css" />
	 <link rel="stylesheet" href="css/font-awesome.min.css" />
</head>
	


<script language=javascript>

function login (){
	debugger;
	$('#form1').submit();
}
</script>
  
<body class="bg_login" marginheight="0" marginwidth="0" >

<div class="fg_login">
 
<form method="post" id="form1" action="<%=request.getContextPath()+"/"+response.encodeRedirectURL("login" + (StringUtils.hasText(request.getQueryString()) ? "?" + StringUtil.htmlFilter(request.getQueryString()) : ""))%>">
<div class="wrap login_wrap">
			<div class="content">
				<div class="logo"></div>
				<div class="login_box">	
					
					<div class="login_form">
						<div class="login_title">
							登录
						</div>
						<form action="#" method="post">
							
							<div class="form_text_ipt">
								<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
		   <input id="username" name="username" class="txt_input" size="25" tabindex="1" accesskey="${userNameAccessKey}"  autocomplete="false" htmlEscape="true" />
							</div>
							<div class="ececk_warning"><span>手机号/邮箱不能为空</span></div>
							<div class="form_text_ipt">
								<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
		    <input type="password" id="password" name="password" class="txt_input" size="25" tabindex="2" accesskey="${passwordAccessKey}" htmlEscape="true" />
							</div>
							<div class="ececk_warning"><span>密码不能为空</span></div>
							<div class="form_check_ipt">
								<div class="left check_left">
									<label><input name="" type="checkbox"> 下次自动登录</label>
								</div>
								<div class="right check_right">
									<a href="#">忘记密码</a>
								</div>
							</div>
							<div class="form_btn">
								<input type="hidden" name="lt" value="${flowExecutionKey}" />
	         <input type="hidden" name="_eventId" value="submit" />
	    
		     <input class="btn cas_btn" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="3" type="submit" />
							</div>
							<div class="form_reg_btn">
								<span>还没有帐号？</span><a href="register.html">马上注册</a>
							</div>
						</form>
						<div class="other_login">
							<div class="left other_left">
								<span>其它登录方式</span>
							</div>
							<div class="right other_right">
								<a href="#"><i class="fa fa-qq fa-2x"></i></a>
								<a href="#"><i class="fa fa-weixin fa-2x"></i></a>
								<a href="#"><i class="fa fa-weibo fa-2x"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="js/jquery.min.js" ></script>
		<script type="text/javascript" src="js/common.js" ></script>
</form>
</div>
</body>
</html>
