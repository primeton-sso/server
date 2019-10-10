package com.primeton.sso.authentication.handler;

import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.springframework.util.StringUtils;

import com.primeton.sso.authentication.IUserCache;
import com.primeton.sso.authentication.UserCacheConfig;
import com.primeton.sso.authentication.UserCacheUtil;

public class CacheUsernamePasswordAuthenticationHandler extends
		AbstractUsernamePasswordAuthenticationHandler {

	private IUserCache userCache = null;

	private UserCacheConfig userCacheConfig = null;

	protected boolean authenticateUsernamePasswordInternal(
			UsernamePasswordCredentials credentials)
			throws AuthenticationException {
		// TODO Auto-generated method stub
		final String username = credentials.getUsername();
		final String password = credentials.getPassword();

		if (StringUtils.hasText(username) && StringUtils.hasText(password)) {
			String encodePassword = userCache.getPassword(username);
			if (encodePassword != null)
				if (getPasswordEncoder().encode(password)
						.equals(encodePassword))
					return true;
		}

		return false;
	}

	public void init() {
		UserCacheUtil uct = new UserCacheUtil();
		uct.setUserCacheConfig(this.getUserCacheConfig());
		uct.setUserCache(this.getUserCache());
		uct.loadUserInfo();
		uct.startUpdateTask();
	}

	public IUserCache getUserCache() {
		return userCache;
	}

	public void setUserCache(IUserCache userCache) {
		this.userCache = userCache;
	}

	public UserCacheConfig getUserCacheConfig() {
		return userCacheConfig;
	}

	public void setUserCacheConfig(UserCacheConfig userCacheConfig) {
		this.userCacheConfig = userCacheConfig;
	}

}
