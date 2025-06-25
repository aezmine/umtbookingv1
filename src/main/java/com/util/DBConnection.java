package com.util;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.*;

/**
 * @author VICTUS
 */
public class DBConnection {
//    private static final String USERNAME = "root";
//    private static final String PASSWORD = "admin";
//    private static final String URL = "jdbc:mysql://localhost:3306/db001";
    
    
    
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    private static final String USERNAME = System.getenv("DB_USER"); 
    private static final String PASSWORD = System.getenv("DB_PASS"); 
    private static final String URL = System.getenv("DB_URL"); 
    
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    return connection;
                }
            } catch (SQLException e) {
                System.err.println("Connection check failed: " + e.getMessage());
            }
        }
        
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connected successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
        }
        
        return connection;
    }
    
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}