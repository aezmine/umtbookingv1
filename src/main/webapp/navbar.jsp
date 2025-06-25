<%@ page import="com.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!-- Navigation Bar -->
<nav class="nav-container flex justify-between items-center rounded-b-lg">
    <div class="flex-1 flex justify-center lg:justify-start">
        <a href="index.jsp">
            <img src="assets/pic01.webp" alt="UMT Logo" class="h-10 w-auto">
        </a>
    </div>
    <div class="flex items-center space-x-4">
        <% if (user == null) { %>
            <a href="userLogin.html" class="primary-button">Login</a>
        <% } else { %>
            <span class="text-sm text-gray-700">Welcome, <%= user.getName() %></span>
            <a href="logout.jsp" class="primary-button">Logout</a>
        <% } %>
    </div>
</nav>
