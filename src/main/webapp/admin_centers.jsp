<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.RecyclingCenter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recycling Centers - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Admin</h2>
            <ul>
                <li><a href="admin_dashboard.jsp">Dashboard</a></li>
                <li><a href="admin_users">User Management</a></li>
                <li><a href="admin_recyclers">Recycler Management</a></li>
                <li><a href="admin_pickups">Pickup Management</a></li>
                <li><a href="admin_centers">Recycling Centers</a></li>
                <li><a href="admin_campaigns">Campaigns</a></li>
                <li><a href="admin_complaints">Complaints</a></li>
                <li><a href="admin_reports">Reports</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Recycling Centers Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <div class="add-center-form">
                <h2>Add New Recycling Center</h2>
                <form action="admin_centers" method="post">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="form-group">
                        <label>Center Name:</label>
                        <input type="text" name="centerName" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Address:</label>
                        <textarea name="address" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>Contact Number:</label>
                        <input type="text" name="contactNumber" required>
                    </div>
                    
                    <button type="submit" class="btn">Add Center</button>
                </form>
            </div>
            
            <h2>Existing Centers</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Center Name</th>
                    <th>Address</th>
                    <th>Contact Number</th>
                    <th>Action</th>
                </tr>
                <%
                List<RecyclingCenter> centers = (List<RecyclingCenter>) request.getAttribute("centers");
                if (centers != null) {
                    for (RecyclingCenter center : centers) {
                %>
                <tr>
                    <td><%= center.getCenterId() %></td>
                    <td><%= center.getCenterName() %></td>
                    <td><%= center.getAddress() %></td>
                    <td><%= center.getContactNumber() %></td>
                    <td>
                        <form action="admin_centers" method="post" onsubmit="return confirmAction('Are you sure you want to delete this center?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="centerId" value="<%= center.getCenterId() %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </table>
        </div>
    </div>
</body>
</html>