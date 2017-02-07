package com.xurui.util;

public class Common {
     public static String getSubString(String str,int i)//截取字附串
     {
    	 if(str.length()<=i)
    	 {
    		 return str; 
    	 }else
    	 {
    		 str = str.substring(0, i);
    		 return str+"...";
    	 }
    	 
     }
     public static String getType(int type)//得到类型字附串
     {
    	  String str_type = "";
          if(type==1)
          {
            str_type="单择题";
          }else if(type==2)
          {
            str_type="多选题";
          }else if(type==3)
          {
            str_type="判断题";
          }else if(type==4)
          {
            str_type="简答题";
          }else if(type==5)
          {
            str_type="编程题";
          }
    	 return str_type;
     }
     
     public static  String getTypeCount(int count){
    	 String upper ="一";
    	   if(count ==1){
    		  
    	   }else  if(count ==2){
    		   upper ="二";
     	   }else  if(count ==3){
    		   upper ="三";
     	   }else  if(count ==4){
    		   upper ="四";
     	   }else  if(count ==5){
    		   upper ="五";
     	   }
    	   return  upper;
     }
}
