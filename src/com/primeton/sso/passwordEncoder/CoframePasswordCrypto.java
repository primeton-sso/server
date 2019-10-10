/*******************************************************************************
 * $Header: /cvsroot/PTP50/workdir/components/sso/com.primeton.components.sso.server/src/main/java/com/primeton/sso/passwordEncoder/CoframePasswordCrypto.java,v 1.1 2013/10/12 06:49:51 wuyh Exp $
 * $Revision: 1.1 $
 * $Date: 2013/10/12 06:49:51 $
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2012 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2013-3-26
 *******************************************************************************/


package com.primeton.sso.passwordEncoder;

import com.eos.system.utility.CryptoUtil;
import org.jasig.cas.authentication.handler.PasswordEncoder;

/**
 * TODO 此处填写 class 信息
 *
 * @author wangwb (mailto:wangwb@primeton.com)
 */

public class CoframePasswordCrypto implements PasswordEncoder {

	private final static String ENCRYPT_KEY = "cap_user"; /* 同 org.gocom.cap.auth.base.user.impl.DefaultUserManager.ENCRYPT_KEY */
	
	public String encode(String password) {
		if (password == null) {
            return null;
        }
		try {
			return CryptoUtil.encrypt(password, ENCRYPT_KEY);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static void main(String[] args) {
		System.out.println(new CoframePasswordCrypto().encode("wangwb"));
		System.out.println("3r1BWjR88A4=");
	}
}

/*
 * 修改历史
 * $Log: CoframePasswordCrypto.java,v $
 * Revision 1.1  2013/10/12 06:49:51  wuyh
 * update:maven项目转换
 *
 * Revision 1.1  2013/08/23 10:32:29  wuyh
 * update:����Ǩ�� PTP5.0
 *
 * Revision 1.1  2013/08/22 12:05:19  wuyh
 * update:����Ǩ�� PTP5.0
 *
 * Revision 1.1  2013/08/22 07:30:34  wuyh
 * update:����Ǩ�� PTP5.0
 *
 * Revision 1.1  2013/03/25 21:46:30  libu
 * add: 增加cof
 *
 * Revision 1.1  2013/03/25 18:09:59  wangwb
 * Add:增加
 * 
 */