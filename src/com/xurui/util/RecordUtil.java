package com.xurui.util;

import java.sql.*;
import java.util.ArrayList;

import com.xurui.dormain.*;

public class RecordUtil {
	public DBAccess db = new DBAccess();

	public Record getRecord(String Uid, String course, String test_time)// 获取得分信息
	{
		Record record = null;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select * from recordtest where userid=? and course=? and test_time=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			ps.setString(2, course);
			ps.setString(3, test_time);
			rs = ps.executeQuery();
			if (rs.next()) {
				record = new Record();
				record.setUid(rs.getString("USERID"));
				record.setCourse(rs.getString("COURSE"));
				record.setScore(rs.getFloat("SCORE"));
				record.setSingle(rs.getFloat("SINGLEC"));
				record.setMultiply(rs.getFloat("MULTIPLYC"));
				record.setJudge(rs.getFloat("JUDGE"));
				record.setJd(rs.getFloat("JD"));
				record.setProgram(rs.getFloat("PROGRAM"));
				record.setTest_time(rs.getString("TEST_TIME"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return record;

	}

	public boolean getUser(String Uid, String course, String test_time)// 判断学生成绩是否存在
	{
		boolean flag = false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from recordtest where userid=? and course=? and test_time=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			ps.setString(2, course);
			ps.setString(3, test_time);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getInt(1) != 0) {
					flag = true;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return flag;

	}

	public boolean updateRecord(Record record, String test_time) {
		boolean flag = false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "";
			if (this.getUser(record.getUid(), record.getCourse(),
					record.getTest_time()))// 用户存在
			{
				sql = "update recordtest set score=?,singlec=?,multiplyc=?,judge=?,jd=?,program=? where userid=? and course=? and test_time=?";
			} else// 用户不存在
			{
				sql = "insert into recordtest(score,singlec,multiplyc,judge,jd,program,userid,course,test_time) values(?,?,?,?,?,?,?,?,?)";
			}
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, record.getScore());
			ps.setFloat(2, record.getSingle());
			ps.setFloat(3, record.getMultiply());
			ps.setFloat(4, record.getJudge());
			ps.setFloat(5, record.getJd());
			ps.setFloat(6, record.getProgram());
			ps.setString(7, record.getUid());
			ps.setString(8, record.getCourse());
			ps.setString(9, record.getTest_time());
			int i = ps.executeUpdate();
			if (i != 0) {
				flag = true;
			} else {
				flag = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return flag;

	}

	public int getPass(String course)// 获取及格人数
	{
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from recordtest where course=? and score>=60";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return count;

	}

	public int getCount(String course)// 获取总人数
	{
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from recordtest where course=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return count;

	}

	public int getCountByScore(String course, int score)// 获分数段人数
	{
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from recordtest where course=? and score>=? and score<?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, course);
			ps.setInt(2, score);
			ps.setInt(3, score + 10);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return count;

	}

	public ArrayList getAll(String Uid)// 得到学生的全部成绩
	{
		ArrayList al = new ArrayList();
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select * from recordtest where userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			rs = ps.executeQuery();
			while (rs.next()) {
				Record record = new Record();

				record.setUid(rs.getString("USERID"));
				record.setCourse(rs.getString("COURSE"));
				record.setScore(rs.getFloat("SCORE"));
				record.setSingle(rs.getFloat("SINGLEC"));
				record.setMultiply(rs.getFloat("MULTIPLYC"));
				record.setJudge(rs.getFloat("JUDGE"));
				record.setJd(rs.getFloat("JD"));
				record.setProgram(rs.getFloat("PROGRAM"));

				al.add(record);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	public ArrayList getZhiDingYe(String Uid, int pageSize, int current)// 得到学生的指定页成绩
	{
		ArrayList al = new ArrayList();
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			String sql = " SELECT * FROM "
					+ " (SELECT A.*, ROWNUM RN FROM"
					+ " (select * from recordtest where userid=?) A order by test_time desc) "
					+ " WHERE RN BETWEEN "
					+ (pageSize * current - pageSize + 1) + " AND " + pageSize
					* current;
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			rs = ps.executeQuery();
			while (rs.next()) {
				Record record = new Record();

				record.setUid(rs.getString("USERID"));
				record.setCourse(rs.getString("COURSE"));
				record.setScore(rs.getFloat("SCORE"));
				record.setSingle(rs.getFloat("SINGLEC"));
				record.setMultiply(rs.getFloat("MULTIPLYC"));
				record.setJudge(rs.getFloat("JUDGE"));
				record.setJd(rs.getFloat("JD"));
				record.setProgram(rs.getFloat("PROGRAM"));
				record.setTest_time(rs.getString("TEST_TIME"));

				al.add(record);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	public int getTestcount(String Uid)// 得到学生的考试次数
	{
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from  recordtest where  userid=?";
			System.out.println(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return count;

	}

	public ArrayList getA(String Uid, String course, String Test_time)// 得到学生的最新成绩
	{
		ArrayList al = new ArrayList();
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select * from ( select * from recordtest where  userid=? and course=? and   test_time=? order by test_time ) a where rownum = 1 ";
			System.out.println(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1, Uid);
			ps.setString(2, course);
			ps.setString(3, Test_time);
			rs = ps.executeQuery();
			while (rs.next()) {
				Record record = new Record();

				record.setUid(rs.getString("USERID"));
				record.setCourse(rs.getString("COURSE"));
				record.setScore(rs.getFloat("SCORE"));
				record.setSingle(rs.getFloat("SINGLEC"));
				record.setMultiply(rs.getFloat("MULTIPLYC"));
				record.setJudge(rs.getFloat("JUDGE"));
				record.setJd(rs.getFloat("JD"));
				record.setProgram(rs.getFloat("PROGRAM"));

				al.add(record);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	public ArrayList getScores(String course, int pageSize, int current)// 获取成绩分布表
	{
		ArrayList al = new ArrayList();
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT * FROM(SELECT A.*, ROWNUM RN  FROM( ")
					.append(" select count(*) COUNT,test_time test_time,course course, ")
					.append(" sum( case when score<60 then 1 else 0 end) nosix , ")
					.append(" sum( case when score>=60 then 1 else 0 end) yessix, ")
					.append(" sum( case when 60<=score and score<70 then 1 else 0 end)  six, ")
					.append(" sum( case when 70<=score and score<80 then 1 else 0 end) seven, ")
					.append(" sum( case when 80<=score and score<90 then 1 else 0 end) eight, ")
					.append(" sum( case when 90<=score and score<=100 then 1 else 0 end) nine ")
					.append(" from recordtest ")
					.append(" where course=?  ")
					.append(" group by test_time ,course  ")
					.append(" order by test_time desc ,course)A)  ")
					.append(" WHERE RN BETWEEN "
							+(pageSize * current - pageSize+1)+"  AND "
							+ pageSize * current);

			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, course);
			rs = ps.executeQuery();
			while (rs.next()) {
				Scores scores = new Scores();
				scores.setCount(rs.getInt("COUNT"));
				scores.setCourse(rs.getString("COURSE"));
				scores.setTest_time(rs.getString("TEST_TIME"));
				scores.setYessix(rs.getInt("YESSIX"));
				scores.setNosix(rs.getInt("NOSIX"));
				scores.setSix(rs.getInt("SIX"));
				scores.setSeven(rs.getInt("SEVEN"));
				scores.setEight(rs.getInt("EIGHT"));
				scores.setNine(rs.getInt("NINE"));

				al.add(scores);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	public int getScoresC(String course)// 获取成绩分布表的行数
	{
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			StringBuffer sql = new StringBuffer();
			sql.append(" select count(*) count from(  ");

			sql.append(" select count(*) COUNT,test_time test_time,course course, ");
			sql.append(" sum( case when score<60 then 1 else 0 end) nosix , ");
			sql.append(" sum( case when score>=60 then 1 else 0 end) yessix, ");
			sql.append(" sum( case when 60<=score and score<70 then 1 else 0 end)  six, ");
			sql.append(" sum( case when 70<=score and score<80 then 1 else 0 end) seven, ");
			sql.append(" sum( case when 80<=score and score<90 then 1 else 0 end) eight, ");
			sql.append(" sum( case when 90<=score and score<100 then 1 else 0 end) nine ");
			sql.append(" from recordtest ");
			sql.append(" where course=? ");
			sql.append(" group by test_time ,course ");
			sql.append(" order by test_time desc ,course) ");
System.out.println(sql);
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, course);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return count;

	}
}
