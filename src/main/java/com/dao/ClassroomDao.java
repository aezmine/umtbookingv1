// ClassroomDao.java
package com.dao;

import com.model.Classroom;
import com.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ClassroomDao {

    public List<Classroom> getAllClassrooms() {
        List<Classroom> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM classrooms";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Classroom room = new Classroom();
                room.setClassroom_id(rs.getInt("classroom_id"));
                room.setName(rs.getString("name"));
                room.setLocation(rs.getString("location"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addClassroom(Classroom room) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO classrooms(name, location, capacity, status) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, room.getName());
            stmt.setString(2, room.getLocation());
            stmt.setInt(3, room.getCapacity());
            stmt.setString(4, room.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateClassroom(Classroom room) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE classrooms SET name=?, location=?, capacity=?, status=? WHERE classroom_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, room.getName());
            stmt.setString(2, room.getLocation());
            stmt.setInt(3, room.getCapacity());
            stmt.setString(4, room.getStatus());
            stmt.setInt(5, room.getClassroom_id());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteClassroom(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM classrooms WHERE classroom_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Classroom getClassroomById(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM classrooms WHERE classroom_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Classroom room = new Classroom();
                room.setClassroom_id(rs.getInt("classroom_id"));
                room.setName(rs.getString("name"));
                room.setLocation(rs.getString("location"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
} 
