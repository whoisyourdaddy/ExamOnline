package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xurui.util.*;

public class LoginServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public LoginServlet() {
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

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
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
	    String userName = request.getParameter("UserName").trim();
	    String password = MD5Util.encoderByMd5(request.getParameter("Password").trim());
	 
	    String test_time= new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	    String course = new String(request.getParameter("course").getBytes("iso8859-1"),"utf-8").trim();
	    UserFlagUtil ufu = new UserFlagUtil();
	    UserUtil userUtil = new UserUtil();
	    TestSetUtil ts =new TestSetUtil();
	    
	    boolean success = userUtil.checkUser(userName, password,1);
	    boolean success_username = userUtil.checkUser(userName,1);//验证用户名和用户类型是否正确；
	  	
	    
	    
	   if(!success_username)
	    {
	      response.sendRedirect(request.getContextPath()+"/student/login.jsp?flag=nobody");
	    } 	    	    
	   else if(success)//验证成功
	    {
	    	int flag = ufu.getFlag(userName,course,test_time);
	    	
	    	if(ts.getTestSet(course,test_time)!=null){
	    		if(flag!=1){
	    			 HttpSession session = request.getSession(true);
	    	         //通过session绑定
	    	         session.setAttribute("course", course);
	    	         session.setAttribute("Uid", userName);
	    	         session.setAttribute("test_time", test_time);
	    	         //重定向
	    	         response.sendRedirect(request.getContextPath()+"/student/welcome.jsp");	    				    	    			    			    		
	    	}else {
	    		response.sendRedirect(request.getContextPath()+"/student/login.jsp?flag=submited");
	    	}
	    	}else{
	    		response.sendRedirect(request.getContextPath()+"/student/login.jsp?flag=nothing");
	    	}
	    }
	   
	   else{
		   response.sendRedirect(request.getContextPath()+"/student/login.jsp?flag=error");
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
