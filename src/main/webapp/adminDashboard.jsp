<%@ page import="com.model.User" %>
<%
    // Server-side logic to check user session and role.
    // This part remains unchanged as it's critical for security and functionality.
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("userLogin.html");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for a modern feel, consistent with login page */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-green-500 to-teal-600 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-2xl transform transition-all duration-300 hover:scale-[1.01]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-8">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-36 h-36 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/144x144/ccddaa/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-4xl font-extrabold text-center text-green-700 mb-4 tracking-wide">Admin Dashboard</h2>
        <p class="text-xl text-center text-gray-700 mb-8">Welcome, <strong class="text-green-800"><%= user.getName() %></strong>!</p>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Management Section -->
            <div class="bg-gray-50 p-6 rounded-lg shadow-md border border-gray-200">
                <h3 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">Management</h3>
                <ul class="space-y-3">
                    <li>
                        <a href="registerUser.jsp" class="flex items-center px-4 py-2 bg-blue-100 text-blue-800 rounded-md hover:bg-blue-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H9a1 1 0 01-1-1v-1a4 4 0 014-4h.877c.231.026.467.038.703.038H16a4 4 0 004-4V8a2 2 0 00-2-2h-3.488c-.015-.027-.03-.053-.046-.08A6 6 0 0012 3z"></path></svg>
                            Register New User
                        </a>
                    </li>
                    <li>
                        <a href="ClassroomServlet" class="flex items-center px-4 py-2 bg-purple-100 text-purple-800 rounded-md hover:bg-purple-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a2 2 0 012-2h2a2 2 0 012 2v5m-10 0h6"></path></svg>
                            Manage Classrooms
                        </a>
                    </li>
                    <li>
                        <a href="BookingServlet?action=listAll" class="flex items-center px-4 py-2 bg-red-100 text-red-800 rounded-md hover:bg-red-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.001 12.001 0 002 15.464V17a2 2 0 002 2h16a2 2 0 002-2v-1.536a12.001 12.001 0 00-2.382-6.016z"></path></svg>
                            Approve Bookings
                        </a>
                    </li>
                    <li>
                        <a href="viewUsers.jsp" class="flex items-center px-4 py-2 bg-orange-100 text-orange-800 rounded-md hover:bg-orange-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H2v-2a3 3 0 015.356-1.857M9 20v-2a3 3 0 00-3-3H4a2 2 0 00-2 2v4h16l-3-3zM12 10a6 6 0 100-12 6 6 0 000 12z"></path></svg>
                            View All Users
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Reports Section -->
            <div class="bg-gray-50 p-6 rounded-lg shadow-md border border-gray-200">
                <h3 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">Reports</h3>
                <ul class="space-y-3">
                    <li>
                        <a href="BookingServlet?action=report" class="flex items-center px-4 py-2 bg-green-100 text-green-800 rounded-md hover:bg-green-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-4m0 0l3 3m-3-3l-3 3m3-3V9m0 0l3 3m-3-3l-3 3m9-9h2m-2 0a2 2 0 110 4m0-4a2 2 0 100 4m-9 0h2m-2 0a2 2 0 110 4m0-4a2 2 0 100 4m-9 0h2m-2 0a2 2 0 110 4m0-4a2 2 0 100 4"></path></svg>
                            Full List Report
                        </a>
                    </li>
                    <li>
                        <a href="BookingServlet?action=reportSummary" class="flex items-center px-4 py-2 bg-yellow-100 text-yellow-800 rounded-md hover:bg-yellow-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                            Summary Count Report
                        </a>
                    </li>
                    <li>
                        <a href="BookingServlet?action=reportChart" class="flex items-center px-4 py-2 bg-pink-100 text-pink-800 rounded-md hover:bg-pink-200 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M18 10V6M6 18H2M6 6H2"></path></svg>
                            Chart Report
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Profile and Logout Section -->
        <div class="mt-8 pt-6 border-t-2 border-gray-200 flex flex-col sm:flex-row justify-between items-center space-y-4 sm:space-y-0 sm:space-x-4">
            <a href="updateProfile.jsp" class="w-full sm:w-auto flex-grow text-center px-6 py-3 bg-indigo-600 text-white font-semibold rounded-full hover:bg-indigo-700 transition-all duration-300 shadow-md">
                <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
                Update Profile
            </a>
            <a href="logout.jsp" class="w-full sm:w-auto flex-grow text-center px-6 py-3 bg-red-600 text-white font-semibold rounded-full hover:bg-red-700 transition-all duration-300 shadow-md">
                <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                Logout
            </a>
        </div>
    </div>

</body>
</html>
