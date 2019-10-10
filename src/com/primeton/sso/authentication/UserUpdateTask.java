package com.primeton.sso.authentication;

import java.util.TimerTask;

public class UserUpdateTask extends TimerTask {

	private UserCacheUtil userCacheUtil = null;

	public UserUpdateTask(UserCacheUtil userCacheUtil) {
		this.userCacheUtil = userCacheUtil;
	}

	public void run() {
		userCacheUtil.updateUserInfo();
	}



}
