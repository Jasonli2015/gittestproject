package com.jason.extjs;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ComboBoxServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");  
		resp.setCharacterEncoding("UTF-8"); 
		String jsonResult = "{data:[{id:1,name:'广州市'},{id:2,name:'深圳市'}]}";			
		PrintWriter out = resp.getWriter();
		out.println(jsonResult);
		out.flush();
		out.close();						
		return;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");  
		resp.setCharacterEncoding("UTF-8"); 
		String id = req.getParameter("id");
		String jsonResult = "";			
		if (id.equals("1")) {
			jsonResult = "{data:[{id:1,name:'天河区'},{id:2,name:'越秀区'},{id:3,name:'海珠区'}]}";			
		} else {
			jsonResult = "{data:[{id:1,name:'福田区'},{id:2,name:'罗湖区'},{id:3,name:'宝安区'}]}";
		}
		PrintWriter out = resp.getWriter();
		out.println(jsonResult);
		out.flush();
		out.close();						
		return;
	}

}
