package com.jason.extjs.gridPanel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jason.extjs.gridPanel.entity.DeptModel;

public class DeptAndEmpProcessorServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");  
		resp.setCharacterEncoding("UTF-8"); 
				
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/extjs","root","root");
			pstmt = conn.prepareStatement("select * from dept");
			rs = pstmt.executeQuery();
			List<DeptModel> list = new ArrayList<DeptModel>();
			while (rs.next()) {
				DeptModel model = new DeptModel();
				model.setDeptno(rs.getInt("deptno"));
				model.setDeptname(rs.getString("deptname"));
				model.setParentno(rs.getInt("parentno"));
				list.add(model);
			}
			String jsonTreeModelString = new TreeModel().getJsonTreeModelString(list);
			PrintWriter out = resp.getWriter();
			out.println(jsonTreeModelString);
			out.flush();
			out.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {

				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}

				if (conn != null) {
					conn.close();
					conn = null;
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		}
		
	}
	
}
