<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated admin can access this page
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New User</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-blue-500 to-purple-600 flex items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-lg transform transition-all duration-300 hover:scale-[1.01]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl font-extrabold text-center text-blue-700 mb-8 tracking-wide">Register New User</h2>

        <!-- Message containers for success/error -->
        <div id="messageContainer" class="mb-4">
            <%-- Display duplicate user_id warning if exists --%>
            <% if (request.getParameter("duplicate") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <strong class="font-bold">Error!</strong>
                    <span class="block sm:inline">User ID already exists. Please use a different one.</span>
                </div>
            <% } %>

            <%-- Display success message if registration worked --%>
            <% if (request.getParameter("success") != null) { %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <strong class="font-bold">Success!</strong>
                    <span class="block sm:inline">User registered successfully!</span>
                </div>
            <% } %>
        </div>

        <form action="UserServlet" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="register">

            <div>
                <label for="userId" class="block font-medium text-gray-700 mb-1">User ID:</label>
                <input type="text" id="userId" name="userId"
                       pattern="[0-9]{5,6}"
                       title="User ID must be a 5 or 6 digit number only"
                       required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="name" class="block font-medium text-gray-700 mb-1">Name:</label>
                <input type="text" id="name" name="name" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="email" class="block font-medium text-gray-700 mb-1">Email:</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="phonenumber" class="block font-medium text-gray-700 mb-1">Phone Number:</label>
                <input type="tel" id="phonenumber" name="phonenumber"
                       pattern="[0-9]+" title="Please enter only digits for the phone number" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="faculty" class="block font-medium text-gray-700 mb-1">Faculty:</label>
                <select id="faculty" name="faculty" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200 bg-white">
                    <option value="">-- Select Faculty --</option>
                    <option value="FPEPS">FPEPS</option>
                    <option value="FSKM">FSKM</option>
                    <option value="FTKK">FTKK</option>
                    <option value="FPM">FPM</option>
                    <option value="FSSM">FSSM</option>
                    <option value="FPSM">FPSM</option>
                </select>
            </div>

            <div>
                <label for="password" class="block font-medium text-gray-700 mb-1">Password:</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="confirmPassword" class="block font-medium text-gray-700 mb-1">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200">
            </div>

            <div>
                <label for="role" class="block font-medium text-gray-700 mb-1">Role:</label>
                <select id="role" name="role" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all duration-200 bg-white">
                    <option value="user">User</option>
                    <option value="hof">HOF</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <div class="text-center pt-4">
                <button type="submit"
                        class="bg-blue-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                    Register User
                </button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="adminDashboard.jsp"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Admin Dashboard
            </a>
        </div>
    </div>

    <!-- Custom Modal for Messages (instead of alert) -->
    <div id="customMessageModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 shadow-xl max-w-sm w-full text-center">
            <h3 id="modalTitle" class="text-xl font-bold mb-4"></h3>
            <p id="modalText" class="text-gray-700 mb-6"></p>
            <button onclick="document.getElementById('customMessageModal').classList.add('hidden');"
                    class="px-5 py-2 rounded-md text-white focus:outline-none focus:ring-2 focus:ring-offset-2 transition-colors">
                    Close
            </button>
        </div>
    </div>

    <script>
        // Function to show the custom modal
        function showCustomModal(title, message, type) {
            const modal = document.getElementById('customMessageModal');
            const modalTitle = document.getElementById('modalTitle');
            const modalText = document.getElementById('modalText');
            const closeButton = modal.querySelector('button');

            modalTitle.textContent = title;
            modalText.textContent = message;

            // Apply colors based on message type
            if (type === 'error') {
                modalTitle.className = 'text-xl font-bold mb-4 text-red-600';
                closeButton.className = 'px-5 py-2 rounded-md bg-red-500 hover:bg-red-600 text-white focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 transition-colors';
            } else if (type === 'success') {
                modalTitle.className = 'text-xl font-bold mb-4 text-green-600';
                closeButton.className = 'px-5 py-2 rounded-md bg-green-500 hover:bg-green-600 text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition-colors';
            } else { // Default or info
                modalTitle.className = 'text-xl font-bold mb-4 text-gray-800';
                closeButton.className = 'px-5 py-2 rounded-md bg-blue-500 hover:bg-blue-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors';
            }

            modal.classList.remove('hidden');
            modal.classList.add('flex');
        }

        // Form submission listener for password mismatch
        document.querySelector("form").addEventListener("submit", function(e) {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                e.preventDefault(); // stop form submission
                showCustomModal("Password Mismatch", "Passwords do not match. Please try again.", "error");
            }
        });

        // Handle URL parameters for success/duplicate messages
        window.onload = function() {
            const params = new URLSearchParams(window.location.search);
            if (params.get("duplicate") != null) {
                // The JSP message handles this, but if we were to use JS for it:
                // showCustomModal("Registration Failed", "User ID already exists. Please use a different one.", "error");
            } else if (params.get("success") != null) {
                // The JSP message handles this, but if we were to use JS for it:
                // showCustomModal("Registration Successful", "User registered successfully!", "success");
            }
        };
    </script>
</body>
</html>
