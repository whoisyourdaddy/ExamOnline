package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xurui.dormain.*;
import com.xurui.util.*;

public class ScoreSubmitServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ScoreSubmitServlet() {
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

		response.setContentType("text/html");
		HttpSession session = request.getSession(true);
		
		String Uid = request.getParameter("Uid");
		String course = (String)session.getAttribute("course");
		String test_time = new String(request.getParameter("test_time").getBytes("iso8859-1"),"utf-8").trim();
		TestUtil tu = new TestUtil();
		TestSetUtil tsu = new TestSetUtil();
		Record record = new Record();
		RecordUtil ru = new RecordUtil();
		TestSet ts = tsu.getTestSet(course,test_time);
		float singleTotal = 0;//单选题
		float multiplyTotal = 0;//多选题
		float judgeTotal = 0;//判断题
		float jdTotal = 0;//解答题
		float programTotal=0;//编程题
		float total=0;//总分
		
		for(int i=0;i<ts.getSinChCount();i++)
		{
			float score = Float.parseFloat(request.getParameter("choice"+i));
			singleTotal+=score;
			//System.out.println(score);
			
		}
		for(int i=0;i<ts.getMulChCount();i++)
		{
			float score = Float.parseFloat(request.getParameter("mulChoice"+i));
			multiplyTotal+=score;
			//System.out.println(score);
			
		}
		for(int i=0;i<ts.getJudgeCount();i++)
		{
			float score = Float.parseFloat(request.getParameter("judge"+i));
			judgeTotal+=score;
			//System.out.println(score);
			
		}
		for(int i=0;i<ts.getJdCount();i++)
		{
			float score = Float.parseFloat(request.getParameter("jd"+i));
			jdTotal+=score;
			int Qid = Integer.parseInt(request.getParameter("jdId"+i));
			//系统自动算出判断、单选、多选得分
			tu.updateTest(Uid, Qid, score);
			
		}
		for(int i=0;i<ts.getProgramCount();i++)
		{
			float score = Float.parseFloat(request.getParameter("pro"+i));
			programTotal+=score;
			int Qid = Integer.parseInt(request.getParameter("proId"+i));
			tu.updateTest(Uid, Qid, score);
			
		}
		total = singleTotal+multiplyTotal+judgeTotal+jdTotal+programTotal;
		//成绩单
		record.setUid(Uid);
		record.setCourse(course);
		record.setScore(total);
		record.setSingle(singleTotal);
		record.setMultiply(multiplyTotal);
		record.setJudge(judgeTotal);
		record.setJd(jdTotal);
		record.setProgram(programTotal);
		
		record.setTest_time(test_time);
		//System.out.print(record.getUid()+record.getCourse());
		if(ru.updateRecord(record,test_time))
		{
			response.sendRedirect(request.getContextPath()+"/teacher/success.html");
		}else
		{
			response.sendRedirect(request.getContextPath()+"/teacher/fail.html");
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
