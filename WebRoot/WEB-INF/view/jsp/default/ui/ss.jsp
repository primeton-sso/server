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
	 <title>SSO &#8211;Single Sign On</title>
</head>
	
<style type="text/css" media="screen">@import 'css/sso.css'/**/;</style>


<script language=javascript>

<% 
	String localeNow = StringUtil.htmlFilter(request.getParameter("locale"));
	
	if("".equals(localeNow) || localeNow == null){
		String localeCookie = null;
		Cookie[] cs = request.getCookies();
		if(cs != null){
			int length = cs.length;
			for(int i=0;i<length; i++){
				if("org.springframework.web.servlet.i18n.CookieLocaleResolver.LOCALE".equals(cs[i].getName())){
					localeCookie = cs[i].getValue();
				}
			}
			localeNow = localeCookie;
		}else{
			localeNow = "select";
		}
	}

 %>			
function changeLanguage(){
		var str =  "login?locale="+ document.getElementById("language").value;
		location.href = str;
				}
			
function loadfn(){
	var s = document.getElementById("language");
   	var ops = s.options;
  	var requestLocale = "<%=localeNow%>";
   	for(var i=0;i<ops.length; i++){
    var tempValue = ops[i].value;
    if(tempValue == requestLocale )
    {
     ops[i].selected = true;
    }
   } 

}
</script>
  
<body class="bg_login" marginheight="0" marginwidth="0" onload="loadfn()">

<div class="fg_login">
 
<form method="post" action="<%=request.getContextPath()+"/"+response.encodeRedirectURL("login" + (StringUtils.hasText(request.getQueryString()) ? "?" + StringUtil.htmlFilter(request.getQueryString()) : ""))%>">

	
<table class="tb">
    <tr>
	   <td colspan=2>
		  <div style= "height:50px; width:100%; overflow:hidden; "> 
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
	    </td>
    </tr>
    
    <tr>
		<td width="50" ><label for="language"><spring:message code="screen.welcome.label.language" /></label>
		</td>
		<td width="230">
			<select id="language" style="width:185px" onchange="changeLanguage();" filter="false" >
			    <option value="select">select one</option>
		        <option value="zh_CN">中文 (中国)</option>
				<option value="en">English (United States)</option>
			</select>
		</td>
	</tr>

	<tr>
		<td width="50" ><label for="username"><spring:message code="screen.welcome.label.netid" /></label>
		</td>
		<td width="230">
		   <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
		   <input id="username" name="username" class="txt_input" size="25" tabindex="1" accesskey="${userNameAccessKey}"  autocomplete="false" htmlEscape="true" />
		</td>
	</tr>
	<tr>
		<td width="50" ><label for="password"><spring:message code="screen.welcome.label.password" /></label>
		</td>
		<td width="230">
			<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
		    <input type="password" id="password" name="password" class="txt_input" size="25" tabindex="2" accesskey="${passwordAccessKey}" htmlEscape="true" />
		</td>
	</tr>
	
	<tr><td><div style= "height:6px; width:100%; overflow:hidden; "></div></td></tr>
		 
	<tr>		
		<td style="padding-right:50px;text-align:right;vertical-align:middle;" colspan=2>	
		     <input type="hidden" name="lt" value="${flowExecutionKey}" />
	         <input type="hidden" name="_eventId" value="submit" />
	    
		     <input class="btn" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="3" type="submit" />
             <input class="btn" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="4" type="reset" />
		</td>		
	</tr>
</table>
</form>
</div>
</body>
</html>
