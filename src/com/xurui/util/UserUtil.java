package com.xurui.util;

import java.sql.*;
import java.util.ArrayList;

import com.xurui.dormain.*;

public class UserUtil {
	DBAccess db = new DBAccess();
	public User getUser(String Uid)//根据id得到用户信息
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		User user = null;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="select * from UserInfo where userid=?";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, Uid);
			rs=ps.executeQuery();     // 执行sql语句
			
			if(rs.next())
			{
				user = new User();
				String id = rs.getString(1);
				int type = rs.getInt(2);
				String name = rs.getString(3);
				String sex = rs.getString(5);
				user.setId(id);
				user.setName(name);
				user.setType(type);
				user.setSex(sex);
			}
			else 
				user = null;
			
		}
		catch (Exception E) 
		{
			E.printStackTrace();
			
		}
		finally 
		{
			// 关闭连接，释放数据库资源：
			db.CloseDB(conn,ps,rs);
			return user;
		}
		
	}
	public boolean checkUser(String userName,String password,int type)//验证登陆信息，根据用户名、密码和用户类型
	{
		boolean flag = false;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="select * from UserInfo where userid=? and password=? and utype=?";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, userName);
			 ps.setString(2,password);
			 ps.setInt(3, type);
			rs=ps.executeQuery();     // 执行sql语句
			
			if(rs.next())
			{
              flag = true;
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
			return flag;
		}
		
	}
	public boolean checkUser(String userName,int type)//验证用户名判断用户是否存在；
	{
		boolean flag = false;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		conn = db.getConnection();
		
		try 
		{			
			String sql="select * from UserInfo where userid=? and utype=?";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, userName);
			 ps.setInt(2, type);
			 rs=ps.executeQuery();     // 执行sql语句
			
			if(rs.next())
			{
              flag = true;
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
			return flag;
		}
		
	}
	
	public boolean motifyUser(User user)//修改用户信息
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		boolean flag = false;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="update UserInfo set utype=?,name=?,sex=? where userid=?";
			 ps = conn.prepareStatement(sql);
			 ps.setInt(1, user.getType());
			 ps.setString(2, user.getName());
			 ps.setString(3, user.getSex());
			 ps.setString(4, user.getId());
			int i=ps.executeUpdate();     // 执行sql语句
			
			if(i!=0)
			{
              flag = true;
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
			return flag;
		}
		
	}
	public boolean insertUser(User user)//注册用户信息
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		boolean flag = false;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="insert into UserInfo(userid,utype,name,password,sex) values(?,?,?,?,?)";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, user.getId());
			 ps.setInt(2, user.getType());
			 ps.setString(3, user.getName());
			 ps.setString(4, user.getPassword());
			 ps.setString(5, user.getSex());
			int i=ps.executeUpdate();     // 执行sql语句
			
			if(i!=0)
			{
              flag = true;
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
		return flag;
		
	}
	public boolean motifyPassword(String Uid,String password)//修改密码
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		boolean flag = false;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="update UserInfo set password=? where userid=?";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, password);
			 ps.setString(2, Uid);
			int i=ps.executeUpdate();     // 执行sql语句
			
			if(i!=0)
			{
              flag = true;
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
			return flag;
		}
		
	}

	public ArrayList getAllUser(int pageSize,int current)//得到指定页的用户
	{
		ResultSet rs = null;
		 Statement sm = null;
		Connection conn = null;
		ArrayList al = new ArrayList();
		conn = db.getConnection();
		
		try 
		{
			String sql =" SELECT * FROM "+
         " (SELECT A.*, ROWNUM RN FROM"+
           " (SELECT * FROM UserInfo  where utype<>3 order by utype, userid desc) A ) "
            +" WHERE RN BETWEEN "+ (pageSize*current-pageSize+1) +" AND "+ pageSize*current  ;
					
			//String sql="select top "+pageSize+" * from UserInfo where utype<>3 and Uid not in (select top "+pageSize*(current-1)+"  Uid from UserInfo where utype<>3) order by Uid";
		    sm = conn.createStatement();
			rs = sm.executeQuery(sql);     // 执行sql语句
			while(rs.next())
			{
				User user = new User();
				user.setId(rs.getString(1));
				user.setType(rs.getInt(2));
				user.setName(rs.getString(3));
				user.setSex(rs.getString(5));
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
			db.CloseDB(conn,sm,rs);
			return al;
		}
		
	}
	
	public int getCount()//用户数量
	{
		ResultSet rs = null;
		Statement sm = null;
		Connection conn = null;
		conn = db.getConnection();
		int count = 0;
		
		try 
		{
			
			String sql="select count(*) from UserInfo where utype<>3";
			 sm = conn.createStatement();
			rs=sm.executeQuery(sql);     // 执行sql语句
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
			db.CloseDB(conn,sm,rs);
			return count;
		}
		
	}
	
	public boolean deleteUser(String Uid)//删除用户信息
	{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		boolean flag = false;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="delete from UserInfo where userid=?";
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, Uid);
			int i=ps.executeUpdate();     // 执行sql语句
			
			if(i!=0)
			{
              flag = true;
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
			return flag;
		}
		
	}
	
	
	public boolean check(String Uid)//验证用户编号
	{
		boolean flag = false;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		conn = db.getConnection();
		
		try 
		{
			
			String sql="select * from UserInfo where userid='"+Uid+"'";
			 ps = conn.prepareStatement(sql);
			rs=ps.executeQuery();     // 执行sql语句
			
			if(rs.next())
			{
              flag = true;
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
			return flag;
		}
		
	}
}
