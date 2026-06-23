<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.IndustryBuyer, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Industry Profile - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        /* Additional styles specific to industry profile */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            font-size: 14px;
            margin-bottom: 10px;
            opacity: 0.9;
        }
        
        .stat-card p {
            font-size: 28px;
            font-weight: bold;
        }
        
        .message {
            padding: 15px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            animation: slideDown 0.5s ease-out;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .message.info {
            background: #cce5ff;
            color: #004085;
            border: 1px solid #b8daff;
        }
        
        @keyframes slideDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .profile-info {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .info-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .info-group:last-child {
            border-bottom: none;
        }
        
        .info-group label {
            width: 150px;
            font-weight: bold;
            color: #555;
        }
        
        .info-group span {
            flex: 1;
            color: #333;
        }
        
        .profile-actions {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        
        .profile-actions button {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .profile-actions button:first-child {
            background: #667eea;
            color: white;
        }
        
        .profile-actions button:first-child:hover {
            background: #5a67d8;
        }
        
        .profile-actions button:last-child {
            background: #48bb78;
            color: white;
        }
        
        .profile-actions button:last-child:hover {
            background: #38a169;
        }
        
        .profile-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            animation: slideDown 0.5s ease-out;
        }
        
        .profile-form h2 {
            margin-bottom: 20px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group input[type="password"] {
            font-family: monospace;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            transition: all 0.3s;
        }
        
        .btn[type="submit"] {
            background: #667eea;
            color: white;
        }
        
        .btn[type="submit"]:hover {
            background: #5a67d8;
        }
        
        .btn[type="button"] {
            background: #a0aec0;
            color: white;
        }
        
        .btn[type="button"]:hover {
            background: #718096;
        }
        
        .purchase-history {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-top: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .purchase-history h2 {
            margin-bottom: 20px;
            color: #333;
        }
        
        .purchase-history table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .purchase-history th {
            background: #f7fafc;
            color: #4a5568;
            font-weight: 600;
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .purchase-history td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .purchase-history tr:hover {
            background: #f7fafc;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge.success {
            background: #c6f6d5;
            color: #22543d;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Industry</h2>
            <ul>
                <li><a href="industry_dashboard.jsp">Dashboard</a></li>
                <li><a href="industry_marketplace">Marketplace</a></li>
                <li><a href="industry_purchases">My Purchases</a></li>
                <li><a href="industry_profile" class="active">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>My Profile</h1>
            
            <!-- Message Display Section -->
            <% if (request.getAttribute("message") != null) { %>
                <div class="message <%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "info" %>">
                    <strong>
                        <% if ("success".equals(request.getAttribute("messageType"))) { %>
                            ✅ 
                        <% } else if ("error".equals(request.getAttribute("messageType"))) { %>  
                            ❌ 
                        <% } else { %>
                            ℹ️ 
                        <% } %>
                    </strong>
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <%
            IndustryBuyer buyer = (IndustryBuyer) request.getAttribute("buyer");
            Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
            List<Map<String, Object>> purchases = (List<Map<String, Object>>) request.getAttribute("purchases");
            
            if (buyer != null) {
            %>
            
            <!-- Statistics Section -->
            <div class="stats-section">
                <div class="stat-card">
                    <h3>Total Purchases</h3>
                    <p><%= stats != null ? stats.get("totalOrders") : "0" %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Quantity</h3>
                    <p><%= stats != null ? stats.get("totalQuantity") : "0" %> kg</p>
                </div>
                <div class="stat-card">
                    <h3>Total Spent</h3>
                    <p>Rs. <%= stats != null ? stats.get("totalSpent") : "0" %></p>
                </div>
            </div>
            
            <!-- Profile Information -->
            <div class="profile-info">
                <h2>Profile Information</h2>
                <div class="info-group">
                    <label>Industry Name:</label>
                    <span><%= buyer.getIndustryName() %></span>
                </div>
                
                <div class="info-group">
                    <label>Contact Person:</label>
                    <span><%= buyer.getContactPerson() %></span>
                </div>
                
                <div class="info-group">
                    <label>Phone:</label>
                    <span><%= buyer.getPhone() %></span>
                </div>
                
                <div class="info-group">
                    <label>Member Since:</label>
                    <span><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="profile-actions">
                <button onclick="showEditForm()" class="btn">✏️ Edit Profile</button>
                <button onclick="showChangePasswordForm()" class="btn">🔒 Change Password</button>
            </div>
            
            <!-- Edit Profile Form -->
            <div id="editProfileForm" style="display:none;" class="profile-form">
                <h2>✏️ Edit Profile</h2>
                <form action="industry_profile" method="post" onsubmit="return validateEditForm()">
                    <input type="hidden" name="action" value="update">
                    
                    <div class="form-group">
                        <label>Industry Name:</label>
                        <input type="text" name="industryName" value="<%= buyer.getIndustryName() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Contact Person:</label>
                        <input type="text" name="contactPerson" value="<%= buyer.getContactPerson() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone:</label>
                        <input type="text" name="phone" value="<%= buyer.getPhone() %>" required pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
                    </div>
                    
                    <button type="submit" class="btn">Save Changes</button>
                    <button type="button" onclick="hideEditForm()" class="btn">Cancel</button>
                </form>
            </div>
            
            <!-- Change Password Form -->
            <div id="changePasswordForm" style="display:none;" class="profile-form">
                <h2>🔒 Change Password</h2>
                <form action="industry_profile" method="post" onsubmit="return validatePasswordForm()">
                    <input type="hidden" name="action" value="changepassword">
                    
                    <div class="form-group">
                        <label>Current Password:</label>
                        <input type="password" name="currentPassword" required>
                    </div>
                    
                    <div class="form-group">
                        <label>New Password:</label>
                        <input type="password" name="newPassword" required minlength="6">
                        <small style="color: #666;">Minimum 6 characters</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password:</label>
                        <input type="password" name="confirmPassword" required minlength="6">
                    </div>
                    
                    <button type="submit" class="btn">Change Password</button>
                    <button type="button" onclick="hidePasswordForm()" class="btn">Cancel</button>
                </form>
            </div>
            
            <!-- Recent Purchases -->
            <% if (purchases != null && !purchases.isEmpty()) { %>
            <div class="purchase-history">
                <h2>Recent Purchases</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Plastic Type</th>
                            <th>Quantity</th>
                            <th>Price/kg</th>
                            <th>Total</th>
                            <th>Seller</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        int count = 0;
                        for (Map<String, Object> purchase : purchases) { 
                            if (count++ >= 5) break; // Show only last 5 purchases
                        %>
                        <tr>
                            <td>#<%= purchase.get("orderId") %></td>
                            <td><%= purchase.get("plasticType") %></td>
                            <td><%= purchase.get("quantity") %> kg</td>
                            <td>₹<%= purchase.get("price") %></td>
                            <td>₹<%= purchase.get("total") %></td>
                            <td>
                                <span class="badge success">
                                    <%= purchase.get("sellerType") %>: <%= purchase.get("sellerName") %>
                                </span>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% if (purchases.size() > 5) { %>
                    <p style="text-align: right; margin-top: 10px;">
                        <a href="industry_purchases">View all purchases →</a>
                    </p>
                <% } %>
            </div>
            <% } %>
            
            <% } else { %>
                <div class="message error">Unable to load profile information</div>
            <% } %>
        </div>
    </div>
    
    <script>
        // Form validation functions
        function validateEditForm() {
            var phone = document.getElementsByName('phone')[0].value;
            var phonePattern = /^\d{10}$/;
            
            if (!phonePattern.test(phone)) {
                alert('Please enter a valid 10-digit phone number');
                return false;
            }
            return true;
        }
        
        function validatePasswordForm() {
            var newPass = document.getElementsByName('newPassword')[0].value;
            var confirmPass = document.getElementsByName('confirmPassword')[0].value;
            
            if (newPass.length < 6) {
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            if (newPass !== confirmPass) {
                alert('New passwords do not match');
                return false;
            }
            
            // Check password strength
            var hasUpperCase = /[A-Z]/.test(newPass);
            var hasLowerCase = /[a-z]/.test(newPass);
            var hasNumbers = /\d/.test(newPass);
            var hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(newPass);
            
            if (!(hasUpperCase && hasLowerCase && hasNumbers)) {
                if (!confirm('Password should contain uppercase, lowercase, and numbers for better security. Continue anyway?')) {
                    return false;
                }
            }
            
            return true;
        }
        
        // Toggle form visibility
        function showEditForm() {
            document.getElementById('editProfileForm').style.display = 'block';
            document.getElementById('changePasswordForm').style.display = 'none';
            // Scroll to form
            document.getElementById('editProfileForm').scrollIntoView({ behavior: 'smooth' });
        }
        
        function hideEditForm() {
            document.getElementById('editProfileForm').style.display = 'none';
        }
        
        function showChangePasswordForm() {
            document.getElementById('changePasswordForm').style.display = 'block';
            document.getElementById('editProfileForm').style.display = 'none';
            // Scroll to form
            document.getElementById('changePasswordForm').scrollIntoView({ behavior: 'smooth' });
        }
        
        function hidePasswordForm() {
            document.getElementById('changePasswordForm').style.display = 'none';
        }
        
        // Auto-hide messages after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            var messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                setTimeout(function() {
                    message.style.transition = 'opacity 0.5s';
                    message.style.opacity = '0';
                    setTimeout(function() {
                        if (message.parentNode) {
                            message.style.display = 'none';
                        }
                    }, 500);
                }, 5000);
            });
        });
        
        // Add active class to current menu item
        document.addEventListener('DOMContentLoaded', function() {
            var currentLocation = window.location.pathname;
            var menuItems = document.querySelectorAll('.sidebar ul li a');
            menuItems.forEach(function(item) {
                if (item.getAttribute('href') === 'industry_profile') {
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>