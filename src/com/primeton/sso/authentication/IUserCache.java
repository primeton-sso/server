package com.primeton.sso.authentication;

public interface IUserCache {
	public String getPassword(String username);

	public void setUser(String username, String password);
	
	public void removeUser(String username);
	
}
