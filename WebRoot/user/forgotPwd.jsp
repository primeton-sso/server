<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>找回密码-晋中师范高等专科学校</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="./css/base.css">
    <link rel="stylesheet" href="./css/iconfont.css">
    <link rel="stylesheet" href="./css/reg.css">
</head>
<body>
<form id="regeditForm" action="/sso-server/forgotPwd" method="post" onsubmit="return go()">
<div id="ajax-hook"></div>
<div class="wrap">
    <div class="wpn">
        <div class="form-data find_password">
            <h4>通过邮箱找回密码</h4>
            <p class="right_now"></p>
            <p class="p-input pos">
                <label for="pc_tel">请输入用户名</label>
                <input type="text" id="userId" name="userId">
            </p>
			<p class="p-input pos">
                <label for="pc_tel">请输入邮箱</label>
                <input type="email" id="email" name="email">
            </p>
            <button class="lang-btn next" id="button">找回密码</button>
            <p class="right">晋中师范高等专科学校 © 2018</p>
            <p><div id="loaddiv" style="display:none"><img src="file/indicator_flower.gif"/>邮件发送中，请稍后。</div></p>
        </div>
    </div>
</div>
</form>
<script src="./js/jquery.js"></script>
<script src="./js/agree.js"></script>
</body>
</html>