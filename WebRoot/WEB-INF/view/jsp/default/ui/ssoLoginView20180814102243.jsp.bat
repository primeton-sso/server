<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.eos.system.utility.StringUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="net.psctech.components.db.ImgUtil"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>统一身份认证-山西晋中师范高等专科学校</title>

<!-- Bootstrap -->
<link href="<%=request.getContextPath() %>/css/bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/index.css" rel="stylesheet" type="text/css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="<%=request.getContextPath() %>/js/html5shiv.min.js"></script>
      <script src="<%=request.getContextPath() %>/js/respond.min.js"></script>
    <![endif]-->
</head>

<script language="javascript">
var imgArray = new Array();
 function keyLogin(){
  if (event.keyCode==13)  //回车键的键值为13
   $('#frm').submit(); //调用登录按钮的登录事件
}
<%
 ImgUtil iu = new ImgUtil();
 List<String> imgList = iu.getImgList();
 for(String s : imgList) {
%>
imgArray.push("<%=s%>");
<%} %>
</script>
<body onKeydown="keyLogin();">
<form method="post" id="frm" action="<%=request.getContextPath()+"/"+response.encodeRedirectURL("login" + (StringUtils.hasText(request.getQueryString()) ? "?" + StringUtil.htmlFilter(request.getQueryString()) : ""))%>">
<input type="hidden" name="lt" value="${flowExecutionKey}" />
<input type="hidden" name="_eventId" value="submit" />
<div>
  <div class="col-xs-7 login_left"><img id="test" style=" transition: 1s 1s  ease;" src="<%=request.getContextPath() %>/images/bg2.png"></div>
  <div class="col-xs-5 login_right">
    
    <ul class="main_put">
	<div>
				<li><img src="images/login_logo.png" style=" width:260px;"></li>
				</div>
                 <li><h4>欢迎登陆统一身份认证</h4></li>
                 <li>
                 <div style= "height:40px; width:100%; overflow:hidden;"> 
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
                 </li>
                 <li>
                   <p>用户名</p>
                   <input type="text" class="put_style" placeholder="用户名" id="username" name="username" tabindex="1" accesskey="${userNameAccessKey}" value="${param.username}"/>
                 </li>
                 <li>
                   <p>密码</p>
                   <input type="password" class="put_style" placeholder="密码" id="password" name="password" tabindex="2" accesskey="${passwordAccessKey}"/>
                 </li>
                 
                 <li>
                   <a href="javascript:$('#frm').submit()" class="bao_button">登录</a>
                 </li>
      </ul>
      <div style="text-align: center;color: #999;padding-top: 20px;">提醒：默认用户名为职工号或者学号，初始密码为身份证号后6位，请及时修改密码</div>
  </div>
</div>
</form>
<script src="<%=request.getContextPath() %>/js/jquery-1.11.2.min.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<script src="<%=request.getContextPath() %>/js/html5shiv.js"></script>
<script src="<%=request.getContextPath() %>/js/respond.min.js"></script>
<script type="text/javascript">
    
  autodivheight();
  function autodivheight(){ //函数：获取尺寸
      //获取浏览器窗口高度
      var winHeight=0;
      if (window.innerHeight){
          winHeight = window.innerHeight;
      }
      else if ((document.body) && (document.body.clientHeight)){
          winHeight = document.body.clientHeight;
      }
      //通过深入Document内部对body进行检测，获取浏览器窗口高度
      if (document.documentElement && document.documentElement.clientHeight){
          winHeight = document.documentElement.clientHeight;
      }
      //DIV高度为浏览器窗口的高度
      //document.getElementById("ivu-layout").style.height= winHeight +"px";
      //DIV高度为浏览器窗口高度的一半
      document.getElementById("test").style.height= winHeight +"px";
  }
  window.onresize=autodivheight; //浏览器窗口发生变化时同时变化DIV高度
	var i=0;
    var imgnum = imgArray.length;
    var name = setInterval(
        function() {
           if(i>=imgnum) i=0;
           document.getElementById("test").src=imgArray[i];
           i+=1;
        }   ,
        //每秒执行一次
       3000
    );
</script>
</body>
</html>
