package com.xurui.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class MD5Util {
	/**
	 * MD5加码 生成32位md5码
	 * 
	 * @param str
	 *            待加密的字符串
	 * @return 加密后的字符串
	 * @throws NoSuchAlgorithmException
	 *             没有这种产生消息摘要的算法
	 * 
	 */
	public static String encoderByMd5(String str) {
		MessageDigest md5 = null;

		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		char[] charArray = str.toCharArray();

		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)

			byteArray[i] = (byte) charArray[i];

		byte[] md5Bytes = md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();

		for (int i = 0; i < md5Bytes.length; i++) {

			int val = ((int) md5Bytes[i]) & 0xff;

			if (val < 16)

				hexValue.append("0");

			hexValue.append(Integer.toHexString(val));

		}

		return hexValue.toString();
	}

	/**
	 * 
	 * 加密解密算法 执行一次加密，两次解密
	 */

	public static String convertMD5(String inStr) {

		char[] a = inStr.toCharArray();

		for (int i = 0; i < a.length; i++) {

			a[i] = (char) (a[i] ^ 't');

		}

		String s = new String(a);

		return s;

	}

	// 测试主函数

	public static void main(String args[]) {

		String str = new String("123456");

		System.out.println("原始：" + str);

		String encoderStr  =encoderByMd5(str);
		System.out.println("MD5加密后：" +encoderStr +" 长度为:"+ encoderStr.length());

	}
}
