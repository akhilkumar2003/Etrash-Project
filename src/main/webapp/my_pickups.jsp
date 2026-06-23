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
                <li><a href="pickup_request">Request Pickup</a></li>
                <li><a href="my_pickups" class="active">My Pickups</a></li>
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
            <h1>My Pickup Requests</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Plastic Type</th>
                    <th>Quantity</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>QR Code</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <%
                List<PickupRequest> requests = (List<PickupRequest>) request.getAttribute("requests");
                if (requests != null && !requests.isEmpty()) {
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
                    <td>
                        <% if ("Pending".equals(req.getStatus())) { %>
                            <form action="my_pickups" method="post" style="display:inline;" 
                                  onsubmit="return confirm('Are you sure you want to delete this pickup request?')">
                                <input type="hidden" name="pickupId" value="<%= req.getPickupId() %>">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        <% } else if ("Assigned".equals(req.getStatus())) { %>
                            <form action="my_pickups" method="post" style="display:inline;" 
                                  onsubmit="return confirm('Cancel this pickup request?')">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="pickupId" value="<%= req.getPickupId() %>">
                                <button type="submit" class="btn-cancel">Cancel</button>
                            </form>
                        <% } else { %>
                            <span>-</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" style="text-align:center;">No pickup requests found</td>
                </tr>
                <%
                }
                %>
            </table>
        </div>
    </div>
</body>
</html>
