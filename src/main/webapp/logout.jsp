<%-- 
    Document   : logout
    Created on : 24 Jun 2025, 3:05:24 am
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
   <%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>

    

    
    
    </body>
</html>
