<%@page import="com.util.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Database Connection Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .success { color: green; background: #e8f5e8; padding: 15px; border-radius: 5px; }
        .error { color: red; background: #ffeaea; padding: 15px; border-radius: 5px; }
        .info { color: blue; background: #e8f4f8; padding: 15px; border-radius: 5px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Database Connection Test</h1>
    
    <%
        Connection conn = null;
        try {
            // Test connection
            conn = DBConnection.getConnection();
            
            if (conn != null && !conn.isClosed()) {
                out.println("<div class='success'>");
                out.println("<h3>✓ Connection Successful!</h3>");
                
                // Get database metadata
                DatabaseMetaData metaData = conn.getMetaData();
                out.println("<table>");
                out.println("<tr><th>Property</th><th>Value</th></tr>");
                out.println("<tr><td>Database Product</td><td>" + metaData.getDatabaseProductName() + "</td></tr>");
                out.println("<tr><td>Database Version</td><td>" + metaData.getDatabaseProductVersion() + "</td></tr>");
                out.println("<tr><td>Driver Name</td><td>" + metaData.getDriverName() + "</td></tr>");
                out.println("<tr><td>Connection URL</td><td>" + metaData.getURL() + "</td></tr>");
                out.println("<tr><td>Username</td><td>" + metaData.getUserName() + "</td></tr>");
                out.println("</table>");
                out.println("</div>");
                
                // Test a simple query
                try {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT NOW() as current_time");
                    
                    out.println("<div class='info'>");
                    out.println("<h3>Query Test:</h3>");
                    if (rs.next()) {
                        out.println("<p>Current database time: " + rs.getString("current_time") + "</p>");
                    }
                    out.println("</div>");
                    
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    out.println("<div class='error'>");
                    out.println("<h3>Query Test Failed:</h3>");
                    out.println("<p>" + e.getMessage() + "</p>");
                    out.println("</div>");
                }
                
            } else {
                out.println("<div class='error'>");
                out.println("<h3>✗ Connection Failed!</h3>");
                out.println("<p>Connection is null or closed.</p>");
                out.println("</div>");
            }
            
        } catch (SQLException e) {
            out.println("<div class='error'>");
            out.println("<h3>✗ SQL Exception:</h3>");
            out.println("<p><strong>Error Code:</strong> " + e.getErrorCode() + "</p>");
            out.println("<p><strong>SQL State:</strong> " + e.getSQLState() + "</p>");
            out.println("<p><strong>Message:</strong> " + e.getMessage() + "</p>");
            out.println("</div>");
        } catch (Exception e) {
            out.println("<div class='error'>");
            out.println("<h3>✗ General Exception:</h3>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</div>");
        }
    %>
    
    <div style="margin-top: 30px;">
        <h3>Troubleshooting Tips:</h3>
        <ul>
            <li>Make sure MySQL server is running</li>
            <li>Check if the database name exists</li>
            <li>Verify username and password are correct</li>
            <li>Ensure MySQL JDBC driver is in classpath</li>
            <li>Check if port 3306 is accessible</li>
        </ul>
    </div>
    
    <div style="margin-top: 20px;">
        <a href="<%= request.getRequestURI() %>" style="background: #007cba; color: white; padding: 10px 15px; text-decoration: none; border-radius: 3px;">Refresh Test</a>
    </div>
</body>
</html>