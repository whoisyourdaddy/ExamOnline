package com.xurui.util;
import java.sql.*;

public class UserFlagUtil {
   public DBAccess db = new DBAccess();
   public int getFlag(String Uid,String course,String test_time)//得到交卷信息
   {
	   int flag=2;//2为数据库存中无记录
	   Connection conn = db.getConnection();
	   PreparedStatement ps = null;
	   ResultSet rs = null;
	   try{
		   String sql = "select flag from userflag where userid=? and course=? and test_time=?";
		   ps = conn.prepareStatement(sql);
		   ps.setString(1, Uid);
		   ps.setString(2, course);
		   ps.setString(3, test_time);
		   rs = ps.executeQuery();
		   if(rs.next())
		   {
			   flag = rs.getInt(1);
			   
		   }
		   
	   }catch(Exception e)
	   {
		   e.printStackTrace();
		   
	   }finally
	   {
		   db.CloseDB(conn, ps, rs);
		   return flag;
		   
	   }
   }
   
   public boolean setFlag(String Uid,String course,String test_time)//设置交卷信息
   {
	   boolean flag=false;
	   Connection conn = db.getConnection();
	   PreparedStatement ps = null;
	   ResultSet rs = null;
	   String sql="";
	   try{
		   if(this.getFlag(Uid, course,test_time)!=2)
		   {
			   sql = "update userflag set flag=1 where userid=? and course=? and test_time=?";
		   }else
		   {
		    sql = "insert into userflag(userid,course,test_time,flag) values(?,?,?,1)";
		   }
		   ps = conn.prepareStatement(sql);
		   ps.setString(1, Uid);
		   ps.setString(2, course);
		   ps.setString(3, test_time);
		   int i = ps.executeUpdate();
		   if(i>0)
		   {
			   flag = true;
			   
		   }
		   
	   }catch(Exception e)
	   {
		   e.printStackTrace();
		   
	   }finally
	   {
		   db.CloseDB(conn, ps, rs);
		   return flag;
		   
	   }
   }
	 
}
