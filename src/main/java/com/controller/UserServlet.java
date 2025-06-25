package com.controller;

import com.dao.UserDao;
import com.model.User;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class UserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        UserDao dao = new UserDao();

        // 1. Login
        if ("login".equals(action)) {
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");

            User user = dao.login(userId, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUser_id()); // ✅ Needed for servlet checks
                session.setAttribute("role", user.getRole());       // ✅ Needed for role-based access

                // Redirect to role-specific dashboard
                switch (user.getRole()) {
                    case "admin":
                        response.sendRedirect("adminDashboard.jsp");
                        break;
                    case "hof":
                        response.sendRedirect("hofDashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("userDashboard.jsp");
                        break;
                }
            } else {
                response.sendRedirect("userLogin.html?error=1");
            }

        // 2. Update Profile
        } else if ("updateAccount".equals(action)) {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("userLogin.html");
                return;
            }

            String email = request.getParameter("email");
            String phone = request.getParameter("phonenumber");
            String password = request.getParameter("password");

            boolean updated = false;

            if (email != null && !email.isEmpty()) {
                user.setEmail(email);
                dao.updateEmail(user.getUser_id(), email);
                updated = true;
            }

            if (phone != null && !phone.isEmpty()) {
                user.setPhonenumber(phone);
                dao.updatePhone(user.getUser_id(), phone);
                updated = true;
            }

            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
                dao.updatePassword(user.getUser_id(), password);
                updated = true;
            }

            if (updated) {
                session.setAttribute("user", user);
                response.sendRedirect("updateProfile.jsp?success=1");
            } else {
                response.sendRedirect("updateProfile.jsp?success=0");
            }

        // 3. Admin Registers New User
        } else if ("register".equals(action)) {
            HttpSession session = request.getSession(false);
            User currentUser = (User) session.getAttribute("user");

            if (currentUser == null || !"admin".equals(currentUser.getRole())) {
                response.sendRedirect("userLogin.html");
                return;
            }

            String userId = request.getParameter("userId");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String faculty = request.getParameter("faculty");
            String phone = request.getParameter("phonenumber");

            User newUser = new User();
            newUser.setUser_id(userId);
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setRole(role);
            newUser.setFaculty(faculty);
            newUser.setPhonenumber(phone);

            boolean success = dao.registerUser(newUser);

//            if (success) {
//                response.sendRedirect("registerUser.jsp?success=1");
//            } else {
//                response.sendRedirect("registerUser.jsp?success=0");
//            }
        if (success) {
    response.sendRedirect("registerUser.jsp?success=1");
        } else {
            response.sendRedirect("registerUser.jsp?duplicate=1"); // ⛔ Duplicate User ID
        }


        }
    }
}
