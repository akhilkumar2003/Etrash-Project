<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.Complaint" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaints - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash User</h2>
            <ul>
                <li><a href="user_dashboard.jsp">Dashboard</a></li>
                <li><a href="pickup_request">Request Pickup</a></li>
                <li><a href="pickup_request">My Pickups</a></li>
                <li><a href="user_rewards">My Rewards</a></li>
                <li><a href="user_centers">Recycling Centers</a></li>
                <li><a href="user_campaigns">Campaigns</a></li>
                <li><a href="volunteer">Volunteer</a></li>
                <li><a href="leaderboard">Leaderboard</a></li>
                <li><a href="user_marketplace">Marketplace</a></li>
                <li><a href="user_complaints">Complaints</a></li>
                <li><a href="user_profile">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Complaints & Feedback</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <div class="complaint-form">
                <h2>Submit Complaint</h2>
                <form action="user_complaints" method="post" onsubmit="return validateForm('complaintForm')" id="complaintForm">
                    <div class="form-group">
                        <label>Complaint Type:</label>
                        <select name="complaintType" required>
                            <option value="">Select Type</option>
                            <option value="Missed Pickup">Missed Pickup</option>
                            <option value="Late Collection">Late Collection</option>
                            <option value="Incorrect Rewards">Incorrect Rewards</option>
                            <option value="Recycler Behavior">Recycler Behavior</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Description:</label>
                        <textarea name="description" rows="5" required placeholder="Please describe your complaint in detail..."></textarea>
                    </div>
                    
                    <button type="submit" class="btn">Submit Complaint</button>
                </form>
            </div>
            
            <h2>My Complaints</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Status</th>
                </tr>
                <%
                List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                if (complaints != null) {
                    for (Complaint complaint : complaints) {
                %>
                <tr>
                    <td><%= complaint.getComplaintId() %></td>
                    <td><%= complaint.getComplaintType() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td><%= complaint.getStatus() %></td>
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