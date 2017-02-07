package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xurui.util.MD5Util;
import com.xurui.util.UserUtil;

public class RecordQueryServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public RecordQueryServlet() {
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

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
	    String userName = request.getParameter("UserName");
	    String password = request.getParameter("Password");
	    String test_time="1992/02/17";
	    UserUtil userUtil = new UserUtil();
	    boolean success = userUtil.checkUser(userName, password,1);
	    if(success)
	    {
	    	HttpSession session = request.getSession(true);
	    	session.setAttribute("Uid", userName);
	    	response.sendRedirect(request.getContextPath()+"/Record/main.html");
	    	
	    }else
	    {
	      
	      response.sendRedirect(request.getContextPath()+"/Record/login.jsp?flag=error");
	    }
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
		PrintWriter out = response.getWriter();
	    String userName = request.getParameter("UserName");
	    String password = MD5Util.encoderByMd5(request.getParameter("Password"));
	    String test_time="1992/02/17";
	    UserUtil userUtil = new UserUtil();
	    boolean success = userUtil.checkUser(userName, password,1);
	    if(success)
	    {
	    	HttpSession session = request.getSession(true);
	    	session.setAttribute("Uid", userName);
	    	response.sendRedirect(request.getContextPath()+"/Record/main.html");
	    	
	    }else
	    {
	      
	      response.sendRedirect(request.getContextPath()+"/Record/login.jsp?flag=error");
	    }
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
