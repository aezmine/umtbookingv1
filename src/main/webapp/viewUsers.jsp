<%--
    Document   : viewUsers
    Created on : 24 Jun 2025, 3:56:05 am
    Author     : VICTUS
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.model.User" %>
<%@ page import="com.dao.UserDao" %>

<%
    // Server-side logic for session check and data retrieval
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }

    UserDao dao = new UserDao();
    List<User> userList = dao.getAllUsers();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Users</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-purple-500 to-indigo-600 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-4xl transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl font-extrabold text-center text-purple-700 mb-8 tracking-wide">List of All Users</h2>

        <div class="overflow-x-auto rounded-lg shadow-md border border-gray-200 mb-6">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-purple-100">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider rounded-tl-lg">User ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider">Name</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider">Email</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider">Phone</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider">Role</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider">Faculty</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-purple-800 uppercase tracking-wider rounded-tr-lg">Created At</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <%
                        if (userList != null && !userList.isEmpty()) {
                            for (User user : userList) {
                    %>
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= user.getUser_id() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getName() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getEmail() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getPhonenumber() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getRole() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getFaculty() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user.getCreated_at() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="px-6 py-4 text-center text-sm text-gray-500">No users found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-6">
            <a href="adminDashboard.jsp"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Admin Dashboard
            </a>
        </div>
    </div>

</body>
</html>
