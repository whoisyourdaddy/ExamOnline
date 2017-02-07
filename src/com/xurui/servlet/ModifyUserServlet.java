package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xurui.dormain.User;
import com.xurui.util.UserUtil;

public class ModifyUserServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ModifyUserServlet() {
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
		PrintWriter out = response.getWriter();
		UserUtil userUtil = new UserUtil();
        HttpSession session = request.getSession(true);
        String Uid = (String)session.getAttribute("Uid");
        String name = new String(request.getParameter("name").trim().getBytes("iso8859-1"),"UTF-8");
        String typeString=new String(request.getParameter("type").getBytes("iso8859-1"),"UTF-8");
        int type=1;
        if("教师".equals(typeString))
        {
        	type=2;
        }else if("管理员".equals(typeString))
        {
        	type=3;
        }
        
        String sex = new String(request.getParameter("sex").getBytes("iso8859-1"),"UTF-8").trim();
        User user = new User();
        user.setId(Uid);
        user.setName(name.trim());
        user.setType(type);
        user.setSex(sex);
        if(userUtil.motifyUser(user))
        {
        	response.sendRedirect(request.getContextPath()+"/success.html");
        }else
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
