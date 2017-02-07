package com.xurui.dormain;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.xurui.dormain.*;
import com.xurui.util.*;

public class Testd extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("");
		out.println("");
		out.println(" ");
		out.println(" ");
		out.print(" This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println(" ");
		out.println("");
		out.flush();
		out.close();
	}
}