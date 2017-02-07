package com.xurui.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.xurui.dormain.Question;
import com.xurui.dormain.TestQuestion;

public class TestQuestionUtil {
	DBAccess db = new DBAccess();
	public ArrayList getTest(String Uid,String course,int type,String test_time)//获得试卷库中相应题型的题
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList al = new ArrayList();
		try{
			String sql = " select t.userid,t.qid,t.answer xsda," +
		           " t.course,t.score,t.qtype,t.tnumber,t.test_time, "+
					" q.ques,q.keyA,q.keyB,q.keyC,q.keyD,q.answer bzda from test  t inner join Question  q  on t.Qid = q.Qid where t.userid=? and t.course=? and t.Qtype=? and t.test_time=? order by Tnumber";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			ps.setString(2, course);
			ps.setInt(3, type);
			ps.setString(4, test_time);
			rs = ps.executeQuery();
			while(rs.next())
			{
				TestQuestion tq = new TestQuestion();
				tq.setUid(Uid);
				tq.setQid(rs.getInt("QID"));
				tq.setStuAnswer(rs.getString("XSDA"));
				tq.setCourse(course);
				tq.setScore(rs.getFloat("SCORE"));
				tq.setType(type);
				tq.setTnumber(rs.getInt("TNUMBER"));
				tq.setQues(rs.getString("QUES"));
				tq.setKeyA(rs.getString("KEYA"));
				tq.setKeyB(rs.getString("KEYB"));
				tq.setKeyC(rs.getString("KEYC"));
				tq.setKeyD(rs.getString("KEYD"));
				tq.setAnswer(rs.getString("BZDA"));
				al.add(tq);
				
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}finally
		{
			db.CloseDB(conn, ps, rs);
			return al;
		}
		
	}
	
	
	public List<Question> getDa()//获得试卷库中的题对应的答案
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Question> al = new ArrayList<Question>();
		try{
			String sql = "select qid ,answer,qtype from QUESTION  where qtype in(1,2,3) order by qtype, qid  ";
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while(rs.next())
			{
				Question tq = new Question();
				tq.setId(rs.getInt("QID"));
				tq.setType(rs.getInt("QTYPE"));
				tq.setAnswer(rs.getString("ANSWER"));
				al.add(tq);
				
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}finally
		{
			db.CloseDB(conn, ps, rs);
			
		}
		return al;
		
	}

}
