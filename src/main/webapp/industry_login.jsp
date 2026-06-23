<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Industry Login - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>E-Trash Platform</h2>
            <h3>Industry Login</h3>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <form action="login" method="post">
                <input type="hidden" name="userType" value="industry">
                
                <div class="form-group">
                    <label>Phone Number:</label>
                    <input type="text" name="username" required pattern="[0-9]{10}">
                </div>
                
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password" required>
                </div>
                
                <button type="submit" class="btn">Login</button>
            </form>
            
            <p>Don't have an account? <a href="industry_register.jsp">Register here</a></p>
            <p><a href="login.jsp">Back to main login</a></p>
        </div>
    </div>
</body>
</html>