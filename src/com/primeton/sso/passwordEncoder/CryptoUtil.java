/*******************************************************************************
 * $Header: /cvsroot/PTP50/workdir/components/sso/com.primeton.components.sso.server/src/main/java/com/primeton/sso/passwordEncoder/CryptoUtil.java,v 1.1 2013/10/12 06:49:51 wuyh Exp $
 * $Revision: 1.1 $
 * $Date: 2013/10/12 06:49:51 $
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2008-7-24
 *******************************************************************************/

package com.primeton.sso.passwordEncoder;

import java.security.NoSuchAlgorithmException;

import org.apache.commons.lang.StringUtils;

import com.eos.system.exception.EOSRuntimeException;
import com.primeton.ext.infra.security.BASE64Decoder;
import com.primeton.ext.infra.security.BASE64Encoder;

public class CryptoUtil {

	public static final byte[] DEFAULT_DES_KEY = new byte[] { -99, 118, 97,
			-105, -51, -17, 81, 14 };

	public static final String DES_DECRYPT = "24000011";

	public static final String DES_ENCRYPT = "24000012";

	public static final String MD5 = "24000013";

	public static final String SHA = "24000014";

	/**
	 * base64 encoding.<br>
	 * 
	 * @param bytes
	 *            byte array.
	 * @return encoded string.
	 */
	public static String base64Encode(byte[] bytes) {
		if (bytes == null)
			return "";
		return new BASE64Encoder().encode(bytes);
	}

	/**
	 * base64 decoding.<br>
	 * 
	 * @param text
	 *            encoded string.
	 * @return base64 byte array.
	 */
	public static byte[] base64Decode(String text) {
		if (text == null)
			return new byte[0];
		return new BASE64Decoder().decodeBuffer(text);
	}

	/**
	 * DES decryption.<br>
	 * Base64 decoding first, and then decrypt DES..
	 * 
	 * @param cryptograph
	 *            cryptograph.
	 * @param keyString
	 *            Key. If null, use {@link #DEFAULT_DES_KEY}.<br>
	 *            Use the default jvm encoding, and will automatically correct
	 *            for the 8 byte.
	 * @return the decrypted string.
	 */
	public static String decryptByDES(String cryptograph, String keyString) {
		if (cryptograph == null)
			return null;
		byte[] bytes = base64Decode(cryptograph);
		byte[] key = DEFAULT_DES_KEY;
		if (!StringUtils.isBlank(keyString)) {
			key = fixToBytes(keyString, 8);
		}
		try {
			return new String(com.eos.system.utility.CryptoUtil.decrypt(bytes,
					key, com.eos.system.utility.CryptoUtil.DES_ALGORITHM));
		} catch (Exception e) {
			throw new EOSRuntimeException(DES_DECRYPT,
					new String[] { e.getMessage() });
		}
	}

	/**
	 * DES encryption.<br>
	 * DES encryption first, and then base64 encoding.
	 * 
	 * @param plainText
	 *            plainText.
	 * @param keyString
	 *            key
	 * @return encrypted string.
	 */
	public static String encryptByDES(String plainText, String keyString) {
		if (plainText == null)
			return null;
		byte[] key = DEFAULT_DES_KEY;
		if (!StringUtils.isBlank(keyString)) {
			key = fixToBytes(keyString, 8);
		}
		try {
			byte[] cryptograph = com.eos.system.utility.CryptoUtil.encrypt(
					plainText.getBytes(), key,
					com.eos.system.utility.CryptoUtil.DES_ALGORITHM);
			return base64Encode(cryptograph);
		} catch (Exception e) {
			throw new EOSRuntimeException(DES_ENCRYPT,
					new String[] { e.getMessage() });
		}
	}

	/**
	 * MD5 Abstract.<br>
	 * First summary, and then base64 encoding.
	 * 
	 * @param text
	 *            string.
	 * @return summary.
	 */
	public static String digestByMD5(String text) {
		if (text == null)
			return null;
		try {
			byte[] digest = com.eos.system.utility.CryptoUtil.md5(text
					.getBytes());
			return base64Encode(digest);
		} catch (NoSuchAlgorithmException e) {
			throw new EOSRuntimeException(MD5,
					new String[] { e.getMessage() });
		}
	}

	/**
	 * MD5 Abstract.<br>
	 * First summary, and then base64 encoding.
	 * 
	 * @param text
	 *            string.
	 * @return summary.
	 */
	public static String digestBySHA(String text) {
		if (text == null)
			return null;
		try {
			java.security.MessageDigest alg = java.security.MessageDigest
					.getInstance("SHA");
			alg.update(text.getBytes());
			byte[] digest = alg.digest();
			return base64Encode(digest);
		} catch (NoSuchAlgorithmException e) {
			throw new EOSRuntimeException(SHA,
					new String[] { e.getMessage() });
		}
	}
 
	private static final byte[] fixToBytes(String s, int destLength) {
		byte[] bytes = s.getBytes();
		int xLength = destLength - bytes.length;
		if (xLength == 0)
			return bytes;
		if (xLength > 0) {
			byte[] result = new byte[destLength];
			System.arraycopy(bytes, 0, result, 0, bytes.length);
			return result;
		}
		byte[] result = new byte[destLength];
		System.arraycopy(bytes, 0, result, 0, destLength - 1);
		return result;
	}

}
