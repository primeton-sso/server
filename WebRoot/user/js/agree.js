   $(function(){
   	//输入框输入时模拟placeholder效果
   	var oInput = $(".form-data input");
   	oInput.focus(function () {
		$(this).siblings("label").hide();
    });
   	oInput.blur(function () {
		if($(this).val()==""){
			$(this).siblings("label").show();
		}
	});
   });
   
   
function go() {
	var userId = document.getElementById("userId").value;
	var email = document.getElementById("email").value;
	if(userId=="" || userId=="请输入用户名") {
		alert("请输入用户名！");
		return false;
	}
	if(email=="" || email=="") {
		alert("请输入邮箱！");
		return false;
	}
	if(window.confirm("您确定要找回密码吗？")) {
		document.getElementById("button").disabled = true;
		document.getElementById("loaddiv").style.display = "block";
		return true;
	}else {
		return false;
	}
}
   
function checkEmail(myemail) {
	　　var myReg=/^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
	　　if(myReg.test(myemail)){
	　　　　return true;
	　　}else{
	　　　　return false;
	}
}