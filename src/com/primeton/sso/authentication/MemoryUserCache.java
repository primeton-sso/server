package com.primeton.sso.authentication;

import java.util.HashMap;

public class MemoryUserCache  implements IUserCache{

	private static HashMap users = new HashMap(5000);

	public  String getPassword(String username) {
		username=username.replaceAll(" ", "______");
		return (String)users.get(username);
	}

	public  void setUser(String username, String password) {
		username=username.replaceAll(" ", "______");
		users.put(username, password);
	}

	public void removeUser(String username) {
		username=username.replaceAll(" ", "______");
		users.remove(username);
		
	}
	
	





}
