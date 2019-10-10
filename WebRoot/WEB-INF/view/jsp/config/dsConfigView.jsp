<%@ page pageEncoding="UTF-8" %>
<jsp:directive.include file="includes/topAndSide.jsp" />
<style>
input { 
width:250px; height:15px;
} 
select { 
width:256px; height:22px;
}

</style>
<script type="text/javascript">
function isNull(str){
	if(str == "") return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}

function isNumber(str){
	var regu = "^[0-9]+$";
	var re = new RegExp(regu);
	return re.test(str);
}

function isPort(str){
	return (isNumber(str) && str <65536);
}

function isIP(str){
	if(isNull(str)) return false;
	var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/; 
	return re.test(str);
}

function testConnection()
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    alert(xmlhttp.responseText);
    }
  }
xmlhttp.open("GET","/ajax/demo_get.asp",true);
xmlhttp.send();
}

function checkDbName(){
	var str = document.getElementById("dbName").value;
	if (str.length==0)
		{ 
		document.getElementById("txtDbName").innerHTML="数据库名不能为空";
		 return;
		}
	document.getElementById("txtDbName").innerHTML="";
}
function checkUserName(){
	var str = document.getElementById("dbUserName").value;
	if (str.length==0)
		{ 
		document.getElementById("txtDbUserName").innerHTML="用户名不能为空";
		 return;
		}
	document.getElementById("txtDbUserName").innerHTML="";
}
function checkDbPwd(){
	var str = document.getElementById("dbPassword").value;
	if (str.length==0)
		{ 
		document.getElementById("txtDbPassword").innerHTML="用户密码不能为空";
		 return;
		}
	document.getElementById("txtDbPassword").innerHTML="";
}
function checkDbIp(){
	var str = document.getElementById("dbIP").value;
	if (str.length==0)
	{ 
	document.getElementById("txtDbIp").innerHTML="数据库IP不能为空";
	 return;
	}
	if(isIP(str)){
		document.getElementById("txtDbIp").innerHTML = "";
	}else{
		document.getElementById("txtDbIp").innerHTML = "非法输入"; 
	}	
}
function checkDbPort(){
	var str = document.getElementById("dbPort").value;
	if (str.length==0)
	{ 
	document.getElementById("txtDbPort").innerHTML="数据库端口不能为空";
	 return;
	}
	if(isPort(str)){
		document.getElementById("txtDbPort").innerHTML = "";
	}else{
		document.getElementById("txtDbPort").innerHTML = "非法的端口输入"; 
	}	
}

function checkDbUrl(){
	var str = document.getElementById("dbUrl").value;
	if (str.length==0)
	{ 
	document.getElementById("txtDbUrl").innerHTML="数据库url不能为空";
	 return;
	}
	document.getElementById("txtDbUrl").innerHTML = "";
	return;
}

function check_form(form){
	var ret = false;
	if(document.getElementById("txtDbName").innerHTML == "" && 
			document.getElementById("txtDbPassword").innerHTML == "" &&
			document.getElementById("txtDbIp").innerHTML == "" &&
			document.getElementById("txtDbUserName").innerHTML == "" &&
			document.getElementById("txtDbPort").innerHTML == ""
			){
		ret = true;
		return ret;
	}
	alert("请确保输入正确");
	return ret;
}

var usedDbType="";
var usedUrl="";

function checkDBType(){
	var dbType = document.getElementById("dbType").value;
	if(dbType == "oracle"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{
			document.getElementById("dbUrl").value = "jdbc:oracle:thin:@127.0.0.1:1521:dbname";
		}
	}else if(dbType == "informix"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{
			document.getElementById("dbUrl").value = "jdbc:informix-sqli://127.0.0.1:1528/dbname:informixserver=servername";
		}
	}else if(dbType == "mysql"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{
		document.getElementById("dbUrl").value = "jdbc:mysql://127.0.0.1:3306/dbname";
		}
	}else if(dbType == "db2"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{
			document.getElementById("dbUrl").value = "jdbc:db2://127.0.0.1:50000/dbname";
		}
	}else if(dbType == "sybase"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{	
			document.getElementById("dbUrl").value = "jdbc:sybase:Tds:127.0.0.1:5000/dbname?CHARSET=utf8";
		}	
	}else if(dbType == "sqlserver"){
		if(dbType == usedDbType){
			document.getElementById("dbUrl").value = usedUrl;
		}else{
			document.getElementById("dbUrl").value = "jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=dbname;SelectMethod=Cursor";
		}
	}
}


</script>
<div id="formwrapper">
	<form:form method="POST" commandName="dsConfig" onsubmit="return check_form(this);">
	<fieldset>
	<legend>数据源配置</legend>
	<table style="margin-left:20px;margin-top:20px;" cellspacing="5px" cellpadding="5px">
	<tr>
		<td width="35%">数据源类型</td>
		<td width="35%"><form:select path="dsType" items="${dsTypes}"/></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr>
	<td>数据库类型</td>
	<td><form:select path="dbType" items="${dbTypes}" onchange="checkDBType();"/></td>
	</tr>
	<%-- <tr>
	<td id="tdDbType">数据库名</td>
	<td><form:input path="dbName" onchange="checkDbName();"/></td>
	<td><span id="txtDbName"></span></td>
	</tr> --%>
	<tr>
	<td>数据库用户名</td>
	<td><form:input  path="dbUserName" onchange="checkUserName();" /></td>
	<td><span id="txtDbUserName"></span></td>
	</tr>
	<tr>
	<td>数据库用户密码</td>
	<td><form:password  path="dbPassword" onchange="checkDbPwd();"/></td>
	<td><span id="txtDbPassword"></span></td>
	</tr>
	<%-- <tr>
	<td>数据库IP</td>
	<td><form:input  path="dbIP" onchange="checkDbIp();"/></td>
	<td><span id="txtDbIp"></span></td>
	</tr> --%>
	<!-- items="${uiSuites}" itemValue="id" itemLabel="name" -->
	<%-- <tr>
	<td>数据库端口</td>
	<td><form:input  path="dbPort" onchange="checkDbPort();"/></td>
	<td><span id="txtDbPort"></span></td>
	</tr> --%>
	<tr>
	<td>数据库url</td>
	<td><form:input  path="dbUrl" onchange="checkDbUrl();"/></td>
	<td><span id="txtDbUrl"></span></td>
	</tr> 
	<tr>
	<td><input name="test" type="submit" value="测试连接" style="width:100px;height:25px"/> </td>
	<td><input name="apply" type="submit" value="应用" style="width:50px;height:25px"/> </td>
	</tr>
	</table>
	</fieldset>
	</form:form>
		
	</div>
	<script type="text/javascript">
		document.getElementById("dbPassword").value = "${dsConfig.dbPassword}";
		usedDbType = document.getElementById("dbType").value;
		usedUrl = document.getElementById("dbUrl").value;
		//checkDBType();
	</script>
<jsp:directive.include file="includes/bottom.jsp" />

