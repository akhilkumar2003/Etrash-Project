<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.PickupRequest" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Pickups - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash User</h2>
            <ul>
                <li><a href="user_dashboard.jsp">Dashboard</a></li>
                <li><a href="pickup_request" class="active">Request Pickup</a></li>
                <li><a href="my_pickups">My Pickups</a></li>
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
            <h1>Request Pickup</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <div class="pickup-form">
                <form action="pickup_request" method="post">
                    <div class="form-group">
                        <label>Plastic Type:</label>
                        <select name="plasticType" required>
                            <option value="">Select Type</option>
                            <option value="PET">PET (Bottles)</option>
                            <option value="HDPE">HDPE (Containers)</option>
                            <option value="PVC">PVC (Pipes)</option>
                            <option value="LDPE">LDPE (Bags)</option>
                            <option value="PP">PP (Packaging)</option>
                            <option value="PS">PS (Styrofoam)</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Quantity (kg):</label>
                        <input type="number" name="quantity" step="0.1" min="0.1" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Pickup Date:</label>
                        <input type="date" name="pickupDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Pickup Time:</label>
                        <input type="time" name="pickupTime" required>
                    </div>
                    
                    <button type="submit" class="btn">Request Pickup</button>
                </form>
            </div>
            
            <h2>My Pickup Requests</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Plastic Type</th>
                    <th>Quantity</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>QR Code</th>
                    <th>Status</th>
                </tr>
                <%
                List<PickupRequest> requests = (List<PickupRequest>) request.getAttribute("requests");
                if (requests != null) {
                    for (PickupRequest req : requests) {
                %>
                <tr>
                    <td><%= req.getPickupId() %></td>
                    <td><%= req.getPlasticType() %></td>
                    <td><%= req.getQuantity() %> kg</td>
                    <td><%= req.getPickupDate() %></td>
                    <td><%= req.getPickupTime() %></td>
                    <td><%= req.getQrCode() %></td>
                    <td><%= req.getStatus() %></td>
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