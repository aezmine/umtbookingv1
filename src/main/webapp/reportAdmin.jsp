<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.model.Booking" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated admin can access this page
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Report</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-teal-500 to-cyan-700 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-5xl transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl md:text-4xl font-extrabold text-center text-teal-700 mb-8 tracking-wide">Booking Report (Admin)</h2>

        <div class="overflow-x-auto rounded-lg shadow-md border border-gray-200 mb-6">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-teal-100">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider rounded-tl-lg">Booking ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider">User ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider">Classroom ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider">Date</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider">Time</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-teal-800 uppercase tracking-wider rounded-tr-lg">Status</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:choose>
                        <c:when test="${not empty bookingList}">
                            <c:forEach var="b" items="${bookingList}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${b.booking_id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${b.user_id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${b.classroom_id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${b.booking_date}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${b.start_time} - ${b.end_time}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                            <c:choose>
                                                <c:when test="${b.status eq 'approved'}">bg-green-100 text-green-800</c:when>
                                                <c:when test="${b.status eq 'pending'}">bg-yellow-100 text-yellow-800</c:when>
                                                <c:when test="${b.status eq 'rejected'}">bg-red-100 text-red-800</c:when>
                                                <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                            </c:choose>">
                                            ${b.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">No bookings found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="flex flex-col sm:flex-row justify-center items-center space-y-4 sm:space-y-0 sm:space-x-4 mt-6">
            <a href="BookingServlet?action=reportSummary"
               class="inline-block bg-blue-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a1 1 0 001 1h2a1 1 0 001-1v-4a1 1 0 00-1-1h-2a1 1 0 00-1 1v4zm6 0a1 1 0 001 1h2a1 1 0 001-1v-4a1 1 0 00-1-1h-2a1 1 0 00-1 1v4z"></path></svg>
                View Summary Report
            </a>
            <a href="adminDashboard.jsp"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Admin Dashboard
            </a>
        </div>
    </div>

</body>
</html>
