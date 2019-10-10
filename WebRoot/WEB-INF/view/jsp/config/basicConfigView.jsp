<%@ page pageEncoding="UTF-8" %>
<jsp:directive.include file="includes/topAndSide.jsp" />
<style>
input { 
width:150px; height:15px;
} 
select { 
width:156px; height:22px;margin-top:3px;
}
td{
margin-top:5px;
}

</style>
<script type="text/javascript">
	function checkAdminPWD(){
		var str = document.getElementById("adminPwd").value;
		var regu = "^[0-9a-zA-Z]+$";
		var re = new RegExp(regu);
		if (str.length==0)
			{ 
				document.getElementById("txtAdminPWD").innerHTML="管理员密码不能为空";
			 	return;
			}
		if(!re.test(str)){
			document.getElementById("txtAdminPWD").innerHTML="管理员密码只能包含英文和数字";
			 	return;
		}
		if (str.length<6 || str.length>50)
			{ 
				document.getElementById("txtAdminPWD").innerHTML="密码长度应在6-50之间";
				return;
			}
		document.getElementById("txtAdminPWD").innerHTML="";
	}

	function checkAdminConfirmPWD(){
		var str = document.getElementById("confirmPwd").value;
		if (str != document.getElementById("adminPwd").value)
			{ 
			document.getElementById("txtAdminConfirmPWD").innerHTML="确认密码不一致";
			 	return;
			}else{
				document.getElementById("txtAdminConfirmPWD").innerHTML="";
			}
	}
	
	function changePWD(){
		if(document.getElementById("cbxChangePWD").checked == true){
			var control =document.getElementById("adminPwd");
			control.disabled=false;
			control.focus();
			control.value = control.value;
			document.getElementById("confirmPwd").disabled=false;
			checkAdminPWD();
			checkAdminConfirmPWD(document.getElementById("confirmPwd").value);	
		}else{
			document.getElementById("adminPwd").value="";
			document.getElementById("adminPwd").disabled=true;
			document.getElementById("confirmPwd").value="";
			document.getElementById("confirmPwd").disabled=true;
			document.getElementById("txtAdminPWD").innerHTML="";
			document.getElementById("txtAdminConfirmPWD").innerHTML="";
		}
	}

	function checkTcgTime(){
		var str = document.getElementById("tcgValidTime").value;
		var regu = "^[0-9]+$";
		var re = new RegExp(regu);
		if (str.length==0)
 		{ 
  		document.getElementById("txtTcg").innerHTML="失效时间不能为空";
 		 return;
  		}
		if(!re.test(str)){
			document.getElementById("txtTcg").innerHTML="请输入大于等于1的正整数";
			return;
		}
		if(str<1){
			document.getElementById("txtTcg").innerHTML="TGC失效时间应不小于1";
			return;
		}
		document.getElementById("txtTcg").innerHTML="";
	}
	
	function checkTicketTime(str){
		var regu = "^[0-9]+$";
		var re = new RegExp(regu);
		if (str.length==0)
 		{ 
  		document.getElementById("txtTicket").innerHTML="失效时间不能为空";
 		 return;
  		}
		if(!re.test(str)){
			document.getElementById("txtTicket").innerHTML="请输入大于等于1的正整数";
			return;
		}
		if(str<1){
			document.getElementById("txtTicket").innerHTML="Ticket失效时间应大于0";
			return;
		}
		document.getElementById("txtTicket").innerHTML="";
	}
	
	function checkSessionTime(str){
		var regu = "^[0-9]+$";
		var re = new RegExp(regu);
		if (str.length==0)
 		{ 
  			document.getElementById("txtSessionTime").innerHTML="session失效时间不能为空";
 		 	return;
  		}
		if(!re.test(str)){
			document.getElementById("txtSessionTime").innerHTML="请输入大于等于1的正整数";
			return;
		}
		if(str<1){
			document.getElementById("txtSessionTime").innerHTML="session失效时间应大于0";
			return;
		}
		document.getElementById("txtSessionTime").innerHTML="";
	}
	
	
	
	function check_form(form){
		if(document.getElementById("cbxChangePWD").checked == true){
			checkAdminPWD();
			checkAdminConfirmPWD();
		}
		checkTcgTime();
		var errMsgPre = "请确保输入正确:";
		var errMsg = "";
		if((errMsg = document.getElementById("txtAdminPWD").innerHTML) !=""){
			/* alert(errMsgPre + errMsg); */
			return false;
		}
		if((errMsg = document.getElementById("txtTicket").innerHTML) !=""){
			/* alert(errMsgPre + errMsg); */
			return false;
		}
		if((errMsg = document.getElementById("txtAdminConfirmPWD").innerHTML) !=""){
			/* alert(errMsgPre + errMsg); */
			return false;
		}
		if((errMsg = document.getElementById("txtSessionTime").innerHTML) !=""){
			/* alert(errMsgPre + errMsg); */
			return false;
		}
		if((errMsg = document.getElementById("txtTcg").innerHTML) !=""){
			/* alert(errMsgPre + errMsg); */
			return false;
		}
		return true;
	}
	
	
</script>
<div id="formwrapper">
	<form:form id="basicSettingForm" method="POST" commandName="basicSetting" onsubmit="return check_form(this);">
	<fieldset>
		<legend>失效时间设置</legend>
		<div>
			<label>TGC失效时间</label>
			<form:input path="tcgValidTime" onchange="checkTcgTime();" />分钟<span id="txtTcg"></span><br />
		</div>
		<div>
			<label>Ticket失效时间</label>
			<form:input path="ticketValidTime" onchange="checkTicketTime(this.value);" />分钟<span id="txtTicket"></span><br />
		</div>
		<div>
			<label>Session失效时间</label>
			<form:input  path="sessionValidTime" onchange="checkSessionTime(this.value);"/>分钟<span id="txtSessionTime"></span><br />
		</div>	
	</fieldset>
	<fieldset>
		<legend>管理员密码设置</legend>
		<div>
			<form:checkbox id="cbxChangePWD" path="changePwd" onclick="changePWD();"/>设置新管理员密码<span id="txtTcg"></span><br />
		</div>
		<div>
			<label>管理员密码</label>
			<form:password id="adminPwd" path="adminPassword" disabled="true" onchange="checkAdminPWD();"/><span id="txtAdminPWD"></span><br />
		</div>
		<div>
			<label>确认管理员密码</label>
			<input id="confirmPwd" name="confirmPwd" type="password" disabled="true" onchange="checkAdminConfirmPWD();"/><span id="txtAdminConfirmPWD"></span><br />
		</div>	
	</fieldset>
	
	<fieldset>
		<legend>定制配置</legend>
		<div>
			<label>加密算法</label>
			<form:select  path="encoderID" items="${encoders}" itemValue="id" itemLabel="name"/><br />
		</div>
		<%-- <div>
			<label>登入登出套件</label>
			<form:select  path="uiSuite" items="${uiSuites}" itemValue="id" itemLabel="name"/><br />
		</div>	 --%>
	</fieldset>
	<div style="padding-left:250px; padding-top:10px; "><input class="middle" type="submit" value="应用" style="width:50px;"/></div>
	
	</form:form>
	<script type="text/javascript">
		document.getElementById("adminPwd").value = "";
		document.getElementById("cbxChangePWD").checked = false;
	</script>
</div>
<jsp:directive.include file="includes/bottom.jsp" />