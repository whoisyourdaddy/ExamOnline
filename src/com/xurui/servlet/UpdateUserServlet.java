package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xurui.dormain.User;
import com.xurui.util.MD5Util;
import com.xurui.util.UserUtil;

public class UpdateUserServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UpdateUserServlet() {
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
		String Uid=request.getParameter("Uid");
		String name=new String(request.getParameter("name").getBytes("iso8859-1"),"utf-8").trim();
		int type=Integer.parseInt(request.getParameter("type"));
		String sex=new String(request.getParameter("sex").getBytes("iso8859-1"),"utf-8").trim();
		String password = MD5Util.encoderByMd5("123456");//初始密码设为123456
		String flag = request.getParameter("flag").trim();
		//是否为学生注册接口传入
		String pwd = null ;
		if("0".equals(flag)){
			if(request.getParameter("pwd1")!=null){
			pwd=MD5Util.encoderByMd5(request.getParameter("pwd1"));
			}
		}
		String registStud = request.getParameter("registStud");
		if(registStud == null) 
		{
			pwd = password;
			registStud = "";
		}
		
		UserUtil userUtil = new UserUtil(); 
		User user = new User();
		boolean success = false;
		user.setId(Uid);
		user.setType(type);
		user.setName(name);
		user.setPassword(pwd);
		user.setSex(sex);
		if("0".equals(flag))
		{
		  success= userUtil.insertUser(user);	
			
		}else if("1".equals(flag))
		{
			success=userUtil.motifyUser(user);
		}
		if(success)
		{
			if("1".equals( registStud ) ) { // 学生注册，跳转到登陆
				response.sendRedirect(request.getContextPath()+"/student/login.jsp");//"/student/login.jsp"
			} else {
				response.sendRedirect(request.getContextPath()+"/admin/success.html");
			}
		}
		else
		{
			response.sendRedirect(request.getContextPath()+"/Fail.html");
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
