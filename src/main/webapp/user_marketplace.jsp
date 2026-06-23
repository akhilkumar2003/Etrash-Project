<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.MarketplaceListing" %>
<!DOCTYPE html>
<html>
<head>
    <title>Marketplace - E-Trash</title>
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
            <h1>Plastic Waste Marketplace</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <div class="marketplace-tabs">
                <button class="tab-btn active" onclick="showTab('listings')">Available Listings</button>
                <button class="tab-btn" onclick="showTab('sell')">Sell Plastic</button>
                <button class="tab-btn" onclick="showTab('myListings')">My Listings</button>
            </div>
            
            <!-- Available Listings Tab -->
            <div id="listings" class="tab-content active">
                <h2>Available Recyclable Materials</h2>
                <table>
                    <tr>
                        <th>Plastic Type</th>
                        <th>Quantity (kg)</th>
                        <th>Price (₹/kg)</th>
                        <th>Seller</th>
                        <th>Action</th>
                    </tr>
                    <%
                    List<MarketplaceListing> listings = (List<MarketplaceListing>) request.getAttribute("listings");
                    if (listings != null) {
                        for (MarketplaceListing listing : listings) {
                    %>
                    <tr>
                        <td><%= listing.getPlasticType() %></td>
                        <td><%= listing.getQuantity() %> kg</td>
                        <td>₹<%= listing.getPrice() %></td>
                        <td><%= listing.getSellerType() %> ID: <%= listing.getSellerId() %></td>
                        <td>
                            <form action="user_marketplace" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="buy">
                                <input type="hidden" name="listingId" value="<%= listing.getListingId() %>">
                                <input type="number" name="quantity" min="1" max="<%= listing.getQuantity() %>" placeholder="Qty" required>
                                <button type="submit">Buy</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
            
            <!-- Sell Plastic Tab -->
            <div id="sell" class="tab-content">
                <h2>Sell Recyclable Plastic</h2>
                <form action="user_marketplace" method="post" class="sell-form">
                    <input type="hidden" name="action" value="sell">
                    
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
                        <label>Price per kg (₹):</label>
                        <input type="number" name="price" step="0.5" min="0" required>
                    </div>
                    
                    <button type="submit" class="btn">List for Sale</button>
                </form>
            </div>
            
            <!-- My Listings Tab -->
            <div id="myListings" class="tab-content">
                <h2>My Marketplace Listings</h2>
                <table>
                    <tr>
                        <th>Plastic Type</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <%
                    List<MarketplaceListing> myListings = (List<MarketplaceListing>) request.getAttribute("myListings");
                    if (myListings != null) {
                        for (MarketplaceListing listing : myListings) {
                    %>
                    <tr>
                        <td><%= listing.getPlasticType() %></td>
                        <td><%= listing.getQuantity() %> kg</td>
                        <td>₹<%= listing.getPrice() %></td>
                        <td>Available</td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
            
            <style>
                .marketplace-tabs {
                    margin-bottom: 20px;
                }
                
                .tab-btn {
                    padding: 10px 20px;
                    background: #e0e0e0;
                    border: none;
                    cursor: pointer;
                    margin-right: 5px;
                }
                
                .tab-btn.active {
                    background: #667eea;
                    color: white;
                }
                
                .tab-content {
                    display: none;
                }
                
                .tab-content.active {
                    display: block;
                }
                
                .sell-form {
                    max-width: 500px;
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                }
            </style>
            
            <script>
                function showTab(tabName) {
                    var tabs = document.getElementsByClassName('tab-content');
                    for (var i = 0; i < tabs.length; i++) {
                        tabs[i].classList.remove('active');
                    }
                    
                    var buttons = document.getElementsByClassName('tab-btn');
                    for (var i = 0; i < buttons.length; i++) {
                        buttons[i].classList.remove('active');
                    }
                    
                    document.getElementById(tabName).classList.add('active');
                    event.target.classList.add('active');
                }
            </script>
        </div>
    </div>
</body>
</html>