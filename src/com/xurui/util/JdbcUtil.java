package com.xurui.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 封装java连接数据库的公共类
 * 
 * @author Administrator
 *
 */
public class JdbcUtil {
	// public static String driverName; // 数据库驱动
	// public static String url; // 数据库连接(连接地址、端口、名称)
	// public static String user; // 用户名
	// public static String password; // 密码

	private static String driverName = "oracle.jdbc.driver.OracleDriver";
	private static String url = "jdbc:oracle:thin:@localhost:1521:ORCL"; // ORCL为数据库名称，1521为连接数据库的默认端口
	private static String user = "scott"; // 用户名
	private static String password = "tiger"; // 密码
	
	/**
	 * 读config.properties文件
	 */
	public static void init(){
		//driverName;
		//url;
		//user;
		//password;
	}

	/**
	 * 获得数据库连接
	 * 
	 * @return
	 */
	public static Connection getConnection() {
		init();
		// 数据库连接对象
		Connection conn = null;

		// 反射Oracle数据库驱动程序类
		try {
			Class.forName(driverName);
			// 获取数据库连接
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	/**
	 * 获得语句对象
	 * 
	 * @param rs
	 */
	public static PreparedStatement getPreparedStatement(Connection conn,
			String sql) {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ps;
	}

	/**
	 * 得到查询结果集
	 * @param pstmt
	 * @return
	 */
	public static ResultSet getResultSet(PreparedStatement pstmt) {
		ResultSet rs = null;
		try {
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(PreparedStatement ps) {
		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
