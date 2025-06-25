package com.controller;

import com.dao.BookingDao;
import com.model.Booking;
import com.model.Classroom;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingDao bookingDao;

    @Override
    public void init() {
        bookingDao = new BookingDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("listUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            List<Booking> list = bookingDao.getBookingsByUserId(userId);
            request.setAttribute("bookingList", list);
//            RequestDispatcher rd = request.getRequestDispatcher("dashboardBookingUser.jsp");
RequestDispatcher rd = request.getRequestDispatcher("dashboardBookingUser.jsp");
            rd.forward(request, response);
        } else if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));
            bookingDao.cancelBooking(bookingId);
            response.sendRedirect("BookingServlet?action=listUser&user_id=" + userId);
        } 
//        else if ("showCreateForm".equals(action)) {
//            RequestDispatcher rd = request.getRequestDispatcher("BookingForm.jsp");
//            rd.forward(request, response);
//            
//        }
        else if ("showCreateForm".equals(action)) {
    List<Classroom> classrooms = bookingDao.getAllClassroomsForForm();
    request.setAttribute("classrooms", classrooms);

    RequestDispatcher rd = request.getRequestDispatcher("BookingForm.jsp");
    rd.forward(request, response);
}
        
        else if ("listAll".equals(action)) {
            List<Booking> list = bookingDao.getAllBookings();
            request.setAttribute("bookingList", list);
            RequestDispatcher rd = request.getRequestDispatcher("dashboardBookingAdmin.jsp");
            rd.forward(request, response);
        }
        else if ("editForm".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            Booking booking = bookingDao.getBookingById(bookingId);
            request.setAttribute("booking", booking);
            RequestDispatcher rd = request.getRequestDispatcher("editBookingForm.jsp");
            rd.forward(request, response);
        }else if ("listHof".equals(action)) {
            List<Booking> list = bookingDao.getPendingBookings();
            request.setAttribute("bookingList", list);
            RequestDispatcher rd = request.getRequestDispatcher("dashboardBookingHof.jsp");
            rd.forward(request, response);
        }

        else if ("approve".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            bookingDao.updateStatus(bookingId, "approved");
            response.sendRedirect("BookingServlet?action=listHof");
        }

        else if ("reject".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            bookingDao.updateStatus(bookingId, "rejected");
            response.sendRedirect("BookingServlet?action=listHof");
        }else if ("report".equals(action)) {
            List<Booking> list = bookingDao.getAllBookings();
            request.setAttribute("bookingList", list);
            RequestDispatcher rd = request.getRequestDispatcher("reportAdmin.jsp");
            rd.forward(request, response);
        }else if ("reportSummary".equals(action)) {
            int total = bookingDao.countAll();
            int approved = bookingDao.countByStatus("approved");
            int rejected = bookingDao.countByStatus("rejected");
            int pending = bookingDao.countByStatus("pending");

            request.setAttribute("total", total);
            request.setAttribute("approved", approved);
            request.setAttribute("rejected", rejected);
            request.setAttribute("pending", pending);

            RequestDispatcher rd = request.getRequestDispatcher("reportSummary.jsp");
            rd.forward(request, response);
        }else if ("reportChart".equals(action)) {
            int approved = bookingDao.countByStatus("approved");
            int rejected = bookingDao.countByStatus("rejected");
            int pending = bookingDao.countByStatus("pending");

            request.setAttribute("approved", approved);
            request.setAttribute("rejected", rejected);
            request.setAttribute("pending", pending);

            RequestDispatcher rd = request.getRequestDispatcher("reportChart.jsp");
            rd.forward(request, response);
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//
//        if ("create".equals(action)) {
//            Booking b = new Booking();
//            b.setUser_id(Integer.parseInt(request.getParameter("user_id")));
//            b.setClassroom_id(Integer.parseInt(request.getParameter("classroom_id")));
//            b.setBooking_date(Date.valueOf(request.getParameter("booking_date")));
//            
////            b.setStart_time(Time.valueOf(request.getParameter("start_time")));
////            b.setEnd_time(Time.valueOf(request.getParameter("end_time")));
//            String start = request.getParameter("start_time") + ":00";
//            String end = request.getParameter("end_time") + ":00";
//            b.setStart_time(Time.valueOf(start));
//            b.setEnd_time(Time.valueOf(end));
//
//            
//            b.setPurpose(request.getParameter("purpose"));
//            b.setStatus("pending");
//
//            bookingDao.createBooking(b);
//            response.sendRedirect("BookingServlet?action=listUser&user_id=" + request.getParameter("user_id"));
//        }else if ("update".equals(action)) {
//    Booking b = new Booking();
//    b.setBooking_id(Integer.parseInt(request.getParameter("booking_id")));
//    b.setClassroom_id(Integer.parseInt(request.getParameter("classroom_id")));
//    b.setBooking_date(Date.valueOf(request.getParameter("booking_date")));
//    b.setStart_time(Time.valueOf(request.getParameter("start_time") + ":00"));
//    b.setEnd_time(Time.valueOf(request.getParameter("end_time") + ":00"));
//    b.setPurpose(request.getParameter("purpose"));
//    b.setStatus(request.getParameter("status"));
//
//    bookingDao.updateBooking(b);
//    response.sendRedirect("BookingServlet?action=listAll");
//}
//
//    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");

    if ("create".equals(action)) {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int classroomId = Integer.parseInt(request.getParameter("classroom_id"));
        Date date = Date.valueOf(request.getParameter("booking_date"));
        Time start = Time.valueOf(request.getParameter("start_time") + ":00");
        Time end = Time.valueOf(request.getParameter("end_time") + ":00");

        // ✅ Check conflict
        boolean hasConflict = bookingDao.isBookingConflict(classroomId, date, start, end);

        if (hasConflict) {
            // ⚠️ Conflict detected, return to form with error
            request.setAttribute("error", "⚠️ Classroom is already booked for the selected time.");
            List<Classroom> classrooms = bookingDao.getAllClassroomsForForm(); // refill dropdown
            request.setAttribute("classrooms", classrooms);
            RequestDispatcher rd = request.getRequestDispatcher("BookingForm.jsp");
            rd.forward(request, response);
            return;
        }

        // ✅ No conflict — proceed with booking
        Booking b = new Booking();
        b.setUser_id(userId);
        b.setClassroom_id(classroomId);
        b.setBooking_date(date);
        b.setStart_time(start);
        b.setEnd_time(end);
        b.setPurpose(request.getParameter("purpose"));
        b.setStatus("pending");

        bookingDao.createBooking(b);
        response.sendRedirect("BookingServlet?action=listUser&user_id=" + userId);
    }

    else if ("update".equals(action)) {
        Booking b = new Booking();
        b.setBooking_id(Integer.parseInt(request.getParameter("booking_id")));
        b.setClassroom_id(Integer.parseInt(request.getParameter("classroom_id")));
        b.setBooking_date(Date.valueOf(request.getParameter("booking_date")));
        b.setStart_time(Time.valueOf(request.getParameter("start_time") + ":00"));
        b.setEnd_time(Time.valueOf(request.getParameter("end_time") + ":00"));
        b.setPurpose(request.getParameter("purpose"));
        b.setStatus(request.getParameter("status"));

        bookingDao.updateBooking(b);
        response.sendRedirect("BookingServlet?action=listAll");
    }else if ("filterClassrooms".equals(action)) {
    String bookingDate = request.getParameter("booking_date");
    String startTime = request.getParameter("start_time");
    String endTime = request.getParameter("end_time");

    // Call DAO to get available classrooms
    List<Classroom> availableRooms = bookingDao.getAvailableClassrooms(bookingDate, startTime, endTime);

    // Set attributes and forward back to booking page
    request.setAttribute("classrooms", availableRooms);
    request.setAttribute("booking_date", bookingDate);
    request.setAttribute("start_time", startTime);
    request.setAttribute("end_time", endTime);
    request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
}

}
}
