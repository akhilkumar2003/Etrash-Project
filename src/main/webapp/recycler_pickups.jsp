<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.PickupRequest" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assigned Pickups - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Recycler</h2>
            <ul>
                <li><a href="recycler_dashboard.jsp">Dashboard</a></li>
                <li><a href="recycler_pickups">Assigned Pickups</a></li>
                <li><a href="recycler_history">Collection History</a></li>
                <li><a href="recycler_profile">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Assigned Pickups</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Plastic Type</th>
                    <th>Expected Qty</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>QR Code</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <%
                List<PickupRequest> pickups = (List<PickupRequest>) request.getAttribute("pickups");
                if (pickups != null && !pickups.isEmpty()) {
                    for (PickupRequest req : pickups) {
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
                        <% if ("Assigned".equals(req.getStatus())) { %>
                            <form action="recycler_pickups" method="post" style="display:inline;">
                                <input type="hidden" name="qrCode" value="<%= req.getQrCode() %>">
                                <input type="number" name="collectedQuantity" step="0.01" min="0.1" 
                                       placeholder="Actual Qty" required style="width:80px;">
                                <button type="submit">Complete</button>
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
                    <td colspan="8" style="text-align:center;">No assigned pickups</td>
                </tr>
                <%
                }
                %>
            </table>
        </div>
    </div>
</body>
</html>