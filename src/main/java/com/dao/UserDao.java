package com.dao;

import com.model.User;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
  
    

    public User login(String userId, String password) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE user_id=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUser_id(rs.getString("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setFaculty(rs.getString("faculty"));
                user.setPhonenumber(rs.getString("phonenumber"));
                user.setCreated_at(rs.getString("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateUser(User user) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET name=?, email=?, phonenumber=? WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhonenumber());
            stmt.setString(4, user.getUser_id());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateEmail(String userId, String email) {
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "UPDATE users SET email=? WHERE user_id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, userId);
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public void updatePhone(String userId, String phone) {
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "UPDATE users SET phonenumber=? WHERE user_id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, phone);
        stmt.setString(2, userId);
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public void updatePassword(String userId, String password) {
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "UPDATE users SET password=? WHERE user_id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, password);
        stmt.setString(2, userId);
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

//public boolean registerUser(User user) {
//    boolean success = false;
//    try (Connection conn = DBConnection.getConnection()) {
//        String sql = "INSERT INTO users (user_id, name, email, password, role, faculty, phonenumber) VALUES (?, ?, ?, ?, ?, ?, ?)";
//        PreparedStatement stmt = conn.prepareStatement(sql);
//        stmt.setString(1, user.getUser_id());
//        stmt.setString(2, user.getName());
//        stmt.setString(3, user.getEmail());
//        stmt.setString(4, user.getPassword());
//        stmt.setString(5, user.getRole());
//        stmt.setString(6, user.getFaculty());
//        stmt.setString(7, user.getPhonenumber());
//        stmt.executeUpdate();
//        success = true;
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    return success;
//}
//public boolean registerUser(User user) {
//    boolean success = false;
//    try (Connection conn = DBConnection.getConnection()) {
//        String sql = "INSERT INTO users (user_id, name, email, password, role, faculty, phonenumber) VALUES (?, ?, ?, ?, ?, ?, ?)";
//        PreparedStatement stmt = conn.prepareStatement(sql);
//        stmt.setString(1, user.getUser_id());
//        stmt.setString(2, user.getName());
//        stmt.setString(3, user.getEmail());
//        stmt.setString(4, user.getPassword());
//        stmt.setString(5, user.getRole());
//        stmt.setString(6, user.getFaculty());
//        stmt.setString(7, user.getPhonenumber());
//        int rowsInserted = stmt.executeUpdate();
//
//        if (rowsInserted > 0) {
//            System.out.println("User inserted successfully.");
//            success = true;
//        } else {
//            System.out.println("Insert failed. No rows affected.");
//        }
//
//    } catch (SQLIntegrityConstraintViolationException e) {
//        System.out.println("User ID already exists!");  // Better message
//    } catch (Exception e) {
//        e.printStackTrace();  // Print other exceptions
//    }
//    return success;
//}

public boolean registerUser(User user) {
    boolean success = false;

    try (Connection conn = DBConnection.getConnection()) {
        // 1. Check if user ID already exists
        String checkSql = "SELECT user_id FROM users WHERE user_id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, Integer.parseInt(user.getUser_id()));  // since user_id is int
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            // Duplicate user_id found
            System.out.println("User ID already exists: " + user.getUser_id());
            return false;
        }

        // 2. Insert new user
        String sql = "INSERT INTO users (user_id, name, email, password, role, faculty, phonenumber) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(user.getUser_id()));
        stmt.setString(2, user.getName());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getPassword());
        stmt.setString(5, user.getRole());
        stmt.setString(6, user.getFaculty());
        stmt.setString(7, user.getPhonenumber());

        stmt.executeUpdate();
        success = true;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}



public List<User> getAllUsers() {
    List<User> users = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT * FROM users";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            User user = new User();
            user.setUser_id(rs.getString("user_id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password")); // if needed
            user.setRole(rs.getString("role"));
            user.setFaculty(rs.getString("faculty"));
            user.setPhonenumber(rs.getString("phonenumber"));
            user.setCreated_at(rs.getString("created_at"));
            users.add(user);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return users;
}


}
