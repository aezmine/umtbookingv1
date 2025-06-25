<%@ page import="com.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("userLogin.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Booking History</title>
</head>
<body>
    <h2>? Your Booking Report</h2>
    <p>Welcome, <strong><%= user.getName() %></strong></p>

    <table border="1" cellpadding="8">
        <tr>
            <th>Booking ID</th>
            <th>Classroom</th>
            <th>Date</th>
            <th>Start - End</th>
            <th>Purpose</th>
            <th>Status</th>
        </tr>
        <c:forEach var="b" items="${bookingList}">
            <tr>
                <td>${b.booking_id}</td>
                <td>${b.classroom_id}</td>
                <td>${b.booking_date}</td>
                <td>${b.start_time} - ${b.end_time}</td>
                <td>${b.purpose}</td>
                <td>${b.status}</td>
            </tr>
        </c:forEach>
    </table>

    <br/>
    <a href="BookingServlet?action=reportUserChart&user_id=<%= user.getUser_id() %>">? View My Booking Chart</a><br/>
    <a href="dashboardBookingUser.jsp">? Back to Dashboard</a>
</body>
</html>
