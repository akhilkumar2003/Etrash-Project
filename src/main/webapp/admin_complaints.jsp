<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.Complaint" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Management - E-Trash</title>
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
                <li><a href="admin_complaints" class="active">Complaints</a></li>
                <li><a href="admin_reports">Reports</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Complaint Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Complaint Type</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <%
                List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                if (complaints != null && !complaints.isEmpty()) {
                    for (Complaint complaint : complaints) {
                %>
                <tr>
                    <td><%= complaint.getComplaintId() %></td>
                    <td><%= complaint.getUserId() %></td>
                    <td><%= complaint.getComplaintType() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td><%= complaint.getStatus() %></td>
                    <td>
                        <% if ("Pending".equals(complaint.getStatus())) { %>
                            <form action="admin_complaints" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="resolve">
                                <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
                                <button type="submit" class="btn-activate">Resolve</button>
                            </form>
                        <% } else { %>
                            <span class="badge-resolved">Resolved</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align:center;">No complaints found</td>
                </tr>
                <%
                }
                %>
            </table>
        </div>
    </div>
</body>
</html>
