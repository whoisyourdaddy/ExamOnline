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
import com.xurui.util.MD5Util;
import com.xurui.util.QuestionUtil;
import com.xurui.util.UserUtil;
/**
 * 密码重置
 * @author Administrator
 *
 */
public class ResetPwdServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ResetPwdServlet() {
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
		PrintWriter  out =response.getWriter();
		
		String mobile=request.getParameter("mobile");
		UserUtil userUtil = new UserUtil();
		String resetPwd  = MD5Util.encoderByMd5("123456");
		boolean flag  =  userUtil.motifyPassword(mobile,resetPwd );
		Map result  = new HashMap();
		if(flag){
			result.put("result", "1");
		}else{
			result.put("result", "0");
		}
		
		String msg  = JSONObject.toJSONString(result);
		out.print(msg);
		
		
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
