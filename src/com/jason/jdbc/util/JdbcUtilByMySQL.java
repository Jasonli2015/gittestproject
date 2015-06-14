package com.jason.jdbc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public final class JdbcUtilByMySQL { 
	
	//拒绝创建一个实例
	private JdbcUtilByMySQL(){}
	
	//调用该类时先注册驱动
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//单例模式：初始化一个域并延迟加载
	private static JdbcUtilByMySQL instance = null;
	//获得实例
	public static JdbcUtilByMySQL getInstance(){
		if (instance == null) {
			synchronized (JdbcUtilByMySQL.class) {
				if (instance == null) {
					instance = new JdbcUtilByMySQL();
				}
			}
		}
		return instance;
	}
	
	//获得连接
	public static Connection getConnection(String url,String user, String password) throws SQLException{
		return DriverManager.getConnection(url, user, password);
	}
	
	//释放资源
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
