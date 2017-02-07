package com.xurui.util;

import java.sql.*;
import java.util.ArrayList;

import com.xurui.dormain.*;

public class TestSetUtil {

	public DBAccess db = new DBAccess();

	public TestSet getTestSet(String course,String test_time)// 根据科目,日期得到考试设置信息
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		TestSet ts = null;
		try {
			conn = db.getConnection();
			String sql = "select * from test_set where course=? and test_time=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			ps.setString(2, test_time);
			rs = ps.executeQuery();
			if (rs.next()) {
				ts = new TestSet();
				int sinChCount = Integer.parseInt(rs.getString(2));
				int perSinScore = Integer.parseInt(rs.getString(3));
				int mulChCount = Integer.parseInt(rs.getString(4));
				int perMulScore = Integer.parseInt(rs.getString(5));
				int judgeCount = Integer.parseInt(rs.getString(6));
				int perJudScore = Integer.parseInt(rs.getString(7));
				int jdCount = Integer.parseInt(rs.getString(8));
				int perJdScore = Integer.parseInt(rs.getString(9));
				int programCount = Integer.parseInt(rs.getString(10));
				int perProScore = Integer.parseInt(rs.getString(11));
				int totaltime = Integer.parseInt(rs.getString(12));
				
				
				ts.setCourse(course);
				ts.setSinChCount(sinChCount);
				ts.setPerSinScore(perSinScore);
				ts.setMulChCount(mulChCount);
				ts.setPerMulScore(perMulScore);
				ts.setJudgeCount(judgeCount);
				ts.setPerJudScore(perJudScore);
				ts.setJdCount(jdCount);
				ts.setPerJdScore(perJdScore);
				ts.setProgramCount(programCount);
				ts.setPerProScore(perProScore);
				ts.setTotaltime(totaltime);
				ts.setTest_time(test_time);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
			
		}
		return ts;
	}
	public TestSet getTestSet(String test_time)// 根据科目,日期得到考试设置信息
	{
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		TestSet ts = null;
		try {
			conn = db.getConnection();
			String sql = "select * from test_set where test_time=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, test_time);
			rs = ps.executeQuery();
			if (rs.next()) {
				ts = new TestSet();
				int sinChCount = Integer.parseInt(rs.getString(2));
				int perSinScore = Integer.parseInt(rs.getString(3));
				int mulChCount = Integer.parseInt(rs.getString(4));
				int perMulScore = Integer.parseInt(rs.getString(5));
				int judgeCount = Integer.parseInt(rs.getString(6));
				int perJudScore = Integer.parseInt(rs.getString(7));
				int jdCount = Integer.parseInt(rs.getString(8));
				int perJdScore = Integer.parseInt(rs.getString(9));
				int programCount = Integer.parseInt(rs.getString(10));
				int perProScore = Integer.parseInt(rs.getString(11));
				int totaltime = Integer.parseInt(rs.getString(12));
				
				ts.setSinChCount(sinChCount);
				ts.setPerSinScore(perSinScore);
				ts.setMulChCount(mulChCount);
				ts.setPerMulScore(perMulScore);
				ts.setJudgeCount(judgeCount);
				ts.setPerJudScore(perJudScore);
				ts.setJdCount(jdCount);
				ts.setPerJdScore(perJdScore);
				ts.setProgramCount(programCount);
				ts.setPerProScore(perProScore);
				ts.setTotaltime(totaltime);
				ts.setTest_time(test_time);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
			
		}
		return ts;
	}

	public int getTotalScore(TestSet ts)// 计算总分
	{
		int totalScore = 0;
		if (ts != null) {
			int sinChCount = ts.getSinChCount();
			int perSinScore = ts.getPerSinScore();
			int mulChCount = ts.getMulChCount();
			int perMulScore = ts.getPerMulScore();
			int judgeCount = ts.getJudgeCount();
			int perJudScore = ts.getPerJudScore();
			int jdCount = ts.getJdCount();
			int perJdScore = ts.getPerJdScore();
			int programCount = ts.getProgramCount();
			int perProScore = ts.getPerProScore();
			totalScore = sinChCount * perSinScore + mulChCount * perMulScore
					+ judgeCount * perJudScore + jdCount * perJdScore
					+ programCount * perProScore;
		}
		return totalScore;
	}

	public ArrayList getCourse()// 获取科目
	{
		ArrayList al = new ArrayList<String>();
		Connection conn = db.getConnection();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			String sql = "select distinct course from test_set";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				String course = rs.getString(1);
				al.add(course);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, st, rs);

		}
		return al;
	}
	

	public int getCount()// 获取数量
	{
		int count = 0;
		Connection conn = db.getConnection();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			String sql = "select count(*) from test_set";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, st, rs);
		}
		return count;
	}

	public ArrayList getAllTestSet(int pageSize, int current)// 得到指定页的考试信息
	{
		Connection conn = db.getConnection();
		Statement sm = null;
		ResultSet rs = null;
		ArrayList al = new ArrayList();
		try {
			conn = db.getConnection();
			// String sql =
			// "select top "+pageSize+" * from test_set where course not in (select top "+pageSize*(current-1)+"  course from test_set) order by course";
			String sql = " SELECT * FROM " + " (SELECT A.*, ROWNUM RN FROM"
					+ " (SELECT * FROM test_set   order by course desc) A ) "
					+ " WHERE RN BETWEEN "
					+ (pageSize * current - pageSize + 1) + " AND " + pageSize
					* current;
			sm = conn.createStatement();
			rs = sm.executeQuery(sql);
			while (rs.next()) {
				TestSet ts = new TestSet();
				ts.setCourse(rs.getString(1).trim());
				ts.setSinChCount(rs.getInt(2));
				ts.setPerSinScore(rs.getInt(3));
				ts.setMulChCount(rs.getInt(4));
				ts.setPerMulScore(rs.getInt(5));
				ts.setJudgeCount(rs.getInt(6));
				ts.setPerJudScore(rs.getInt(7));
				ts.setJdCount(rs.getInt(8));
				ts.setPerJdScore(rs.getInt(9));
				ts.setProgramCount(rs.getInt(10));
				ts.setPerProScore(rs.getInt(11));
				ts.setTotaltime(rs.getInt(12));
				ts.setTest_time(rs.getString(13));
				al.add(ts);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, sm, rs);
		}
		return al;
	}

	public boolean insertOrUpdate(TestSet ts, int flag)// 添加或修改考试设置,flag=0为添加，flag=1为修改
	{
		boolean success = false;
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "";			
			if (flag == 0) {
				sql = "insert into test_set(sinc,persin,mulc,permul,judge,perju,jd,perjd,program,perpro,totaltime,course,test_time) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			} else if (flag == 1) {
				sql = "update test_set set sinc=?,persin=?,mulc=?,permul=?,judge=?,perju=?,jd=?,perjd=?,program=?,perpro=?,totaltime=? where course=? and test_time=?";
			}
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ts.getSinChCount());
			ps.setInt(2, ts.getPerSinScore());
			ps.setInt(3, ts.getMulChCount());
			ps.setInt(4, ts.getPerMulScore());
			ps.setInt(5, ts.getJudgeCount());
			ps.setInt(6, ts.getPerJudScore());
			ps.setInt(7, ts.getJdCount());
			ps.setInt(8, ts.getPerJdScore());
			ps.setInt(9, ts.getProgramCount());
			ps.setInt(10, ts.getPerProScore());
			ps.setInt(11, ts.getTotaltime());
			ps.setString(12, ts.getCourse());
			ps.setString(13, ts.getTest_time());	
			count = ps.executeUpdate();
			if (count != 0) {
				success = true;

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
		}
		return success;
	}

	public boolean deleteTest(String course,String test_time)// 删除考试设置信息
	{
		boolean flag = false;
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "delete from test_set where course=? and test_time=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			ps.setString(2,test_time);
			count = ps.executeUpdate();
			if (count != 0) {
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
