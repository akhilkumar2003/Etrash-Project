<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.CampaignEvent" %>
<!DOCTYPE html>
<html>
<head>
    <title>Volunteer for Events - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash User</h2>
            <ul>
                <li><a href="user_dashboard.jsp">📊 Dashboard</a></li>
                <li><a href="pickup_request">📦 Request Pickup</a></li>
                <li><a href="pickup_request">📋 My Pickups</a></li>
                <li><a href="user_rewards">🏆 My Rewards</a></li>
                <li><a href="user_centers">📍 Recycling Centers</a></li>
                <li><a href="user_campaigns">📢 Campaigns</a></li>
                <li><a href="volunteer" class="active">🙋 Volunteer</a></li>
                <li><a href="user_marketplace">🛒 Marketplace</a></li>
                <li><a href="user_complaints">💬 Complaints</a></li>
                <li><a href="user_profile">👤 Profile</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Volunteer for Environmental Events</h1>
            
            <div class="info-banner">
                <h3>🌿 Why Volunteer?</h3>
                <p>Join hands with fellow environmental enthusiasts to make a real difference! Volunteering at E-Trash events helps:</p>
                <ul>
                    <li>Spread awareness about proper e-waste disposal</li>
                    <li>Engage with your local community</li>
                    <li>Gain practical knowledge about recycling and sustainability</li>
                    <li>Earn additional reward points for your contributions</li>
                </ul>
            </div>
            
            <% 
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            if (message != null) { 
            %>
                <div class="success-message"><%= message %></div>
            <% } %>
            <% if (error != null) { %>
                <div class="error-message"><%= error %></div>
            <% } %>
            
            <h2>Upcoming Events</h2>
            
            <%
            List<CampaignEvent> events = (List<CampaignEvent>) request.getAttribute("events");
            if (events != null && !events.isEmpty()) {
                for (CampaignEvent event : events) {
                    String[] parts = event.getDescription().split("\\|");
                    String description = parts.length > 0 ? parts[0] : event.getDescription();
                    boolean isRegistered = parts.length > 1 && Boolean.parseBoolean(parts[1]);
                    int volunteerCount = parts.length > 2 ? Integer.parseInt(parts[2]) : 0;
            %>
            <div class="event-card">
                <div class="event-header">
                    <h3><%= event.getEventName() %></h3>
                    <span class="event-date">[Calendar] <%= event.getEventDate() %></span>
                </div>
                <div class="event-body">
                    <p><%= description %></p>
                    <div class="event-stats">
                        <span>[People] <%= volunteerCount %> volunteers registered</span>
                    </div>
                </div>
                <div class="event-footer">
                    <% if (isRegistered) { %>
                        <button class="btn-registered" disabled>[Check] Already Registered</button>
                    <% } else { %>
                        <form action="volunteer" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="register">
                            <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                            <button type="submit" class="btn">Register as Volunteer</button>
                        </form>
                    <% } %>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="empty-state">
                <p>No upcoming events at the moment. Check back later!</p>
            </div>
            <%
            }
            %>
        </div>
    </div>
    
    <style>
        .info-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
        }
        
        .info-banner h3 {
            margin-bottom: 15px;
            font-size: 1.5rem;
        }
        
        .info-banner ul {
            list-style: none;
            padding-left: 0;
        }
        
        .info-banner li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
        }
        
        .info-banner li:before {
            content: "✓";
            position: absolute;
            left: 0;
            font-weight: bold;
        }
        
        .event-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow-md);
            transition: transform 0.3s;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        
        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .event-header h3 {
            color: var(--primary-color);
            margin: 0;
        }
        
        .event-date {
            background: #e3f2fd;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            color: #1976d2;
        }
        
        .event-body p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .event-stats {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 8px;
            display: inline-block;
        }
        
        .event-footer {
            margin-top: 20px;
        }
        
        .btn-registered {
            background: #28a745;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: not-allowed;
            opacity: 0.8;
        }
        
        .empty-state {
            background: white;
            padding: 60px;
            text-align: center;
            border-radius: 15px;
            box-shadow: var(--shadow-sm);
        }
        
        .empty-state p {
            color: #666;
            font-size: 1.1rem;
        }
    </style>
</body>
</html>
