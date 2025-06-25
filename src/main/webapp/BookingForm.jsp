<%@ page import="com.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.model.Classroom" %>
<%@ page import="java.util.List" %>
<%
    // Session check: Ensure only an authenticated user can access this page
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not a user
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Classroom</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-teal-500 to-cyan-600 flex items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-lg transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl font-extrabold text-center text-teal-700 mb-8 tracking-wide">Book a Classroom</h2>

        <!-- Error message display -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6" role="alert">
                <strong class="font-bold">Error!</strong>
                <span class="block sm:inline">${error}</span>
            </div>
        </c:if>

        <form action="BookingServlet" method="post" class="space-y-4">
            <input type="hidden" name="action" value="create"/>
            <input type="hidden" name="user_id" value="<%= user.getUser_id() %>"/>

            <div>
                <label for="classroom_id" class="block font-medium text-gray-700 mb-1">Classroom:</label>
                <select id="classroom_id" name="classroom_id" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 transition-all duration-200 bg-white">
                    <c:forEach var="c" items="${classrooms}">
                        <option value="${c.classroom_id}">
                            ${c.name} (ID: ${c.classroom_id})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div>
                <label for="booking_date" class="block font-medium text-gray-700 mb-1">Date:</label>
                <input type="date" id="booking_date" name="booking_date" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 transition-all duration-200">
            </div>

            <div class="flex space-x-4">
                <div class="flex-1">
                    <label for="start_time" class="block font-medium text-gray-700 mb-1">Start Time:</label>
                    <input type="time" id="start_time" name="start_time" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 transition-all duration-200">
                </div>
                <div class="flex-1">
                    <label for="end_time" class="block font-medium text-gray-700 mb-1">End Time:</label>
                    <input type="time" id="end_time" name="end_time" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 transition-all duration-200">
                </div>
            </div>

            <div>
                <label for="purpose" class="block font-medium text-gray-700 mb-1">Purpose:</label>
                <textarea id="purpose" name="purpose" rows="4" required
                          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 transition-all duration-200 resize-y"></textarea>
            </div>

            <div class="text-center pt-4">
                <button type="submit"
                        class="bg-teal-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                    Submit Booking
                </button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="userDashboard.jsp"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        // JavaScript to set the minimum date for the booking date input
        window.onload = function () {
            const now = new Date();

            // Format YYYY-MM-DD
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const today = `${year}-${month}-${day}`;

            // Set min attribute for date input
            const dateInput = document.querySelector('input[name="booking_date"]');
            if (dateInput) {
                dateInput.setAttribute("min", today);
            }
        };
    </script>
</body>
</html>
