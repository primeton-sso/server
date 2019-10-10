/*******************************************************************************
 * $Header: /cvsroot/PTP50/workdir/components/sso/com.primeton.components.sso.server/src/main/java/com/primeton/sso/passwordEncoder/MD5PasswordEncoder.java,v 1.1 2013/10/12 06:49:51 wuyh Exp $
 * $Revision: 1.1 $
 * $Date: 2013/10/12 06:49:51 $
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2009-11-16
 *******************************************************************************/


package com.primeton.sso.passwordEncoder;

import org.jasig.cas.authentication.handler.PasswordEncoder;

public class MD5PasswordEncoder implements PasswordEncoder{

	public String encode(String password) {
        if (password == null) {
            return null;
        }
		return CryptoUtil.digestByMD5(password);
	}

}
