<%@ page import="com.model.Classroom" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated admin can access this page
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }

    List<Classroom> classrooms = (List<Classroom>) request.getAttribute("classrooms");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Classrooms</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-green-500 to-emerald-700 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-4xl transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h1 class="text-3xl md:text-4xl font-extrabold text-center text-green-700 mb-8 tracking-wide">Manage Classrooms</h1>

        <div class="mb-10 p-6 bg-gray-50 rounded-lg shadow-md border border-gray-200">
            <h2 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">Add / Edit Classroom</h2>
            <form action="ClassroomServlet" method="POST" class="space-y-4">
                <input type="hidden" name="classroom_id" value="<%= request.getParameter("id") != null && request.getAttribute("room") != null ? ((Classroom) request.getAttribute("room")).getClassroom_id() : "" %>">

                <div>
                    <label for="name" class="block font-medium text-gray-700 mb-1">Name:</label>
                    <input type="text" id="name" name="name" required
                           value="<%= request.getAttribute("room") != null ? ((Classroom) request.getAttribute("room")).getName() : "" %>"
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition-all duration-200">
                </div>

                <div>
                    <label for="location" class="block font-medium text-gray-700 mb-1">Location:</label>
                    <input type="text" id="location" name="location" required
                           value="<%= request.getAttribute("room") != null ? ((Classroom) request.getAttribute("room")).getLocation() : "" %>"
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition-all duration-200">
                </div>

                <div>
                    <label for="capacity" class="block font-medium text-gray-700 mb-1">Capacity:</label>
                    <input type="number" id="capacity" name="capacity" required
                           value="<%= request.getAttribute("room") != null ? ((Classroom) request.getAttribute("room")).getCapacity() : "" %>"
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition-all duration-200">
                </div>

                <div>
                    <label for="status" class="block font-medium text-gray-700 mb-1">Status:</label>
                    <select id="status" name="status"
                            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 transition-all duration-200 bg-white">
                        <option value="available" <%= request.getAttribute("room") != null && ((Classroom) request.getAttribute("room")).getStatus().equals("available") ? "selected" : "" %>>Available</option>
                        <option value="maintenance" <%= request.getAttribute("room") != null && ((Classroom) request.getAttribute("room")).getStatus().equals("maintenance") ? "selected" : "" %>>Maintenance</option>
                    </select>
                </div>

                <div class="text-center pt-4">
                    <button type="submit"
                            class="bg-green-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                        Save Classroom
                    </button>
                </div>
            </form>
        </div>

        <h2 class="text-2xl font-bold text-gray-800 mb-4 border-b pb-2">All Classrooms</h2>
        <div class="overflow-x-auto rounded-lg shadow-md border border-gray-200 mb-6">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-green-100">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider rounded-tl-lg">ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider">Name</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider">Location</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider">Capacity</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider">Status</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-green-800 uppercase tracking-wider rounded-tr-lg">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <%
                        if (classrooms != null && !classrooms.isEmpty()) {
                            for (Classroom c : classrooms) {
                    %>
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= c.getClassroom_id() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getName() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getLocation() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getCapacity() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                <%= c.getStatus().equals("available") ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800" %>">
                                <%= c.getStatus() %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="ClassroomServlet?action=edit&id=<%= c.getClassroom_id() %>"
                               class="text-indigo-600 hover:text-indigo-900 mr-4 transition-colors">Edit</a>
                            |
                            <a href="#" onclick="showCustomConfirmationModal('Delete Classroom', 'Are you sure you want to delete classroom <%= c.getName() %> (ID: <%= c.getClassroom_id() %>)?', 'ClassroomServlet?action=delete&id=<%= c.getClassroom_id() %>'); return false;"
                               class="text-red-600 hover:text-red-900 ml-4 transition-colors">Delete</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">No classrooms found or failed to fetch data.</td>
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

    <!-- Custom Confirmation Modal -->
    <div id="confirmationModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 shadow-xl max-w-sm w-full text-center">
            <h3 id="modalConfirmationTitle" class="text-xl font-bold mb-4 text-gray-800"></h3>
            <p id="modalConfirmationText" class="text-gray-700 mb-6"></p>
            <div class="flex justify-center space-x-4">
                <button id="confirmButton"
                        class="bg-red-500 text-white px-5 py-2 rounded-md hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 transition-colors">
                    Confirm
                </button>
                <button onclick="document.getElementById('confirmationModal').classList.add('hidden')"
                        class="bg-gray-300 text-gray-800 px-5 py-2 rounded-md hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-colors">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script>
        // Function to show the custom confirmation modal
        function showCustomConfirmationModal(title, message, confirmUrl) {
            const modal = document.getElementById('confirmationModal');
            const modalTitle = document.getElementById('modalConfirmationTitle');
            const modalText = document.getElementById('modalConfirmationText');
            const confirmButton = document.getElementById('confirmButton');

            modalTitle.textContent = title;
            modalText.textContent = message;

            // Set the href of the confirm button dynamically
            confirmButton.onclick = function() {
                window.location.href = confirmUrl;
            };

            modal.classList.remove('hidden');
            modal.classList.add('flex'); // Use flex to center
        }
    </script>
</body>
</html>
