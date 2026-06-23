<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Industry Dashboard - E-Trash</title>
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
            <h1>Welcome, <%= session.getAttribute("industryName") %></h1>
            
            <div class="stats">
                <div class="stat-box">
                    <h3>Total Purchases</h3>
                    <p><%= request.getAttribute("totalPurchases") != null ? request.getAttribute("totalPurchases") : "0" %></p>
                </div>
                <div class="stat-box">
                    <h3>Plastic Purchased</h3>
                    <p><%= request.getAttribute("totalPlastic") != null ? request.getAttribute("totalPlastic") : "0" %> kg</p>
                </div>
                <div class="stat-box">
                    <h3>Active Listings</h3>
                    <p><%= request.getAttribute("activeListings") != null ? request.getAttribute("activeListings") : "0" %></p>
                </div>
            </div>
            
            <div class="recent-listings">
                <h2>Recent Marketplace Listings</h2>
                <table>
                    <tr>
                        <th>Plastic Type</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Seller</th>
                        <th>Action</th>
                    </tr>
                    <%
                    List<model.MarketplaceListing> listings = (List<model.MarketplaceListing>) request.getAttribute("recentListings");
                    if (listings != null) {
                        for (model.MarketplaceListing listing : listings) {
                    %>
                    <tr>
                        <td><%= listing.getPlasticType() %></td>
                        <td><%= listing.getQuantity() %> kg</td>
                        <td>₹<%= listing.getPrice() %>/kg</td>
                        <td><%= listing.getSellerType() %></td>
                        <td><a href="industry_marketplace?action=buy&id=<%= listing.getListingId() %>" class="btn">Buy</a></td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
        </div>
    </div>
</body>
</html>