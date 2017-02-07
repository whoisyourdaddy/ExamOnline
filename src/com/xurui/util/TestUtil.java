package com.xurui.util;

import java.sql.*;

import com.sun.org.apache.regexp.internal.recompile;
import com.xurui.dormain.*;

import java.util.*;

public class TestUtil {
	DBAccess db = new DBAccess();

	public boolean insertTest(ArrayList al) {
		boolean flag = false;

		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn.setAutoCommit(false);// 打开事务(关闭自动提交)
			String sql = "insert into test(userid,Qid,Tnumber,course,Qtype,answer,score,test_time) values(?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);

			for (int i = 0; i < al.size(); i++) {
				Test ts = (Test) al.get(i);
				ps.setString(1, ts.getUid());
				ps.setInt(2, ts.getQid());
				ps.setInt(3, ts.getTnumber());
				ps.setString(4, ts.getCourse());
				ps.setInt(5, ts.getType());
				ps.setString(6, ts.getStuAnswer());
				ps.setFloat(7, ts.getScore());
				ps.setString(8, ts.getTest_time());
				ps.addBatch();
			}
			int[] is = ps.executeBatch();
			conn.commit();// 提交事务
			if (is != null) {
				flag = true;
			}
		} catch (Exception e) {
			conn.rollback();// 出现异常回滚事务
			e.printStackTrace();

		} finally {
			db.CloseDB(conn, ps, rs);
			return flag;
		}
	}
	public int getC(String course)//学生数量
	{   PreparedStatement ps = null;
		ResultSet rs = null;
		
		Connection conn = null;
		conn = db.getConnection();
		int count = 0;
		
		try 
		{
			
			String sql="select count(*) from "+
			        "  (SELECT A.*,b.name FROM "+
			           "        (select a.userid,a.course,a.test_time from test  a where a.course=? group by a.userid,course,test_time)A left outer join UserInfo  b on a.userid = b.userid  )  ";
			//String sql  = "select count(*) from test  ";
					// " (select  distinct  userid,test_time,course  from test where course=? ) ";

			System.out.println(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			rs=ps.executeQuery();     // 执行sql语句
			if(rs.next())
			{
			  count = rs.getInt(1);
			}
			
		}
		catch (Exception E) 
		{
			E.printStackTrace();
			
		}
		finally 
		{
			// 关闭连接，释放数据库资源：
			db.CloseDB(conn,ps,rs);
			return count;
		}
		
	}

	
	public ArrayList getS(String course,int pageSize,int current)//得到指定页的学生
	{   PreparedStatement ps = null;
		ResultSet rs = null;
		
		Connection conn = null;
		ArrayList al = new ArrayList();
		conn = db.getConnection();
		
		try 
		{
			String sql =" SELECT * FROM "+
         "  (SELECT A.*,b.name, ROWNUM RN FROM"+
           "        (select a.userid,a.course,a.test_time from test  a where a.course=? group by a.userid,course,test_time)A left outer join UserInfo  b on a.userid = b.userid  )  "
            +" WHERE RN BETWEEN "+ (pageSize*current-pageSize+1) +" AND "+ pageSize*current  ;
					System.out.println(sql);
			//String sql="select top "+pageSize+" * from UserInfo where utype<>3 and Uid not in (select top "+pageSize*(current-1)+"  Uid from UserInfo where utype<>3) order by Uid";
		    ps = conn.prepareStatement(sql);
		    ps.setString(1, course);
			rs = ps.executeQuery();     // 执行sql语句
			while(rs.next())
			{
				UserTest user = new UserTest();
				user.setId(rs.getString(1));
				user.setCourse(rs.getString(2));
				user.setTest_time(rs.getString(3));
				user.setName(rs.getString(4));
				
				al.add(user);
			}
			
		}
		catch (Exception E) 
		{
			E.printStackTrace();
			
		}
		finally 
		{
			// 关闭连接，释放数据库资源：
			db.CloseDB(conn,ps,rs);
			
		}
		return al;
		
	}//////////////
	public ArrayList getStudent(String course) {
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList al = new ArrayList();
		try {
			String sql = "select distinct b.name,a.userid from test a left outer join UserInfo  b on a.userid = b.userid where a.course=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setName(rs.getString(1));
				user.setId(rs.getString(2));
				al.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			db.CloseDB(conn, ps, rs);
		}
		return al;
	}

	public ArrayList getTest(String Uid, String course, int type)// 获得试卷库中相应题型的题
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList al = new ArrayList();
		try {
			String sql = "select * from test where userid=? and course=? and Qtype=? order by Tnumber";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			ps.setString(2, course);
			ps.setInt(3, type);
			rs = ps.executeQuery();
			while (rs.next()) {
				Test ts = new Test();
				ts.setUid(Uid);
				ts.setCourse(course);
				ts.setQid(rs.getInt(2));
				ts.setStuAnswer(rs.getString(3));
				ts.setScore(rs.getFloat(5));
				ts.setType(type);
				ts.setTnumber(rs.getInt(7));
				al.add(ts);

			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	public boolean updateTest(String Uid, int Qid, float score)// 修改试卷库中相应试题的分数
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			String sql = "update Test set score=? where userid=? and Qid=?";
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, score);
			ps.setString(2, Uid);
			ps.setInt(3, Qid);
			int i = ps.executeUpdate();
			if (i != 0) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return flag;

	}

}
