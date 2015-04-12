package com.jason.extjs;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DataServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");	
		
		String msg = "["+
	                     "{ text: '根下节点一[user图标]', leaf: true, iconCls: 'nodeicon' },"+
	                     "{ text: '根下节点二', leaf: true },"+
	                     "{ text: '根下节点三', leaf: false, children: ["+
	                         "{ text: '节点三子节点一', leaf: true },"+
	                         "{ text: '节点三子节点二', leaf: false, expanded: true, children: ["+
	                             "{ text: '节点三子节点二节点一', leaf: true },"+
	                             "{ text: '节点三子节点二节点二', leaf: true }"+
	                            "]"+
	                          "}"+
	                        "]"+
	                     "}"+
	                 "]";
		
		PrintWriter pw = resp.getWriter();
		pw.println(msg);
		pw.flush();
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");	
		
		String id = req.getParameter("id");
		String msg = null;
		if (id!=null&&id.trim().equals("1")) {
			msg = "{id:1,name:'张三',brithday:2001-01-01,height:178,sex:'0',discribe:'张三是一个.net软件工程师<br/>现在正在学习ExtJs。'}";
		} 
	
		PrintWriter pw = resp.getWriter();
		pw.println(msg);
		pw.flush();
		pw.close();
	}

}
