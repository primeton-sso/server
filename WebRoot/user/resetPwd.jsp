<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>修改密码-山西晋中师范高等专科学校</title>
<link href="file/style_log.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="file/style.css"/>
<link rel="stylesheet" type="text/css" href="file/userpanel.css"/>
<link rel="stylesheet" type="text/css" href="file/jquery.ui.all.css"/>
<script src="../js/jquery-1.11.2.min.js"></script>
<script src="../js/layer/layer.js"></script>
</head>
<body class="login">
<form action="/sso-server/resetPwd" method="post" id="frm">
	<div class="login_m">
		<div class="login_logo">
			<img src="../images/login_logo.png" />
		</div>
		<div class="login_boder" style="height:500px;">
			<div class="login_padding" id="login_model">
				<h2>用户名</h2>
				<label><input type="text" name="userId" id="userId" readonly="readonly" class="txt_input txt_input2" value="<%=request.getParameter("userId")%>"/> </label>
				<h2>旧密码</h2>
				<label><input type="password" name="oldPasswd" id="oldPasswd" class="txt_input" value=""/></label>
				<h2>新密码</h2>
				<label><input type="password" name="newPasswd" id="newPasswd" class="txt_input" value=""/></label>
				<h2>再次输入新密码</h2>
				<label><input type="password" id="newPasswd2" class="txt_input" value=""/></label>
                <h2>邮箱地址（可用于密码找回）</h2>
				<label><input type="text" name="email" class="txt_input" value=""/></label>

				<div class="rem_sub">
					<label> <input type="button" class="sub_button"	onclick="modify()" value="修改密码" />
					</label>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
function modify() {
	if($("#userId").val()=="") {
		layer.tips('用户名不能为空!', '#userId');
		return;
	}
	if($("#oldPasswd").val()=="") {
		layer.tips('旧密码不能为空!', '#oldPasswd');
		return;
	}
	if($("#newPasswd").val()=="") {
		layer.tips('新密码不能为空!', '#newPasswd');
		return;
	}
	if($("#newPasswd").val()!=$("#newPasswd2").val()) {
		layer.tips('两次新密码输入不一致!', '#newPasswd2');
		return;
	}
	layer.confirm('您确定要修改密码？', {
		  btn: ['是','否'] //按钮
		}, function(){
			document.getElementById("frm").submit();
		}, function(){});
}
</script>
</body>
</html>