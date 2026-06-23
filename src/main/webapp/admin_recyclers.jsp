<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.Recycler" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recycler Management - E-Trash</title>
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
            <h1>Recycler Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Service Area</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <%
                List<Recycler> recyclers = (List<Recycler>) request.getAttribute("recyclers");
                if (recyclers != null) {
                    for (Recycler recycler : recyclers) {
                %>
                <tr>
                    <td><%= recycler.getRecyclerId() %></td>
                    <td><%= recycler.getName() %></td>
                    <td><%= recycler.getPhone() %></td>
                    <td><%= recycler.getServiceArea() %></td>
                    <td><%= recycler.getStatus() %></td>
                    <td>
                        <% if ("Active".equals(recycler.getStatus())) { %>
                            <form action="admin_recyclers" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="recyclerId" value="<%= recycler.getRecyclerId() %>">
                                <button type="submit" class="btn-deactivate">Deactivate</button>
                            </form>
                        <% } else { %>
                            <form action="admin_recyclers" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="recyclerId" value="<%= recycler.getRecyclerId() %>">
                                <button type="submit" class="btn-activate">Activate</button>
                            </form>
                        <% } %>
                        <form action="admin_recyclers" method="post" style="display:inline;" 
                              onsubmit="return confirm('Are you sure?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="recyclerId" value="<%= recycler.getRecyclerId() %>">
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