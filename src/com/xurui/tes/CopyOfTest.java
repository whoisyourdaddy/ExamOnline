package com.xurui.tes;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CopyOfTest {
	public static void main(String[] args) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssms");
		String formatStr =formatter.format(new Date());
		System.out.println(formatStr);
	}
}
