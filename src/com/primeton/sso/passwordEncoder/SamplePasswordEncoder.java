package com.primeton.sso.passwordEncoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.jasig.cas.authentication.handler.PasswordEncoder;

public class SamplePasswordEncoder implements PasswordEncoder {

	public static final String KEY_SHA = "SHA";
	
	/**  
     * SHA加密  
     *   
     * @param password  
     * @return  
     * @throws Exception  
     */ 
	public String encode(String password) {
		
		byte[] byte_password = password.getBytes();		
		try {
			MessageDigest sha = MessageDigest.getInstance(KEY_SHA);
			sha.update(byte_password);  
	        byte_password = sha.digest();
	        
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}        
        
        return byte_password.toString();  	
	}
}