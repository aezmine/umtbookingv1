package com.dao;

import com.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConnection; 

import com.dao.UserDao;
import com.model.Classroom;
import com.model.User;

public class BookingDao {
    
    public List<Classroom> getAllClassrooms() {
    List<Classroom> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT classroom_id, name FROM classrooms";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Classroom c = new Classroom();
            c.setClassroom_id(rs.getInt("classroom_id"));
            c.setName(rs.getString("name"));
            list.add(c);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    
    public List<Classroom> getBookedClassrooms(String bookingDate, String startTime, String endTime) {
    List<Classroom> booked = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT DISTINCT c.classroom_id, c.name " +
                     "FROM classrooms c " +
                     "JOIN bookings b ON c.classroom_id = b.classroom_id " +
                     "WHERE b.booking_date = ? AND (b.start_time < ? AND b.end_time > ?)";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, bookingDate);
        stmt.setString(2, endTime);   // booking’s end time
        stmt.setString(3, startTime); // booking’s start time

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Classroom c = new Classroom();
            c.setClassroom_id(rs.getInt("classroom_id"));
            c.setName(rs.getString("name"));
            booked.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return booked;
}

    
    
    // tk guna
        public List<Classroom> getAvailableClassrooms(String bookingDate, String startTime, String endTime) {
    List<Classroom> available = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT * FROM classrooms WHERE classroom_id NOT IN (" +
                     "SELECT classroom_id FROM bookings WHERE booking_date = ? AND " +
                     "(start_time < ? AND end_time > ?))";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, bookingDate);
        stmt.setString(2, endTime);   // end time in the form
        stmt.setString(3, startTime); // start time in the form

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Classroom c = new Classroom();
            c.setClassroom_id(rs.getInt("classroom_id"));
            c.setName(rs.getString("name"));
            // Set other classroom details if needed
            available.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return available;
}

    
    public boolean isBookingConflict(int classroom_id, Date booking_date, Time start_time, Time end_time) {
    boolean conflict = false;
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM bookings WHERE classroom_id = ? AND booking_date = ? " +
                     "AND (start_time < ? AND end_time > ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, classroom_id);
        ps.setDate(2, booking_date);
        ps.setTime(3, end_time);   // end of new booking > existing start_time
        ps.setTime(4, start_time); // start of new booking < existing end_time
        ResultSet rs = ps.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            conflict = true;
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return conflict;
}


//    public List<Booking> getBookingsByUserId(int userId) {
//        List<Booking> list = new ArrayList<>();
//        try {
//            Connection con = DBConnection.getConnection();
//            String sql = "SELECT * FROM bookings WHERE user_id = ?";
//            PreparedStatement ps = con.prepareStatement(sql);
//            ps.setInt(1, userId);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Booking b = new Booking();
//                b.setBooking_id(rs.getInt("booking_id"));
//                b.setUser_id(rs.getInt("user_id"));
//                b.setClassroom_id(rs.getInt("classroom_id"));
//                b.setBooking_date(rs.getDate("booking_date"));
//                b.setStart_time(rs.getTime("start_time"));
//                b.setEnd_time(rs.getTime("end_time"));
//                b.setPurpose(rs.getString("purpose"));
//                b.setStatus(rs.getString("status"));
//                b.setCreated_at(rs.getString("created_at"));
//                list.add(b);
//            }
//            con.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    public List<Booking> getBookingsByUserId(int userId) {
    List<Booking> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();

        // Join with classrooms table to get the classroom name
        String sql = "SELECT b.*, c.name AS classroom_name FROM bookings b " +
                     "JOIN classrooms c ON b.classroom_id = c.classroom_id " +
                     "WHERE b.user_id = ?";
                     
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Booking b = new Booking();
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setClassroom_id(rs.getInt("classroom_id"));
            b.setBooking_date(rs.getDate("booking_date"));
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setPurpose(rs.getString("purpose"));
            b.setStatus(rs.getString("status"));
            b.setCreated_at(rs.getString("created_at"));

            // ✅ Set the classroom name from joined result
            b.setClassroom_name(rs.getString("classroom_name"));

            list.add(b);
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public void cancelBooking(int bookingId) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM bookings WHERE booking_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void createBooking(Booking b) {
    try {
        Connection con = DBConnection.getConnection();
        String sql = "INSERT INTO bookings (user_id, classroom_id, booking_date, start_time, end_time, purpose, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, b.getUser_id());
        ps.setInt(2, b.getClassroom_id());
        ps.setDate(3, b.getBooking_date());
        ps.setTime(4, b.getStart_time());
        ps.setTime(5, b.getEnd_time());
        ps.setString(6, b.getPurpose());
        ps.setString(7, b.getStatus());
        ps.executeUpdate();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    public List<Booking> getAllBookings() {
    List<Booking> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM bookings";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Booking b = new Booking();
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setClassroom_id(rs.getInt("classroom_id"));
            b.setBooking_date(rs.getDate("booking_date"));
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setPurpose(rs.getString("purpose"));
            b.setStatus(rs.getString("status"));
            b.setCreated_at(rs.getString("created_at"));
            list.add(b);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public Booking getBookingById(int bookingId) {
    Booking b = new Booking();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, bookingId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setClassroom_id(rs.getInt("classroom_id"));
            b.setBooking_date(rs.getDate("booking_date"));
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setPurpose(rs.getString("purpose"));
            b.setStatus(rs.getString("status"));
            b.setCreated_at(rs.getString("created_at"));
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return b;
}

public void updateBooking(Booking b) {
    try {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE bookings SET classroom_id=?, booking_date=?, start_time=?, end_time=?, purpose=?, status=? WHERE booking_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, b.getClassroom_id());
        ps.setDate(2, b.getBooking_date());
        ps.setTime(3, b.getStart_time());
        ps.setTime(4, b.getEnd_time());
        ps.setString(5, b.getPurpose());
        ps.setString(6, b.getStatus());
        ps.setInt(7, b.getBooking_id());
        ps.executeUpdate();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public List<Booking> getPendingBookings() {
    List<Booking> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM bookings WHERE status = 'pending'";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Booking b = new Booking();
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setClassroom_id(rs.getInt("classroom_id"));
            b.setBooking_date(rs.getDate("booking_date"));
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setPurpose(rs.getString("purpose"));
            b.setStatus(rs.getString("status"));
            b.setCreated_at(rs.getString("created_at"));
            list.add(b);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public void updateStatus(int bookingId, String status) {
    try {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, bookingId);
        ps.executeUpdate();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public int countAll() {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM bookings");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

public int countByStatus(String status) {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM bookings WHERE status = ?");
        ps.setString(1, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

public List<Classroom> getAllClassroomsForForm() {
    List<Classroom> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT classroom_id, name FROM classrooms"; // match your column names
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Classroom c = new Classroom();
            c.setClassroom_id(rs.getInt("classroom_id"));  // this sets classroomId
            c.setName(rs.getString("name"));               // this sets name
            list.add(c);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



}
