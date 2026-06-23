<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.CampaignEvent, model.EventVolunteer" %>
<!DOCTYPE html>
<html>
<head>
    <title>Campaign Management - E-Trash</title>
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
            <h1>Campaign Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <h2>Add New Campaign</h2>
            <form action="admin_campaigns" method="post">
                <input type="hidden" name="action" value="add">
                <label>Campaign Name: <input type="text" name="eventName" required></label><br>
                <label>Description: <textarea name="description" required></textarea></label><br>
                <label>Date: <input type="date" name="eventDate" required></label><br>
                <button type="submit">Create Campaign</button>
            </form>
            
            <h2>Existing Campaigns</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Volunteers</th>
                    <th>Actions</th>
                </tr>
                <%
                List<CampaignEvent> events = (List<CampaignEvent>) request.getAttribute("events");
                if (events != null) {
                    for (CampaignEvent event : events) {
                        Integer volunteerCount = (Integer) request.getAttribute("volunteerCount_" + event.getEventId());
                %>
                <tr>
                    <td><%= event.getEventId() %></td>
                    <td><%= event.getEventName() %></td>
                    <td><%= event.getDescription() %></td>
                    <td><%= event.getEventDate() %></td>
                    <td><%= volunteerCount != null ? volunteerCount : 0 %></td>
                    <td>
                        <a href="admin_campaigns?action=view&eventId=<%= event.getEventId() %>">View Volunteers</a>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </table>
            
            <% 
            List<EventVolunteer> volunteers = (List<EventVolunteer>) request.getAttribute("volunteers");
            if (volunteers != null && !volunteers.isEmpty()) { 
            %>
            <h2>Volunteers for Selected Campaign</h2>
            <table>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
                <% for (EventVolunteer vol : volunteers) { %>
                <tr>
                    <td><%= vol.getUserId() %></td>
                    <td><%= vol.getUserName() %></td>
                    <td><%= vol.getUserEmail() %></td>
                    <td><%= vol.getUserPhone() %></td>
                </tr>
                <% } %>
            </table>
            <% } %>
        </div>
    </div>
</body>
</html>