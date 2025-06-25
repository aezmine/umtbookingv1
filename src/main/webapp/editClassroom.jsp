<%@ page import="com.model.Classroom" %>
<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated admin can access this page
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }

    Classroom room = (Classroom) request.getAttribute("room");
    boolean isEdit = (room != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Classroom</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-purple-500 to-indigo-700 flex items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-lg transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl font-extrabold text-center text-purple-700 mb-8 tracking-wide">
            <%= isEdit ? "?? Edit Classroom" : "? Add New Classroom" %>
        </h2>

        <form action="ClassroomServlet" method="POST" class="space-y-4">
            <% if (isEdit) { %>
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="classroom_id" value="<%= room.getClassroom_id() %>">
            <% } else { %>
                <input type="hidden" name="action" value="add"/>
            <% } %>

            <div>
                <label for="name" class="block font-medium text-gray-700 mb-1">Name:</label>
                <input type="text" id="name" name="name" required
                       value="<%= isEdit ? room.getName() : "" %>"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 transition-all duration-200">
            </div>

            <div>
                <label for="location" class="block font-medium text-gray-700 mb-1">Location:</label>
                <input type="text" id="location" name="location" required
                       value="<%= isEdit ? room.getLocation() : "" %>"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 transition-all duration-200">
            </div>

            <div>
                <label for="capacity" class="block font-medium text-gray-700 mb-1">Capacity:</label>
                <input type="number" id="capacity" name="capacity" required
                       value="<%= isEdit ? room.getCapacity() : "" %>"
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 transition-all duration-200">
            </div>

            <div>
                <label for="status" class="block font-medium text-gray-700 mb-1">Status:</label>
                <select id="status" name="status"
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 transition-all duration-200 bg-white">
                    <option value="available" <%= isEdit && "available".equalsIgnoreCase(room.getStatus()) ? "selected" : "" %>>Available</option>
                    <option value="maintenance" <%= isEdit && "maintenance".equalsIgnoreCase(room.getStatus()) ? "selected" : "" %>>Maintenance</option>
                </select>
            </div>

            <div class="text-center pt-4">
                <button type="submit"
                        class="bg-purple-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                    <%= isEdit ? "Update Classroom" : "Add Classroom" %>
                </button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="ClassroomServlet?action=list"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Classroom List
            </a>
        </div>
    </div>

</body>
</html>
