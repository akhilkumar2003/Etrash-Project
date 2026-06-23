<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.CampaignEvent" %>
<!DOCTYPE html>
<html>
<head>
    <title>Campaigns - E-Trash</title>
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
            <h1>Recycling Campaigns & Events</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <div class="campaign-grid">
                <%
                List<CampaignEvent> events = (List<CampaignEvent>) request.getAttribute("events");
                if (events != null) {
                    for (CampaignEvent event : events) {
                %>
                <div class="campaign-card">
                    <h3><%= event.getEventName() %></h3>
                    <p class="event-date">Date: <%= event.getEventDate() %></p>
                    <p class="event-description"><%= event.getDescription() %></p>
                    <form action="user_campaigns" method="post">
                        <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                        <button type="submit" class="btn">Register as Volunteer</button>
                    </form>
                </div>
                <%
                    }
                }
                %>
            </div>
            
            <style>
                .campaign-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                    gap: 20px;
                    margin-top: 20px;
                }
                
                .campaign-card {
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                }
                
                .campaign-card h3 {
                    color: #2c3e50;
                    margin-bottom: 10px;
                }
                
                .event-date {
                    color: #667eea;
                    font-weight: bold;
                    margin-bottom: 10px;
                }
                
                .event-description {
                    color: #666;
                    margin-bottom: 15px;
                    line-height: 1.5;
                }
            </style>
        </div>
    </div>
</body>
</html>