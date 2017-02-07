package com.xurui.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xurui.dormain.Question;

/**
 * 缓存试题答案
 * @author mjf
 *
 */
public class CacheUtils {
	/**
	 * 存放单选、多选、判断题答案
	 */
	public static Map<Integer,String> answers  =new HashMap<Integer,String>();
	static {
		 //List<Question> ques  --> Map<Integer,String> answers
        List<Question> ques = new TestQuestionUtil().getDa();
        
        for (Question question : ques) {
			answers.put(question.getId(), question.getAnswer());
		 }
	}
}
