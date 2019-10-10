package com.primeton.sso.authentication;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.List;

import net.spy.memcached.MemcachedClient;

public class MemCacheUserCache implements IUserCache {

	private final MemcachedClient client;

	public MemCacheUserCache(String[] hostnames) {
		final List addresses = new ArrayList();

		for(int i=0;i<hostnames.length;i++){
			String[] hostPort = hostnames[i].split(":");
			addresses.add(new InetSocketAddress(hostPort[0], Integer
					.parseInt(hostPort[1])));
		}
//		for (final String hostname : hostnames) {
//			String[] hostPort = hostname.split(":");
//			addresses.add(new InetSocketAddress(hostPort[0], Integer
//					.parseInt(hostPort[1])));
//		}

		try {
			this.client = new MemcachedClient(addresses);
		} catch (final IOException e) {
			throw new IllegalStateException(e);
		}

	}

	public String getPassword(String username) {
		// TODO Auto-generated method stub
		username=username.replaceAll(" ", "______");
		Object value = client.get(username);
		if (value != null)
			return (String) value;
		return null;
	}

	
	public void removeUser(String username) {
		// TODO Auto-generated method stub
		username=username.replaceAll(" ", "______");
		client.delete(username);

	}

	public void setUser(String username, String password) {
		try{
			username=username.replaceAll(" ", "______");
		client.set(username, 0, password);
		}catch (Throwable e)
		{

			e.printStackTrace();
			System.out.println("[error][key:"+username+"][value:"+password+"]");
		}
		// TODO Auto-generated method stub

	}

}
