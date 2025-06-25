//package com.util;
//
//import java.sql.DriverManager;
//import java.sql.Connection;
//import java.sql.*;
//
///**
// * @author VICTUS
// */
//public class DBConnection {
//    private static final String USERNAME = "root";
//    private static final String PASSWORD = "admin";
//    private static final String URL = "jdbc:mysql://localhost:3306/db001";
//    
//    
//    
//    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
//    
////    private static final String USERNAME = System.getenv("DB_USER"); 
////    private static final String PASSWORD = System.getenv("DB_PASS"); 
////    private static final String URL = System.getenv("DB_URL"); 
//    
//    private static Connection connection = null;
//    
//    public static Connection getConnection() {
//        if (connection != null) {
//            try {
//                if (!connection.isClosed()) {
//                    return connection;
//                }
//            } catch (SQLException e) {
//                System.err.println("Connection check failed: " + e.getMessage());
//            }
//        }
//        
//        try {
//            Class.forName(DRIVER);
//            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
//            System.out.println("Database connected successfully");
//        } catch (ClassNotFoundException e) {
//            System.err.println("MySQL Driver not found: " + e.getMessage());
//        } catch (SQLException e) {
//            System.err.println("Connection failed: " + e.getMessage());
//        }
//        
//        return connection;
//    }
//    
//    public static void closeConnection() {
//        if (connection != null) {
//            try {
//                connection.close();
//                connection = null;
//            } catch (SQLException e) {
//                System.err.println("Error closing connection: " + e.getMessage());
//            }
//        }
//    }
//}
package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author izzat
 */
public class DBConnection {

    // 🔧 Hardcoded database connection info
//    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/masakork"; // change to your DB
//    private static final String JDBC_USERNAME = "root"; // change to your DB username
//    private static final String JDBC_PASSWORD = "admin"; // change to your DB password
//    
    private static final String JDBC_URL = "jdbc:mysql://mysql.railway.internal:3306/db001"; // change to your DB
    private static final String JDBC_USERNAME = "root"; // change to your DB username
    private static final String JDBC_PASSWORD = "CPqjlqvaroxjRNQlJfENZCGLxLtABOOg"; // change to your DB password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC driver
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }
}