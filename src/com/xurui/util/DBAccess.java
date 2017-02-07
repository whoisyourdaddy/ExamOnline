package com.xurui.util;

import java.sql.*;

public class DBAccess {
	private Connection conn = null; // 数据库连接对象
	private static String driverName = "oracle.jdbc.driver.OracleDriver";
	private static String url = "jdbc:oracle:thin:@localhost:1521:ORCL"; // ORCL为数据库名称，1521为连接数据库的默认端口
	private static String username = "exam_online"; // 用户名
	private static String password = "exam_online"; // 密码
	
	public static void main(String[] args) {
		new DBAccess().getConnection();
	}

	static {
		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	public Connection getConnection() {

		try {
			conn = DriverManager.getConnection(url,username,password); // 获得数据库连接
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public void CloseDB(Connection conn, Statement sm, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (sm != null) {
					sm.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

}
