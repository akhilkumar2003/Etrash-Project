<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.MarketplaceListing" %>
<!DOCTYPE html>
<html>
<head>
    <title>Marketplace - Industry</title>
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
            <h1>Plastic Waste Marketplace</h1>
            
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
            
            <div class="search-filter">
                <input type="text" id="searchInput" placeholder="Search by plastic type..." onkeyup="filterListings()">
                <select id="typeFilter" onchange="filterListings()">
                    <option value="">All Types</option>
                    <option value="PET">PET</option>
                    <option value="HDPE">HDPE</option>
                    <option value="PVC">PVC</option>
                    <option value="LDPE">LDPE</option>
                    <option value="PP">PP</option>
                    <option value="PS">PS</option>
                </select>
            </div>
            
            <table id="listingsTable">
                <tr>
                    <th>Plastic Type</th>
                    <th>Quantity (kg)</th>
                    <th>Price (₹/kg)</th>
                    <th>Seller Type</th>
                    <th>Action</th>
                </tr>
                <%
                List<MarketplaceListing> listings = (List<MarketplaceListing>) request.getAttribute("listings");
                if (listings != null) {
                    for (MarketplaceListing listing : listings) {
                %>
                <tr data-type="<%= listing.getPlasticType() %>">
                    <td><%= listing.getPlasticType() %></td>
                    <td><%= listing.getQuantity() %> kg</td>
                    <td>₹<%= listing.getPrice() %></td>
                    <td><%= listing.getSellerType() %></td>
                    <td>
                        <% if (listing.getQuantity() > 0) { %>
                            <form action="industry_marketplace" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="purchase">
                                <input type="hidden" name="listingId" value="<%= listing.getListingId() %>">
                                <button type="submit" class="btn">Purchase</button>
                            </form>
                        <% } else { %>
                            <span class="sold-out">Sold Out</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </table>
            
            <!-- Purchase Modal -->
            <div id="purchaseModal" style="display:none;" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h2>Purchase Plastic</h2>
                    <form action="industry_marketplace" method="post" id="purchaseForm">
                        <input type="hidden" name="action" value="buy">
                        <input type="hidden" name="listingId" id="modalListingId">
                        
                        <div class="form-group">
                            <label>Available Quantity:</label>
                            <span id="availableQuantity"></span> kg
                        </div>
                        
                        <div class="form-group">
                            <label>Price per kg:</label>
                            <span id="pricePerKg"></span> ₹
                        </div>
                        
                        <div class="form-group">
                            <label>Quantity to Purchase (kg):</label>
                            <input type="number" name="quantity" id="purchaseQuantity" step="0.1" min="0.1" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Total Cost:</label>
                            <span id="totalCost">0</span> ₹
                        </div>
                        
                        <button type="submit" class="btn">Confirm Purchase</button>
                        <button type="button" onclick="closeModal()" class="btn">Cancel</button>
                    </form>
                </div>
            </div>
            
            <style>
                .search-filter {
                    margin-bottom: 20px;
                    display: flex;
                    gap: 10px;
                }
                
                .search-filter input, .search-filter select {
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }
                
                .search-filter input {
                    flex: 1;
                }
                
                .modal {
                    position: fixed;
                    z-index: 1;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0,0,0,0.5);
                }
                
                .modal-content {
                    background-color: white;
                    margin: 15% auto;
                    padding: 20px;
                    border-radius: 10px;
                    width: 50%;
                    max-width: 500px;
                }
                
                .close {
                    float: right;
                    font-size: 28px;
                    font-weight: bold;
                    cursor: pointer;
                }
                
                .close:hover {
                    color: #666;
                }
            </style>
            
            <script>
                function filterListings() {
                    var searchInput = document.getElementById("searchInput").value.toUpperCase();
                    var typeFilter = document.getElementById("typeFilter").value;
                    var table = document.getElementById("listingsTable");
                    var rows = table.getElementsByTagName("tr");
                    
                    for (var i = 1; i < rows.length; i++) {
                        var type = rows[i].getAttribute("data-type");
                        var text = rows[i].getElementsByTagName("td")[0].textContent.toUpperCase();
                        
                        var matchesSearch = text.indexOf(searchInput) > -1;
                        var matchesType = !typeFilter || type === typeFilter;
                        
                        rows[i].style.display = matchesSearch && matchesType ? "" : "none";
                    }
                }
                
                function showPurchaseForm(listingId, quantity, price) {
                    document.getElementById("modalListingId").value = listingId;
                    document.getElementById("availableQuantity").textContent = quantity;
                    document.getElementById("pricePerKg").textContent = price;
                    document.getElementById("purchaseModal").style.display = "block";
                    
                    var quantityInput = document.getElementById("purchaseQuantity");
                    quantityInput.max = quantity;
                    quantityInput.oninput = function() {
                        var qty = parseFloat(this.value) || 0;
                        var total = qty * price;
                        document.getElementById("totalCost").textContent = total.toFixed(2);
                    };
                }
                
                function closeModal() {
                    document.getElementById("purchaseModal").style.display = "none";
                }
                
                window.onclick = function(event) {
                    var modal = document.getElementById("purchaseModal");
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            </script>
        </div>
    </div>
</body>
</html>