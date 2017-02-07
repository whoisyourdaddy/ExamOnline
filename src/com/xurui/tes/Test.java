package com.xurui.tes;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.xurui.util.MD5Util;

public class Test {
	public static void main(String[] args) {
		System.out.println(new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
		//"f6fdffe48c908deb0f4c3bd36c032e72"
		System.out.println(MD5Util.encoderByMd5("adminadmin").equals("f6fdffe48c908deb0f4c3bd36c032e72"));
	}
}
