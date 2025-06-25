<%@ page import="com.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>UMT Classroom Booking - Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --primary-blue: #2563EB;
            --secondary-bg-light: #F3F4F6;
            --content-bg-white: #FFFFFF;
            --text-dark: #374151;
            --border-light: #D1D5DB;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--secondary-bg-light);
            margin: 0;
            padding: 0;
            color: var(--text-dark);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .nav-container {
            background-color: var(--content-bg-white);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            width: 100%;
            padding: 0.75rem 1.5rem;
        }

        .icon-wrapper {
            padding: 0.5rem;
            border-radius: 0.375rem;
            transition: background-color 0.2s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-wrapper:hover {
            background-color: var(--secondary-bg-light);
        }

        .primary-button {
            background-color: var(--primary-blue);
            color: var(--content-bg-white);
            padding: 0.75rem 1.25rem;
            border-radius: 0.5rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .primary-button:hover {
            background-color: #1D4ED8;
        }

        .content-section {
            background-color: var(--content-bg-white);
            padding: 2.5rem;
            border-radius: 0.75rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .section-heading {
            color: var(--primary-blue);
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .text-body {
            font-size: 1.125rem;
            line-height: 1.6;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="nav-container flex justify-between items-center rounded-b-lg">
    <div class="flex-1 flex justify-center lg:justify-start">
        <img src="assets/pic01.webp" alt="UMT Logo" class="h-10 w-auto">
    </div>
    <div class="flex items-center space-x-4">
        <% if (user == null) { %>
            <a href="userLogin.html" class="primary-button">Login</a>
        <% } else { %>
            <a href="logout.jsp" class="primary-button">Logout</a>
        <% } %>
    </div>
</nav>

<!-- Main Dashboard -->
<main class="flex-grow container mx-auto px-4 py-8 lg:px-8">
    <section class="content-section mb-10">
        <h2 class="section-heading text-center">UMT Classroom Booking Dashboard</h2>

        <% if (user == null) { %>
            <p class="text-center text-red-600 mb-4">You are not logged in.</p>
        <% } else { %>
            <p class="text-center mb-4 text-lg">
                Hello, <span class="font-semibold"><%= user.getName() %></span>
                (<span class="uppercase text-blue-600"><%= user.getRole() %></span>)
            </p>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <% if ("admin".equals(user.getRole())) { %>
                    <a href="registerUser.jsp" class="primary-button text-center">Register User</a>
                    <a href="adminBookingApproval.jsp" class="primary-button text-center">Approve Bookings</a>
                    <a href="viewUsers.jsp" class="primary-button text-center">View All Users</a>
                <% } else if ("hof".equals(user.getRole())) { %>
                    <a href="hofApproval.jsp" class="primary-button text-center">HOF Approval</a>
                <% } else if ("user".equals(user.getRole())) { %>
                    <a href="bookRoom.jsp" class="primary-button text-center">Book Classroom</a>
                    <a href="myBookings.jsp" class="primary-button text-center">My Bookings</a>
                <% } %>
                <a href="updateProfile.jsp" class="primary-button text-center">Update Profile</a>
            </div>
        <% } %>
    </section>
    
    <section class="content-section mb-10">
            <h2 class="section-heading">Classroom Booking Guidelines</h2>
            <p class="text-body mb-4">
                To ensure fair access and optimal use of our facilities, please note the following booking requirements:
            </p>
            <ul class="list-disc list-inside text-body space-y-2">
                <li>All classroom bookings **must be made at least 3 days prior** to the desired usage date. This allows for proper scheduling and resource allocation.</li>
                <li>Bookings are subject to availability. Please check the classroom calendar for real-time updates.</li>
                <li>Ensure all necessary equipment is requested during the booking process.</li>
                <li>Any cancellations or modifications should be done at least 24 hours in advance.</li>
                <li>For long-term or recurring bookings, please contact administration directly.</li>
            </ul>
            <p class="text-body">
                We strive to provide the best learning environment for everyone. Your cooperation is greatly appreciated!
            </p>
        </section>

    <!-- Classrooms Display -->
    <section class="content-section">
        <h2 class="section-heading">Our Classrooms</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-gray-50 rounded-lg overflow-hidden shadow-md">
                <img src="assets/pic02.jpg" alt="Lecture Hall A" class="w-full h-48 object-cover">
                <div class="p-4">
                    <h3 class="font-semibold text-lg mb-2">Lecture Hall A</h3>
                    <p class="text-sm text-gray-600">Ideal for large lectures with smart board and audio system.</p>
                </div>
            </div>
            <div class="bg-gray-50 rounded-lg overflow-hidden shadow-md">
                <img src="assets/pic03.jpg" alt="Study Room B" class="w-full h-48 object-cover">
                <div class="p-4">
                    <h3 class="font-semibold text-lg mb-2">Study Room B</h3>
                    <p class="text-sm text-gray-600">Perfect for discussions and collaboration.</p>
                </div>
            </div>
            <div class="bg-gray-50 rounded-lg overflow-hidden shadow-md">
                <img src="assets/pic04.jpg" alt="Computer Lab C" class="w-full h-48 object-cover">
                <div class="p-4">
                    <h3 class="font-semibold text-lg mb-2">Computer Lab C</h3>
                    <p class="text-sm text-gray-600">Equipped with high-performance systems for labs.</p>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-6 px-6 text-center text-sm mt-10">
    <div class="container mx-auto">
        <p>&copy; Developed by Group 10. All rights reserved.</p>
        <div class="flex justify-center space-x-4 mt-2">
            <a href="#" class="hover:text-blue-400">Privacy Policy</a>
            <a href="#" class="hover:text-blue-400">Terms of Service</a>
            <a href="#" class="hover:text-blue-400">Contact Us</a>
        </div>
    </div>
</footer>

</body>
</html>
