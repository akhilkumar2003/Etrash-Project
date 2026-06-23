<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management - E-Trash</title>
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
            <h1>User Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null) {
                    for (User user : users) {
                %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhone() %></td>
                    <td><%= user.getAddress() %></td>
                    <td><%= user.getStatus() %></td>
                    <td>
                        <% if ("Active".equals(user.getStatus())) { %>
                            <form action="admin_users" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                <button type="submit" class="btn-deactivate">Deactivate</button>
                            </form>
                        <% } else { %>
                            <form action="admin_users" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                <button type="submit" class="btn-activate">Activate</button>
                            </form>
                        <% } %>
                        <form action="admin_users" method="post" style="display:inline;" 
                              onsubmit="return confirm('Are you sure?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                            <button type="submit" class="btn-delete">Delete</button>
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