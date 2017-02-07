package com.xurui.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

/*
 * 定时吃饭
 * */
public class EatTimerTask extends TimerTask {

	// 吃饭时间
	private static List<Integer> eatTimes;
	/*
	 * 静态初始化
	 */
	static {
		initEatTimes();
	}

	/*
	 * 初始化吃饭时间
	 */
	private static void initEatTimes() {
		eatTimes = new ArrayList<Integer>();
		eatTimes.add(8);
		eatTimes.add(12);
		eatTimes.add(13);
		//eatTimes.add(18);
	}

	/*
	 * 执行
	 */
	@Override
	public void run() {
		Calendar calendar = Calendar.getInstance();
		System.out.println("检查是否到了吃饭的点"+ new Date().toLocaleString());
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		if (eatTimes.contains(hour)) {
			System.out.println("饿了，吃饭...");
		}
	}

}
