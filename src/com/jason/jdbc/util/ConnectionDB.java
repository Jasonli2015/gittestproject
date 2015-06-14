package com.jason.jdbc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConnectionDB {
	/**
	 * 数据库驱动类名称 
     */  
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";  
  
    /** 
     * 连接字符串 
     */  
    private static final String URLSTR = "jdbc:oracle:thin:@localhost:1521:orcl";  
  
    /** 
     * 用户名 
     */  
    private static final String USERNAME = "sys as sysdba";  
  
    /** 
     * 密码 
     */  
    private static final String USERPASSWORD = "Jason2015";  
  
    /** 
     * 创建数据库连接类 
     */  
    private Connection connection = null;  
  
    private PreparedStatement preparedStatement = null;  
  
    /** 
     * 创建结果集对象 
     */  
    private ResultSet resultSet = null;  
  
    static {  
        try {  
            // 加载数据库驱动程序  
            Class.forName(DRIVER);  
        } catch (ClassNotFoundException e) {  
            System.out.println("加载驱动错误");  
            System.out.println(e.getMessage());  
        }  
    }  
  
    /** 
     * 建立数据库连接 
     *  
     * @return 
     */  
    public Connection getConnection() {  
        try {  
            // 获取连接  
            connection = DriverManager.getConnection(URLSTR, USERNAME, USERPASSWORD);  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        }  
        return connection;  
    }  
  
    public int executeUpdate(String sql, Object[] params) {  
        int affectedLine = 0;  
        try {  
            connection = this.getConnection();  
            preparedStatement = connection.prepareStatement(sql);  
            for (int i = 0; i < params.length; i++) {  
                preparedStatement.setObject(i + 1, params[i]);  
            }  
  
            affectedLine = preparedStatement.executeUpdate();  
  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        } finally {  
            closeAll();  
        }  
        return affectedLine;  
    }        
  
    private ResultSet executeQueryRS(String sql, Object[] params) {  
        try {  
            connection = this.getConnection();  
            preparedStatement = connection.prepareStatement(sql);  
            for (int i = 0; i < params.length; i++) {  
                preparedStatement.setObject(i + 1, params[i]);  
            }  
  
            resultSet = preparedStatement.executeQuery();  
  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        }   
          
        return resultSet;  
    }  
      
    /** 
     * 获取结果集，并将结果放在List中 
     * @param sql SQL语句 
     * @return List结果集 
     */  
    public List<Object> excuteQuery(String sql, Object[] params) {   
        ResultSet rs = executeQueryRS(sql,params);  
        ResultSetMetaData rsmd = null;  
        int columnCount = 0;  
        try {  
            rsmd = rs.getMetaData();  
            columnCount = rsmd.getColumnCount();  
        } catch (SQLException e1) {  
            System.out.println(e1.getMessage());  
        }  
          
        List<Object> list = new ArrayList<Object>();  
          
        try {  
            while(rs.next()) {  
                Map<String, Object> map = new HashMap<String, Object>();  
                for(int i = 1; i <= columnCount; i++) {  
                    map.put(rsmd.getColumnLabel(i), rs.getObject(i));                 
                }  
                list.add(map);  
            }  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        } finally {  
            closeAll();  
        }  
          
        return list;  
    }  
  
    private void closeAll() {  
  
        if (resultSet != null) {  
            try {  
                resultSet.close();  
            } catch (SQLException e) {  
                System.out.println(e.getMessage());  
            }  
        }  
  
        if (preparedStatement != null) {  
            try {  
                preparedStatement.close();  
            } catch (SQLException e) {  
                System.out.println(e.getMessage());  
            }  
        }  
          
        if (connection != null) {  
            try {  
                connection.close();  
            } catch (SQLException e) {  
                System.out.println(e.getMessage());  
            }  
        }  
    }  
}
