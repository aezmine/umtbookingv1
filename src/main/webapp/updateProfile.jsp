<%--
    Document   : updateProfile
    Created on : 24 Jun 2025, 2:53:15 am
    Author     : VICTUS
--%>

<%@ page import="com.model.User" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("userLogin.html");
        return;
    }

    // Determine where to go back after updating
    String backPage = "index.jsp"; // default
    if ("admin".equals(user.getRole())) {
        backPage = "adminDashboard.jsp";
    } else if ("user".equals(user.getRole())) {
        backPage = "userDashboard.jsp";
    } else if ("hof".equals(user.getRole())) {
        backPage = "hofDashboard.jsp"; // Assuming a hofDashboard.jsp exists
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update My Profile</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-indigo-500 to-purple-700 flex items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-lg transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl font-extrabold text-center text-indigo-700 mb-8 tracking-wide">Update My Profile</h2>

        <!-- Success message display -->
        <% if (request.getParameter("success") != null) { %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-6" role="alert">
                <strong class="font-bold">Success!</strong>
                <span class="block sm:inline">Account updated successfully!</span>
            </div>
        <% } %>

        <form action="UserServlet" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="updateAccount">
            <input type="hidden" name="userId" value="<%= user.getUser_id() %>">

            <div>
                <label for="email" class="block font-medium text-gray-700 mb-1">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all duration-200">
            </div>

            <div>
                <label for="phonenumber" class="block font-medium text-gray-700 mb-1">Phone Number:</label>
                <input type="text" id="phonenumber" name="phonenumber" value="<%= user.getPhonenumber() %>" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all duration-200">
            </div>

            <div>
                <label for="password" class="block font-medium text-gray-700 mb-1">New Password:</label>
                <input type="password" id="password" name="password" placeholder="Leave empty if not changing"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all duration-200">
            </div>

            <div class="text-center pt-4">
                <button type="submit"
                        class="bg-indigo-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                    Update Account
                </button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="<%= backPage %>"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Dashboard
            </a>
        </div>
    </div>

</body>
</html>
