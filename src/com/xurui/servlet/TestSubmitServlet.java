package com.xurui.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xurui.dormain.*;
import com.xurui.util.*;

public class TestSubmitServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TestSubmitServlet() {
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
		HttpSession session  = request.getSession(true);
		String uid = (String)session.getAttribute("Uid");
		String course = (String)session.getAttribute("course");
		String test_time=(String)session.getAttribute("test_time");

		
		//String aa[]=request.getParameterValues("choiceId");
		//TestQuestionUtil tq = new TestQuestionUtil();
		//tq.getDa();
	     Map<Integer,String> answers  =new HashMap<Integer,String>();
		 
	     List<Question> ques = new TestQuestionUtil().getDa();
	        
	     for (Question question : ques) {
				answers.put(question.getId(), question.getAnswer());
			 }
		
		TestSetUtil testUtil = new TestSetUtil();	
        TestSet ts = testUtil.getTestSet(course,test_time);
        TestUtil tu = new TestUtil();
        ArrayList al = new ArrayList();
		
        //取单选题
		for(int i=0;i<ts.getSinChCount();i++)
		{
			Test test = new Test();
			int qid = Integer.parseInt(request.getParameter("choiceId"+i));//从隐藏表单元素中取题库中题号
			String stuAnswer = request.getParameter("choice"+i+"Value");//取考生答案
			stuAnswer = stuAnswer==null?"":stuAnswer;
			int tnumber = i;//题号
			int type = 1;//题的类型 
			//String answer = request.getParameter("choiceAnswer"+i);//取正确答案
			String anaswer=answers.get(qid);
			int score = (anaswer.equalsIgnoreCase(stuAnswer))?ts.getPerSinScore():0;//计算考生得分
			
			test.setQid(qid);
			test.setUid(uid);
			test.setCourse(course);
			test.setScore(score);
			test.setStuAnswer(stuAnswer);
			test.setType(type);
			test.setTnumber(tnumber);
			test.setTest_time(test_time);
			
			al.add(test);
			
		}
		
		  //取多选题
		for(int i=0;i<ts.getMulChCount();i++)
		{
			Test test = new Test();
			int qid = Integer.parseInt(request.getParameter("mulchoiceId"+i));//从隐藏表单元素中取题库中题号
			String[] paramValue = request.getParameterValues("mulchoice"+i+"Value");//取考生答案
			String stuAnswer="";
			if(paramValue!=null)
			{
				for(int j = 0;j < paramValue.length;j++)
				{
					stuAnswer+=paramValue[j];
				}
			}
			int tnumber = i;//题号
			int type = 2;//题的类型 
			//String answer = request.getParameter("mulchoiceAnswer"+i);//取正确答案
			String answer=answers.get(qid);
			int score = (answer.equalsIgnoreCase(stuAnswer))?ts.getPerMulScore():0;//计算考生得分
			
			//System.out.println(qid+":"+stuAnswer+"/"+answer+":"+score);
			test.setQid(qid);
			test.setUid(uid);
			test.setCourse(course);
			test.setScore(score);
			test.setStuAnswer(stuAnswer);
			test.setType(type);
			test.setTnumber(tnumber);
			test.setTest_time(test_time);
			
			al.add(test);
			
		}
		
		  //取判断题
		for(int i=0;i<ts.getJudgeCount();i++)
		{
			Test test = new Test();
			int qid = Integer.parseInt(request.getParameter("judgeId"+i));//从隐藏表单元素中取题库中题号
			String stuAnswer = request.getParameter("judge"+i+"Value");//取考生答案
			stuAnswer = stuAnswer==null?"":stuAnswer;
			
			int tnumber = i;//题号
			int type = 3;//题的类型 
			//String answer = request.getParameter("judgeAnswer"+i);//取正确答案
			String answer=answers.get(qid);
			int score = (answer.equalsIgnoreCase(stuAnswer))?ts.getPerJudScore():0;//计算考生得分
			
			//System.out.println(qid+":"+stuAnswer+"/"+answer+":"+score);
			test.setQid(qid);
			test.setUid(uid);
			test.setCourse(course);
			test.setScore(score);
			test.setStuAnswer(stuAnswer);
			test.setType(type);
			test.setTnumber(tnumber);
			test.setTest_time(test_time);
			
			al.add(test);
			
		}
		
		  //取简答题
		for(int i=0;i<ts.getJdCount();i++)
		{
			Test test = new Test();
			int qid = Integer.parseInt(request.getParameter("jdId"+i));//从隐藏表单元素中取题库中题号
			String stuAnswer = request.getParameter("stuJdAnswer"+i);//取考生答案
			stuAnswer = stuAnswer==null?"":new String(stuAnswer.getBytes("iso8859-1"),"utf-8").trim();
			int tnumber = i;//题号
			int type = 4;//题的类型 
			
			//System.out.println(qid+":"+stuAnswer);
			test.setQid(qid);
			test.setUid(uid);
			test.setCourse(course);
			test.setStuAnswer(stuAnswer);
			test.setType(type);
			test.setTnumber(tnumber);
			test.setTest_time(test_time);
			
			al.add(test);
			
		}
		
		  //取编程题
		for(int i=0;i<ts.getProgramCount();i++)
		{
			Test test = new Test();
			int qid = Integer.parseInt(request.getParameter("proId"+i));//从隐藏表单元素中取题库中题号
			String stuAnswer = request.getParameter("stuProAnswer"+i);//取考生答案
			stuAnswer = stuAnswer==null?"":new String(stuAnswer.getBytes("iso8859-1"),"utf-8").trim();
			int tnumber = i;//题号
			int type = 5;//题的类型 
			
			//System.out.println(qid+":"+stuAnswer);
			test.setQid(qid);
			test.setUid(uid);
			test.setCourse(course);
			test.setStuAnswer(stuAnswer);
			test.setType(type);
			test.setTnumber(tnumber);
			test.setTest_time(test_time);
			
			al.add(test);
			
		}
		try{
			boolean success = tu.insertTest(al);
			if(success)
			{
				 new UserFlagUtil().setFlag(uid, course,test_time);	//设置考试标志信息
				 response.sendRedirect(request.getContextPath()+"/student/finish.jsp");
			}else
			{
				response.sendRedirect(request.getContextPath()+"/student/Fail.html");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/student/Fail.html");
			
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
