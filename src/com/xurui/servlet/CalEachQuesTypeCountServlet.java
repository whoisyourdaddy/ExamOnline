package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.xurui.util.QuestionUtil;

public class CalEachQuesTypeCountServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CalEachQuesTypeCountServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		Map map  = new HashMap();
		PrintWriter  out =response.getWriter();
		
		String course=request.getParameter("course");
		QuestionUtil qu  =new QuestionUtil();
		//考题类型 1:单选 2:多选 3:判断 4:简答 5:编程
		int danx  =  qu.getCount(1, course);
		int duox  =  qu.getCount(2, course);
		int pand  =  qu.getCount(3, course);
		int jiand  =  qu.getCount(4, course);
		int bianc  =  qu.getCount(5, course);
		map.put("danx", danx);
		map.put("duox", duox);
		map.put("pand", pand);
		map.put("jiand", jiand);
		map.put("bianc", bianc);
		
		Map result  = new HashMap();
		result.put("result", map);
		String jsonDate  = JSONObject.toJSONString(result);
		out.print(jsonDate);
		
		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
