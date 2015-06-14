package com.jason.jdbc.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jason.jdbc.dto.CustomerDTO;

public class Test {
	
	static Connection conn = null;		
	static PreparedStatement pstmt = null;			
	static ResultSet rs = null;
	
	//JDBC driver name and dtabase URL by Oracle
	static final String JDBC_DEIVER = "oracle.jdbc.driver.OracleDriver";
	static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	
	//Database credentials	
	static final String USER = "sys as sysdba";
	static final String PWD = "Jason2015";
	
	static String sql = "";
	
	public static void quertCoustomer(){
		
		sql = "select custname,sex,to_char(birth,'YYYY-MM-DD') birth,address,zip,phone,email,password "
		+ "from customer cust,(select address ad,count(*) adcount from customer group by address) cust2 "+ 
		"where cust.address = cust2.ad and cust2.adcount > ? "; 
		
		Object[] params = {"2"};
		
		ArrayList<CustomerDTO> list = new ArrayList<CustomerDTO>();
		
		try {
			conn = JDBCUtils.getConncet(JDBC_DEIVER,DB_URL,USER,PWD);
			
			pstmt = conn.prepareStatement(sql);	
			
			rs = JDBCUtils.queryOpertion(pstmt,sql,params);
			
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
			
			for (int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i).getCustname());
			}
				
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtils.closeAll(rs, pstmt, conn);
		}
	}
	
	public static boolean updateCustomer(){
		
		boolean falg = false;
		
		sql = "update customer set email = ? where custname = ?";
		
		Object[] params = {"674478903@qq.com","jason"};
		
		try {
			conn = JDBCUtils.getConncet(JDBC_DEIVER,DB_URL,USER,PWD);
			
			pstmt = conn.prepareStatement(sql);	
			
			JDBCUtils.manipulationOpertion(pstmt, sql, params);
			
			falg = true;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtils.closeAll(rs, pstmt, conn);
		}
		
		return falg;
	}
	
	public static void main(String[] args) {
		
		System.out.println(updateCustomer());		
		
	}

}
