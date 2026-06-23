<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Purchases - Industry</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Industry</h2>
            <ul>
                <li><a href="industry_dashboard.jsp">Dashboard</a></li>
                <li><a href="industry_marketplace">Marketplace</a></li>
                <li><a href="industry_purchases">My Purchases</a></li>
                <li><a href="industry_profile">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>My Purchase History</h1>
            
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card">
                    <h3>Total Purchases</h3>
                    <p class="stat-number"><%= request.getAttribute("totalPurchases") != null ? request.getAttribute("totalPurchases") : 0 %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Quantity</h3>
                    <p class="stat-number"><%= request.getAttribute("totalQuantity") != null ? String.format("%.2f", request.getAttribute("totalQuantity")) : "0.00" %> kg</p>
                </div>
                <div class="stat-card">
                    <h3>Total Amount</h3>
                    <p class="stat-number">₹<%= request.getAttribute("totalAmount") != null ? String.format("%.2f", request.getAttribute("totalAmount")) : "0.00" %></p>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Plastic Type</th>
                        <th>Quantity (kg)</th>
                        <th>Price (₹/kg)</th>
                        <th>Total (₹)</th>
                        <th>Purchase Date</th>
                    </tr>
                </thead>
                <tbody>
                <%
                List<Map<String, Object>> purchases = (List<Map<String, Object>>) request.getAttribute("purchases");
                if (purchases != null && !purchases.isEmpty()) {
                    for (Map<String, Object> purchase : purchases) {
                        double price = (double) purchase.get("price");
                        double quantity = (double) purchase.get("quantity");
                        double total = price * quantity;
                %>
                <tr>
                    <td><%= purchase.get("orderId") %></td>
                    <td><%= purchase.get("plasticType") %></td>
                    <td><%= String.format("%.2f", quantity) %></td>
                    <td>₹<%= String.format("%.2f", price) %></td>
                    <td>₹<%= String.format("%.2f", total) %></td>
                    <td><%= purchase.get("purchaseDate") %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px;">
                        <p>No purchase history yet. Visit the <a href="industry_marketplace">marketplace</a> to make your first purchase.</p>
                    </td>
                </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>