package com.jason.jdbc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCUtils {
			
	static ResultSet rs = null;
	
	public static Connection getConncet(String driver, String url, String user, String password) throws ClassNotFoundException, SQLException{
				
		//1.Register JDBC driver
		//初始化驱动程序，打开与数据库的通信通道
		Class.forName(driver);
		//2.Open a connection
		//使用DriverManager.getConnection()方法来创建一个Connection对象，它代表一个连接的数据库
		return DriverManager.getConnection(url, user, password);				
		
	}
	
	//3.Execute a query
	//使用一个对象类型PreparedStatement构建，并提交一个select语句到数据库		
	public static ResultSet queryOpertion(PreparedStatement pstmt, String sql, Object[] params) {
		
		try {																
			for (int i = 0; i < params.length; i++) {
				pstmt.setObject(i + 1, params[i]);
			}
			rs = pstmt.executeQuery();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return rs;
	}
	
	//使用一个对象类型PreparedStatement构建，并提交一个insert、update或者delete语句到数据库	
	public static boolean manipulationOpertion (PreparedStatement pstmt, String sql, Object[] params) {  
        boolean flag = false;  
        try {   
            for (int i = 0; i < params.length; i++) {  
            	pstmt.setObject(i + 1, params[i]);  
            }  
            pstmt.executeUpdate();

        	flag = true;
        	
        } catch (SQLException e) {  
        	e.printStackTrace();
        }
        return flag;  
    }  
	
	//4.Clean-up environment
	//关闭连接
	public static void closeAll(ResultSet rs, PreparedStatement  pstmt, Connection conn){
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
}
