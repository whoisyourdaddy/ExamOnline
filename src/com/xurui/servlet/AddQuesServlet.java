package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xurui.dormain.Question;
import com.xurui.util.QuestionUtil;

public class AddQuesServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddQuesServlet() {
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

		response.setContentType("text/html;charset=uft-8");
		String kemu = request.getParameter("kemu").trim();
		String ch_course = "course"+kemu;
		String course = new String(request.getParameter(ch_course).getBytes("iso8859-1"),"utf-8");
		int type = Integer.parseInt(request.getParameter("type").trim());
		String ques = new String(request.getParameter("ques").getBytes("iso8859-1"),"utf-8");
		String keyA = null;
		String keyB = null;
		String keyC = null;
		String keyD = null;
		String answer = "";
		QuestionUtil qu = new QuestionUtil();
		Question question = new Question();
		if(type==1)//单选题
		{
			keyA = new String(request.getParameter("keyA").getBytes("iso8859-1"),"utf-8").trim();
			keyB = new String(request.getParameter("keyB").getBytes("iso8859-1"),"utf-8").trim();
			keyC = new String(request.getParameter("keyC").getBytes("iso8859-1"),"utf-8").trim();
			keyD = new String(request.getParameter("keyD").getBytes("iso8859-1"),"utf-8").trim();
			answer = request.getParameter("answer_sin").trim();
		}else if(type==2)//多选题
		{
			keyA = new String(request.getParameter("keyA").getBytes("iso8859-1"),"utf-8").trim();
			keyB = new String(request.getParameter("keyB").getBytes("iso8859-1"),"utf-8").trim();
			keyC = new String(request.getParameter("keyC").getBytes("iso8859-1"),"utf-8").trim();
			keyD = new String(request.getParameter("keyD").getBytes("iso8859-1"),"utf-8").trim();
			String[] str_answer = request.getParameterValues("answer_mul");
			for(int i = 0;i < str_answer.length;i++)
			{
				answer = answer + str_answer[i];
				
			}
		}else if(type==3)//判断题
		{
			answer = request.getParameter("answer_jud");
		}else//简答题，编程题
		{
			answer = new String(request.getParameter("answer_other").getBytes("iso8859-1"),"utf-8").trim();
		}
		question.setCourse(course);
		question.setType(type);
		question.setQues(ques);
		question.setKeyA(keyA);
		question.setKeyB(keyB);
		question.setKeyC(keyC);
		question.setKeyD(keyD);
		question.setAnswer(answer);
		boolean success = qu.insertQuestioin(question);
		if(success)
		{
			response.sendRedirect(request.getContextPath()+"/admin/AddQuesSuccess.html");
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
