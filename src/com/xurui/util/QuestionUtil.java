package com.xurui.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;

import com.xurui.dormain.Question;

public class QuestionUtil {

	public DBAccess db = new DBAccess();

	public ArrayList getQuestion2(String course, int count, int type)// 得到选择题的方法
	{
		/**
		 * 所有该类型的题目
		 */
		ArrayList all = new ArrayList();
		/**
		 * 随机选中的题
		 */
		ArrayList randomSelect = new ArrayList();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = db.getConnection();
			String sql = "select * from Question where qtype=? and course=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, type);
			ps.setString(2, course);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Question ques = new Question();
				ques.setId(rs.getInt("QID"));
				ques.setType(1);
				ques.setCourse(rs.getString("COURSE"));
				ques.setQues(rs.getString("QUES"));
				ques.setKeyA(rs.getString("KEYA"));
				ques.setKeyB(rs.getString("KEYB"));
				ques.setKeyC(rs.getString("KEYC"));
				ques.setKeyD(rs.getString("KEYD"));
				ques.setAnswer(rs.getString("ANSWER"));
				all.add(ques);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
		}
		
		int index;
		for (int i = 0; i < count; i++) {
			index  =new Random().nextInt(all.size());
			randomSelect.add(all.get(index));
			all.remove(index);
		}
		return randomSelect;
	}
	
	/**
	 * sql server分页
	 * @param course
	 * @param count
	 * @param type
	 * @return
	 */
	public ArrayList getQuestion(String course, int count, int type)// 得到选择题的方法
	{
		ArrayList al = new ArrayList();
		int totalCount = this.getCount(type, course);// 得到选择题数量
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int temp = (int) (Math.random() * totalCount);// 随机产生一个0-总题数之间的随机整数
		try {
			conn = db.getConnection();
			for (int i = 0; i < count; i++)// 取题
			{
				int tempCount = (temp + i) % totalCount;
				String sql = "select top 1 * from Question where qtype=" + type
						+ " and course='" + course
						+ "' and Qid not in(select top " + tempCount
						+ " Qid from Question where qtype=" + type
						+ " and course='" + course + "')";
				ps = conn.prepareStatement(sql);
				// ps.setInt(1, type);
				// ps.setInt(2, tempCount);
				// ps.setInt(3, type);
				rs = ps.executeQuery();
				Question ques = new Question();
				if (rs.next()) {
					ques.setId(rs.getInt(1));
					ques.setType(1);
					ques.setQues(rs.getString(4));
					ques.setKeyA(rs.getString(5));
					ques.setKeyB(rs.getString(6));
					ques.setKeyC(rs.getString(7));
					ques.setKeyD(rs.getString(8));
					ques.setAnswer(rs.getString(9));
					al.add(ques);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);

		}
		return al;

	}

	/**
	 * 获得对应课程对应题型的数量
	 * @param type
	 * @param course
	 * @return
	 */
	public int getCount(int type, String course)// 得到数据库中题目数量
	{
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = db.getConnection();
			String sql = "select count(*) from Question where qtype=? and course=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, type);
			ps.setString(2, course);
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

	public int getCount()// 得到数据库中题目数量
	{
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = db.getConnection();
			String sql = "select count(*) from Question";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
			return count;
		}

	}

	public Question getQuestionById(int Qid) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Question ques = null;
		try {
			conn = db.getConnection();
			String sql = "Select * from Question where Qid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Qid);
			rs = ps.executeQuery();
			if (rs.next()) {
				ques = new Question();
				ques.setId(Qid);
				ques.setType(rs.getInt("QTYPE"));
				ques.setCourse(rs.getString("COURSE"));
				ques.setQues(rs.getString("QUES"));
				ques.setKeyA(rs.getString("KEYA"));
				ques.setKeyB(rs.getString("KEYB"));
				ques.setKeyC(rs.getString("KEYC"));
				ques.setKeyD(rs.getString("KEYD"));
				ques.setAnswer(rs.getString("ANSWER"));
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			db.CloseDB(conn, ps, rs);
			return ques;
		}

	}

	/**
	 * sql server分页
	 * @param pageSize
	 * @param current
	 * @return
	 */
	public ArrayList getAllQuestion(int pageSize, int current)// 得到指定页的试题目信息
	{
		Connection conn = db.getConnection();
		Statement sm = null;
		ResultSet rs = null;
		ArrayList al = new ArrayList();
		try {
			conn = db.getConnection();
//			String sql = "select top " + pageSize
//					+ " * from Question where Qid not in (select top "
//					+ pageSize * (current - 1)
//					+ "  Qid from Question) order by Qid";
			String sql =" SELECT * FROM "+
			         " (SELECT A.*, ROWNUM RN FROM"+
			           " (SELECT * FROM Question   ORDER BY QTYPE,COURSE ) A ) "
			            +" WHERE RN BETWEEN "+ (pageSize*current-pageSize+1) +" AND "+ pageSize*current  ;
			sm = conn.createStatement();
			rs = sm.executeQuery(sql);
			while (rs.next()) {
				Question question = new Question();
				question.setId(rs.getInt("QID"));
				question.setType(rs.getInt("QTYPE"));
				question.setCourse(rs.getString("COURSE"));
				question.setQues(rs.getString("QUES"));
				question.setKeyA(rs.getString("KEYA"));
				question.setKeyB(rs.getString("KEYB"));
				question.setKeyC(rs.getString("KEYC"));
				question.setKeyD(rs.getString("KEYD"));
				question.setAnswer(rs.getString("ANSWER"));
				al.add(question);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, sm, rs);
			return al;
		}
	}

	public boolean insertQuestioin(Question ques)// 添加试题信息
	{
		boolean success = false;
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "insert into Question(qid,qtype,course,ques,keyA,keyB,keyC,keyD,answer) values(seq_question.nextval,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ques.getType());
			ps.setString(2, ques.getCourse());
			ps.setString(3, ques.getQues());
			ps.setString(4, ques.getKeyA());
			ps.setString(5, ques.getKeyB());
			ps.setString(6, ques.getKeyC());
			ps.setString(7, ques.getKeyD());
			ps.setString(8, ques.getAnswer());
			count = ps.executeUpdate();
			if (count != 0) {
				success = true;

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.CloseDB(conn, ps, rs);
			return success;
		}
	}

	public boolean updateQuestion(Question ques)// 修改试题信息
	{
		boolean success = false;
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "update Question set qtype=?,course=?,ques=?,keyA=?,keyB=?,keyC=?,keyD=?,answer=? where Qid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ques.getType());
			ps.setString(2, ques.getCourse());
			ps.setString(3, ques.getQues());
			ps.setString(4, ques.getKeyA());
			ps.setString(5, ques.getKeyB());
			ps.setString(6, ques.getKeyC());
			ps.setString(7, ques.getKeyD());
			ps.setString(8, ques.getAnswer());
			ps.setInt(9, ques.getId());
			// System.out.println(sql);
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

	public boolean deleteTest(int Qid)// 删除试题信息
	{
		boolean flag = false;
		int count = 0;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "delete from Question where Qid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Qid);
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

	public ArrayList getCourse()// 获取科目
	{
		ArrayList al = new ArrayList();
		Connection conn = db.getConnection();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			String sql = "select distinct course from Question";
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

}
