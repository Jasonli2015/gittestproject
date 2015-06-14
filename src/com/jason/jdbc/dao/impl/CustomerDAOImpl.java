package com.jason.jdbc.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jason.jdbc.dao.CustomerDAO;
import com.jason.jdbc.dto.CustomerDTO;

public class CustomerDAOImpl implements CustomerDAO {
	
	//JDBC driver name and dtabase URL by MySQL
	/*static final String JDBC_DEIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/test";
	
	//Database credentials	
	static final String USER = "root";
	static final String PWD = "root";*/
	
	//JDBC driver name and dtabase URL by Oracle
	static final String JDBC_DEIVER = "oracle.jdbc.driver.OracleDriver";
	static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	
	//Database credentials	
	static final String USER = "sys as sysdba";
	static final String PWD = "Jason2015";

	@Override
	public ArrayList<CustomerDTO> queryCustomer() {
		 
		Connection conn = null;		
		PreparedStatement pstmt = null;			
		ResultSet rs = null;
		String sql = "";
		
		ArrayList<CustomerDTO> list = new ArrayList<CustomerDTO>();
		
		try {
			//1.Register JDBC driver
			//初始化驱动程序，打开与数据库的通信通道
			Class.forName(JDBC_DEIVER);
			
			//2.Open a connection
			//使用DriverManager.getConnection()方法来创建一个Connection对象，它代表一个连接的数据库
			conn = DriverManager.getConnection(DB_URL, USER, PWD);
			
			//3.Execute a query
			//使用一个对象类型PreparedStatement构建，并提交一个SQL语句到数据库
			/*sql = "select custname,sex,DATE_FORMAT(birth,'%Y~%m~%d' ) birth,address,zip,phone,email,password "
					+ "from customer cust,(select address ad,count(*) adcount from customer group by address) cust2 "+ 
					"where cust.address = cust2.ad and cust2.adcount > ? "; */	
			
			sql = "select custname,sex,to_char(birth,'YYYY-MM-DD') birth,address,zip,phone,email,password "
					+ "from customer cust,(select address ad,count(*) adcount from customer group by address) cust2 "+ 
					"where cust.address = cust2.ad and cust2.adcount > ? "; 
			
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,"2");
			rs = pstmt.executeQuery();				
			
			//4.Extract data from result set			
			while (rs.next()) {
				CustomerDTO dto = new CustomerDTO();
				dto.setCustname(rs.getString("custname"));
				dto.setSex(rs.getString("sex"));
				dto.setBirth(rs.getString("birth"));
				dto.setAddress(rs.getString("address"));
				dto.setZip(rs.getString("zip"));
				dto.setPhone(rs.getString("phone"));
				dto.setPassword(rs.getString("password"));
				list.add(dto);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.Clean-up environment
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if (conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}

	@Override
	public boolean insertCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

}
