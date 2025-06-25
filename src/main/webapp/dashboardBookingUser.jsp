<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.model.User" %>
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
    <title>Your Bookings</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-blue-500 to-purple-600 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-5xl transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl md:text-4xl font-extrabold text-center text-blue-700 mb-8 tracking-wide">Your Bookings</h2>

        <div class="overflow-x-auto rounded-lg shadow-md border border-gray-200 mb-6">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-blue-100">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider rounded-tl-lg">ID</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider">Classroom</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider">Date</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider">Time</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider">Status</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider">Purpose</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-blue-800 uppercase tracking-wider rounded-tr-lg">Action</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:choose>
                        <c:when test="${not empty bookingList}">
                            <c:forEach var="b" items="${bookingList}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${b.booking_id}</td>
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
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${b.purpose}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <c:if test="${b.status eq 'pending'}">
                                            <form action="BookingServlet" method="get" class="inline-block"
      onsubmit="return confirm('Are you sure you want to cancel booking ID ${b.booking_id}?');">
    <input type="hidden" name="action" value="cancel"/>
    <input type="hidden" name="booking_id" value="${b.booking_id}"/>
    <input type="hidden" name="user_id" value="${b.user_id}"/>
    <button type="submit"
            class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 transition-colors shadow-sm text-sm">
        <svg class="w-4 h-4 inline-block mr-1 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
        </svg>
        Cancel
    </button>
</form>

                                        </c:if>
                                        <c:if test="${b.status eq 'approved'}">
                                            <span class="text-gray-500 text-sm">Cannot Cancel</span>
                                        </c:if>
                                        <c:if test="${b.status eq 'rejected'}">
                                            <span class="text-gray-500 text-sm">Cannot Cancel</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="px-6 py-4 text-center text-sm text-gray-500">No bookings found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-6">
            <a href="userDashboard.jsp"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Dashboard
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

            // Set the action for the confirm button dynamically
            confirmButton.onclick = function() {
                window.location.href = confirmUrl; // Or submit a form programmatically
            };

            modal.classList.remove('hidden');
            modal.classList.add('flex'); // Use flex to center
        }
    </script>
</body>
</html>
