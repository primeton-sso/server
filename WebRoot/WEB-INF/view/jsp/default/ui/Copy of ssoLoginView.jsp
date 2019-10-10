<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.eos.system.utility.StringUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>统一身份认证-山西晋中师范高等专科学校</title>
        <link rel="stylesheet" href="<%=request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath() %>/assets/font-awesome/css/font-awesome.min.css">
		  <link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/form-elements.css">
        <link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/style.css">
    </head>
    <body>
<form method="post" action="<%=request.getContextPath()+"/"+response.encodeRedirectURL("login" + (StringUtils.hasText(request.getQueryString()) ? "?" + StringUtil.htmlFilter(request.getQueryString()) : ""))%>">
<input type="hidden" name="lt" value="${flowExecutionKey}" />
<input type="hidden" name="_eventId" value="submit" />
        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>晋中师专</strong> 统一身份认证</h1>
                            <div class="description">
                            	<p>
	                            	欢迎使用山西晋中师范高等专科学校统一身份认证系统
                            	</p>
        <div style= "height:60px; width:100%; overflow:hidden; "> 
	        <spring:hasBindErrors name="credentials">
	              <c:forEach var="error" items="${errors.allErrors}" varStatus="status">
	              <br/> 
	              	<span id="${status.count}">
	                 <font color='red'>
	                      <spring:message code="${error.code}" text="${error.defaultMessage}"/>
	                 </font>
	                 </span>
	               </c:forEach>
	                      </spring:hasBindErrors>
		  </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>统一身份认证</h3>
                            		<p>请输入您的用户名和密码进行认证:</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-key"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">用户名</label>
			                    		<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
		   								<input type="text" id="username" name="username" tabindex="1" accesskey="${userNameAccessKey}"  autocomplete="false" htmlEscape="true" placeholder="用户名..." class="form-username form-control"/>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">密　码</label>
			                        	<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
		    							<input type="password" id="password" name="password" tabindex="2" accesskey="${passwordAccessKey}" htmlEscape="true" placeholder="密码..." class="form-password form-control"/>
			                        </div>
			                        <button type="submit" class="btn" style="width:100%">登录</button>
		                    </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 social-login">
                        	<h5>Copyright&nbsp;@&nbsp;2018&nbsp;山西晋中师范高等专科学校</h5>
                    </div>
                </div>
            </div>
        </div>
</form>
        <script src="<%=request.getContextPath() %>/assets/js/jquery-1.11.1.min.js"></script>
        <script src="<%=request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath() %>/assets/js/jquery.backstretch.min.js"></script>
        <script src="<%=request.getContextPath() %>/assets/js/scripts.js"></script>
    </body>
</html>