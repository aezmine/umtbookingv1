// ClassroomServlet.java
package com.controller;

import com.dao.ClassroomDao;
import com.model.Classroom;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ClassroomServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    ClassroomDao dao = new ClassroomDao();

    if (action == null || action.equals("list")) {
        List<Classroom> classrooms = dao.getAllClassrooms();
        request.setAttribute("classrooms", classrooms != null ? classrooms : new java.util.ArrayList<>());
        request.getRequestDispatcher("manageClassrooms.jsp").forward(request, response);
    } else if (action.equals("edit")) {
        int id = Integer.parseInt(request.getParameter("id"));
        Classroom room = dao.getClassroomById(id);
        request.setAttribute("room", room);
        request.getRequestDispatcher("editClassroom.jsp").forward(request, response);
    } else if (action.equals("delete")) {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteClassroom(id);
        response.sendRedirect("ClassroomServlet?action=list");
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClassroomDao dao = new ClassroomDao();

        String idStr = request.getParameter("classroom_id");
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String status = request.getParameter("status");

        Classroom room = new Classroom();
        room.setName(name);
        room.setLocation(location);
        room.setCapacity(capacity);
        room.setStatus(status);

        
        if (idStr != null && !idStr.isEmpty()) {
            room.setClassroom_id(Integer.parseInt(idStr));
            dao.updateClassroom(room);
        } else {
            dao.addClassroom(room);
        }

        response.sendRedirect("ClassroomServlet?action=list");
    }
} 
