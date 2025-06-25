<%@page import com.model.Booking%>
<%@page import java.util.List%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
</head>
<body>
    <h2>My Classroom Bookings</h2>

    <table border="1">
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Classroom ID</th>
                <th>Date</th>
                <th>Time</th>
                <th>Purpose</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                if (bookings == null || bookings.isEmpty()) { 
            %>
                <tr>
                    <td colspan="7">You have no bookings yet.</td>
                </tr>
            <% } else {
                for (Booking booking : bookings) { 
            %>
                <tr>
                    <td><%= booking.getBooking_id() %></td>
                    <td><%= booking.getClassroom_id() %></td>
                    <td><%= booking.getBooking_date() %></td>
                    <td><%= booking.getStart_time() %> - <%= booking.getEnd_time() %></td>
                    <td><%= booking.getPurpose() %></td>
                    <td><%= booking.getStatus() %></td>
                    <td>
                        <% if ("pending".equals(booking.getStatus())) { %>
                            <form action="BookingServlet" method="GET" style="display:inline;">
                                <input type="hidden" name="action" value="cancelBooking">
                                <input type="hidden" name="id" value="<%= booking.getBooking_id() %>">
                                <input type="submit" value="Cancel">
                            </form>
                        <% } else { %>
                            No actions
                        <% } %>
                    </td>
                </tr>
            <% } } %>
        </tbody>
    </table>
    <a href="userDashboard.jsp">Back to Dashboard</a>
</body>
</html>