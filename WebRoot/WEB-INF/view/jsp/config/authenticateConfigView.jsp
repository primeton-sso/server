<%@ page pageEncoding="UTF-8" %>
<jsp:directive.include file="includes/topAndSide.jsp" />
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

	function checkMemIP(){
		var str = document.getElementById("memIP").value;
		if (str.length==0)
 		{ 
  			document.getElementById("txtMemIP").innerHTML="Memcache IP不能为空";
 			 return;
  		}
		if(isIP(str)){
			var reg = /^0+\.0+\.0+\.0+$/;
			if(reg.test(str)){
				document.getElementById("txtMemIP").innerHTML = "请输入真实有效的IPv4地址";
				return;
			}
			var reg2 = /^0*1\.0*1\.0*1\.0*1$/;
			if(reg2.test(str)){
				document.getElementById("txtMemIP").innerHTML = "请输入真实有效的IPv4地址";
				return;
			}
			if(str == "127.0.0.0"){
				document.getElementById("txtMemIP").innerHTML = "请输入真实有效的IPv4地址";
				return;
			}
			document.getElementById("txtMemIP").innerHTML = "";
		}else{
			document.getElementById("txtMemIP").innerHTML = "请输入合法的IPv4地址"; 
		}
		return;
	}
	
	
	function checkMemPort(){
		var str = document.getElementById("memPort").value;
		if (str.length==0)
 		{ 
  			document.getElementById("txtMemPort").innerHTML="Memcache端口号不能为空";
 			 return;
  		} 
		if(isPort(str)){
			document.getElementById("txtMemPort").innerHTML = "" ;
		}else{
			document.getElementById("txtMemPort").innerHTML = "请输入0-65535之间的整数";
		}
		return;
	}
	
	function checkCluster(){
		if(document.getElementById("inCluster1").checked == true){
			var control =document.getElementById("memIP");
			control.disabled=false;
			control.focus();
			control.value = control.value;
			document.getElementById("memPort").disabled = false;
			checkMemIP();
			checkMemPort();
		}else{
			document.getElementById("memIP").value = "";
			document.getElementById("memPort").value = "";
			document.getElementById("memIP").disabled = true;
			document.getElementById("memPort").disabled = true;
			document.getElementById("txtMemPort").innerHTML = "" ;
			document.getElementById("txtMemIP").innerHTML = "";
		}
	}
	
	function checkCache(){
		if(document.getElementById("useCache2").checked == true){
			var control =document.getElementById("interval");
			control.disabled=false;
			control.focus();
			control.value = control.value;
			document.getElementById("inCluster1").disabled = false;
			checkInterval();
			checkCluster();
		}else{
			document.getElementById("txtInterval").innerHTML="";
			document.getElementById("interval").disabled = true;
			document.getElementById("inCluster1").checked = false;
			document.getElementById("inCluster1").disabled = true;
			checkCluster();
			/* document.getElementById("memIP").disabled = true;
			document.getElementById("memPort").disabled = true; */
		}
	}
	
	function checkSQLStr()
	{
		var str = document.getElementById("sqlStr").value;
		if (str.length==0)
 		{ 
  		document.getElementById("txtSQLStr").innerHTML="SQL查询语句不能为空";
 		 return;
  		}
		document.getElementById("txtSQLStr").innerHTML="";
	}
	
	function checkSQL(){
		if(document.getElementById("useSQLHandler1").checked == true){
			var control =document.getElementById("sqlStr");
			control.disabled=false;
			control.focus();
			control.value = control.value;
			checkSQLStr();
			document.getElementById("useCache1").disabled = false;
			document.getElementById("useCache2").disabled = false;
			checkCache();
			
		}else{
			document.getElementById("sqlStr").disabled = true;
			document.getElementById("useCache1").disabled = true;
			document.getElementById("useCache2").disabled = true;
			document.getElementById("interval").disabled = true;
			document.getElementById("inCluster1").checked = false;
			document.getElementById("inCluster1").disabled = true;
			document.getElementById("memIP").disabled = true;
			document.getElementById("memPort").disabled = true;
			
			document.getElementById("txtSQLStr").innerHTML="";
			document.getElementById("txtInterval").innerHTML="";
			document.getElementById("txtMemPort").innerHTML = "" ;
			document.getElementById("txtMemIP").innerHTML = "";
		}
	}
	
	function checkCustom(){
		document.getElementById("useCustomHandler1").disabled = true;
	}
	
	function checkInterval()
	{
		var str = document.getElementById("interval").value;
		if (str.length==0)
 		{ 
  		document.getElementById("txtInterval").innerHTML="同步周期不能为空";
 		 return;
  		}
		if(isNumber(str) == false){
			document.getElementById("txtInterval").innerHTML="同步周期必须为数字";
	 		 return;
		}
		if(str<60 || str>7200){
			document.getElementById("txtInterval").innerHTML="同步周期必须为60~7200ms之间";
	 		 return;
		}
		document.getElementById("txtInterval").innerHTML="";
	}
	
	function checkSpan(id){
		var msg = document.getElementById(id).innerHTML;
		if(msg != ""){
			/* alert("请确保输入正确："+msg); */
			return false;
		}
		return true;
		
	}
	
	function check_form(form){
		var msg = "";
		if(document.getElementById("useSQLHandler1").checked == true){
			checkSQLStr();
			if(!checkSpan("txtSQLStr")) return false;
			if(document.getElementById("useCache2").checked == true){
				checkInterval();
				if(!checkSpan("txtInterval")) return false;
				if(document.getElementById("inCluster1").checked == true){
					checkMemIP();
					checkMemPort();
					if(!checkSpan("txtMemIP")) return false;
					if(!checkSpan("txtMemPort")) return false;
				}
			}
		}else{
			if((document.getElementById("useCustomHandler1").checked == false) && (document.getElementById("useSimpleHandler1").checked == false)){
				alert("请至少选择一种认证方式");
				return false;
			}
		}
		return true;
	}
</script>
<div id="formwrapper">
	<form:form onsubmit="return check_form(this);" method="POST" commandName="authenticateConfig">
	<div>
	
	<form:checkbox id="useSQLHandler1" path="useSQLHandler" onclick="checkSQL();"/>SQL认证
	<form:checkbox path="useCustomHandler" onclick="checkCustom();" disabled="true"/>用户定制认证
	<form:checkbox path="useSimpleHandler" />简单认证
	
	<br/><br/>
	
	<form:hidden path="encoderID"/>
	<fieldset>
		<legend>SQL认证设置</legend>
		<div>
			<table style="margin:20px;">
				<tr height="50px">
				<td width="150px"><label>SQL查询语句</label></td>
				<td width="200px"><form:input path="sqlStr" onchange="checkSQLStr()"/></td>
				<td width="200px"><span id="txtSQLStr"></span><form:errors path="sqlStr" cssClass="error" /></td>
				</tr>
				<tr>
				<td><form:radiobutton path="useCache" value="false" onclick="checkCache();"/>无缓存模式</td>
				<td><form:radiobutton path="useCache" value="true" onclick="checkCache();"/>有缓存模式</td>
				</tr>
				<tr height="50px">
				<td><label>同步周期</label></td>
				<td><form:input path="interval" onchange="checkInterval();"/><span style="color:black;">毫秒</span><br/></td>
				<td><span id="txtInterval"></span></td>
				</tr>
				<tr height="50px">
				<td><form:checkbox path="inCluster" onclick="checkCluster();"/>集群</td>
				<td></td>
				</tr>
				<tr>
				<td><label>memcache ip</label></td>
				<td><form:input  path="memIP" onchange="checkMemIP();" /></td>
				<td><span id="txtMemIP"></span></td>
				</tr>
				<tr>
				<td><label>memcache port</label></td>
				<td><form:input  path="memPort" onchange="checkMemPort();" /></td>
				<td><span id="txtMemPort"></span></td>
				</tr>
			</table>
		</div>
	</fieldset>
	
	<c:forEach items="${customHandlers}" var="favorite">
		<fieldset>
		<legend>用户定制认证</legend>
			<form:checkbox path="customizedHandlers" value="${favorite.key}" disabled="true"/>${favorite.value}<br/>
		</fieldset>
	</c:forEach>		
	<div style="padding-left:250px; padding-top:10px; ">
		<input class="middle" type="submit" value="应用" style="width:50px;"/>
	</div>

	</div>
	</form:form>
	<script type="text/javascript">
		checkSQL();
		checkCustom();
	</script>
	</div>
<jsp:directive.include file="includes/bottom.jsp" />