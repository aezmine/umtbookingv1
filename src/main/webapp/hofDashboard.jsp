<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated HOF can access this page
    User user = (User) session.getAttribute("user");
    if (user == null || !"hof".equals(user.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an HOF
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOF Dashboard</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-orange-500 to-red-600 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-md transform transition-all duration-300 hover:scale-[1.01]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl md:text-4xl font-extrabold text-center text-orange-700 mb-4 tracking-wide">HOF Dashboard</h2>
        <p class="text-xl text-center text-gray-700 mb-8">Welcome, <strong class="text-orange-800"><%= user.getName() %></strong>!</p>

        <div class="p-6 bg-gray-50 rounded-lg shadow-md border border-gray-200">
            <h3 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">HOF Actions</h3>
            <ul class="space-y-4">
                <li>
                    <a href="BookingServlet?action=listHof"
                       class="flex items-center justify-center px-6 py-3 bg-red-600 text-white font-semibold rounded-full hover:bg-red-700 transition-all duration-300 shadow-md">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path></svg>
                        Approve Booking Requests
                    </a>
                </li>
                <li>
                    <a href="updateProfile.jsp"
                       class="flex items-center justify-center px-6 py-3 bg-indigo-600 text-white font-semibold rounded-full hover:bg-indigo-700 transition-all duration-300 shadow-md">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
                        Update Profile
                    </a>
                </li>
                <li>
                    <a href="logout.jsp"
                       class="flex items-center justify-center px-6 py-3 bg-gray-600 text-white font-semibold rounded-full hover:bg-gray-700 transition-all duration-300 shadow-md">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>

</body>
</html>
