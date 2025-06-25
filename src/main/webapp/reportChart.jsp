<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.User" %>
<%
    // Session check: Ensure only an authenticated admin can access this page
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("userLogin.html"); // Redirect to login if not an admin
        return;
    }

    int approved = (int) request.getAttribute("approved");
    int rejected = (int) request.getAttribute("rejected");
    int pending = (int) request.getAttribute("pending");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Chart Report</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Load Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Custom font for consistency */
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Chart container styling for responsiveness and centering */
        .chart-responsive-container {
            position: relative;
            height: 400px; /* Fixed height for the canvas */
            width: 100%;
            max-width: 600px; /* Max width to keep it from getting too large */
            margin: auto; /* Center the container */
        }
    </style>
</head>
<body class="bg-gradient-to-r from-red-500 to-orange-700 flex flex-col items-center justify-center min-h-screen text-gray-800 p-4">

    <div class="bg-white shadow-2xl rounded-xl p-8 w-full max-w-2xl transform transition-all duration-300 hover:scale-[1.005]">
        <!-- Logo Section -->
        <div class="flex justify-center mb-6">
            <img src="assets/pic01.webp" alt="Company Logo" class="w-32 h-32 object-contain rounded-full shadow-lg"
                 onerror="this.onerror=null;this.src='https://placehold.co/128x128/aabbcc/ffffff?text=Logo';"
            >
        </div>

        <h2 class="text-3xl md:text-4xl font-extrabold text-center text-red-700 mb-8 tracking-wide">📊 Booking Status Chart</h2>

        <div class="chart-responsive-container mb-8">
            <canvas id="bookingChart"></canvas>
        </div>

        <div class="flex flex-col sm:flex-row justify-center items-center space-y-4 sm:space-y-0 sm:space-x-4 mt-6">
            <a href="BookingServlet?action=report"
               class="inline-block bg-gray-300 text-gray-800 font-semibold px-8 py-3 rounded-full hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path></svg>
                Back to Full Report
            </a>
            <a href="adminDashboard.jsp"
               class="inline-block bg-indigo-600 text-white font-semibold px-8 py-3 rounded-full hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition-all duration-300 shadow-lg hover:shadow-xl">
                <svg class="w-5 h-5 inline-block mr-2 -mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m0 0l7 7 7-7M19 10v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                Back to Admin Dashboard
            </a>
        </div>
    </div>

    <script>
        // Get the canvas context
        const ctx = document.getElementById('bookingChart').getContext('2d');

        // Create the Chart.js instance
        const bookingChart = new Chart(ctx, {
            type: 'pie', // Pie chart type
            data: {
                // Labels for the segments
                labels: ['Approved', 'Rejected', 'Pending'],
                datasets: [{
                    label: 'Booking Status',
                    // Data values from JSP scriptlets
                    data: [<%= approved %>, <%= rejected %>, <%= pending %>],
                    // Background colors for each segment
                    backgroundColor: ['#4CAF50', '#F44336', '#FF9800'],
                    borderWidth: 1 // Border width for segments
                }]
            },
            options: {
                responsive: true, // Make chart responsive to container size
                maintainAspectRatio: false, // Do not maintain aspect ratio for flexible sizing
                plugins: {
                    legend: {
                        position: 'bottom', // Position legend at the bottom
                        labels: {
                            font: {
                                size: 14 // Adjust legend font size
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: 'Booking Status Breakdown', // Chart title
                        font: {
                            size: 18, // Adjust title font size
                            weight: 'bold'
                        },
                        color: '#333' // Title color
                    },
                    tooltip: {
                        callbacks: {
                            // Custom tooltip to show percentage
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    const total = context.dataset.data.reduce((sum, current) => sum + current, 0);
                                    const percentage = (context.parsed / total * 100).toFixed(2) + '%';
                                    label += context.parsed + ' (' + percentage + ')';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
