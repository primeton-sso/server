package com.primeton.sso.authentication;

import java.util.HashMap;

public class SampleUserCache  implements IUserCache{

	private static HashMap users = new HashMap(5000);

	public  String getPassword(String username) {
		return (String) users.get(username);
	}

	public  void setUser(String username, String password) {
		users.put(username, password);
	}

	public void removeUser(String username) {
		users.remove(username);
		
	}
	
	





}
