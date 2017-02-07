package com.xurui.util;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class EatTimerTaskTest {
	public static void main(String[] arg) {
		TimerTask task = new EatTimerTask();
		Calendar calendar = Calendar.getInstance();

		Date firstTime = calendar.getTime();
		// 间隔：1小时
		// long period = 1000 * 60 * 60;
		// 测试时间每分钟一次
		long period = 1000 * 10;

		Timer timer = new Timer();
		timer.schedule(task, firstTime, period);
	}
}
