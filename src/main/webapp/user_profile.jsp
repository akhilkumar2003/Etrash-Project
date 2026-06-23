<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - E-Trash</title>
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
            <h1>My Profile</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <%
            User user = (User) request.getAttribute("user");
            if (user != null) {
            %>
            
            <div class="profile-info">
                <div class="info-group">
                    <label>Name:</label>
                    <span><%= user.getName() %></span>
                </div>
                
                <div class="info-group">
                    <label>Email:</label>
                    <span><%= user.getEmail() %></span>
                </div>
                
                <div class="info-group">
                    <label>Phone:</label>
                    <span><%= user.getPhone() %></span>
                </div>
                
                <div class="info-group">
                    <label>Address:</label>
                    <span><%= user.getAddress() %></span>
                </div>
                
                <div class="info-group">
                    <label>Status:</label>
                    <span class="status-badge <%= user.getStatus().toLowerCase() %>"><%= user.getStatus() %></span>
                </div>
            </div>
            
            <div class="profile-actions">
                <button onclick="showEditForm()" class="btn">Edit Profile</button>
                <button onclick="showChangePasswordForm()" class="btn">Change Password</button>
            </div>
            
            <!-- Edit Profile Form (Hidden by default) -->
            <div id="editProfileForm" style="display:none;" class="profile-form">
                <h2>Edit Profile</h2>
                <form action="user_profile" method="post" onsubmit="return validateForm('editForm')" id="editForm">
                    <input type="hidden" name="action" value="update">
                    
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" name="name" value="<%= user.getName() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone:</label>
                        <input type="text" name="phone" value="<%= user.getPhone() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Address:</label>
                        <textarea name="address" required><%= user.getAddress() %></textarea>
                    </div>
                    
                    <button type="submit" class="btn">Save Changes</button>
                    <button type="button" onclick="hideEditForm()" class="btn">Cancel</button>
                </form>
            </div>
            
            <!-- Change Password Form (Hidden by default) -->
            <div id="changePasswordForm" style="display:none;" class="profile-form">
                <h2>Change Password</h2>
                <form action="user_profile" method="post" onsubmit="return validatePasswordForm()" id="passwordForm">
                    <input type="hidden" name="action" value="changepassword">
                    
                    <div class="form-group">
                        <label>Current Password:</label>
                        <input type="password" name="currentPassword" required>
                    </div>
                    
                    <div class="form-group">
                        <label>New Password:</label>
                        <input type="password" name="newPassword" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password:</label>
                        <input type="password" name="confirmPassword" required>
                    </div>
                    
                    <button type="submit" class="btn">Change Password</button>
                    <button type="button" onclick="hidePasswordForm()" class="btn">Cancel</button>
                </form>
            </div>
            
            <% } %>
            
            <style>
                .profile-info {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                    margin-bottom: 20px;
                }
                
                .info-group {
                    margin-bottom: 15px;
                    display: flex;
                    align-items: center;
                }
                
                .info-group label {
                    width: 120px;
                    font-weight: bold;
                    color: #555;
                }
                
                .info-group span {
                    flex: 1;
                    color: #333;
                }
                
                .status-badge {
                    padding: 5px 10px;
                    border-radius: 5px;
                    font-size: 14px;
                }
                
                .status-badge.approved {
                    background: #d4edda;
                    color: #155724;
                }
                
                .status-badge.pending {
                    background: #fff3cd;
                    color: #856404;
                }
                
                .profile-actions {
                    margin-bottom: 20px;
                }
                
                .profile-actions button {
                    margin-right: 10px;
                }
                
                .profile-form {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                    margin-top: 20px;
                }
            </style>
            
            <script>
                function showEditForm() {
                    document.getElementById('editProfileForm').style.display = 'block';
                    document.getElementById('changePasswordForm').style.display = 'none';
                }
                
                function hideEditForm() {
                    document.getElementById('editProfileForm').style.display = 'none';
                }
                
                function showChangePasswordForm() {
                    document.getElementById('changePasswordForm').style.display = 'block';
                    document.getElementById('editProfileForm').style.display = 'none';
                }
                
                function hidePasswordForm() {
                    document.getElementById('changePasswordForm').style.display = 'none';
                }
                
                function validatePasswordForm() {
                    var newPass = document.getElementsByName('newPassword')[0].value;
                    var confirmPass = document.getElementsByName('confirmPassword')[0].value;
                    
                    if (newPass.length < 6) {
                        alert('Password must be at least 6 characters');
                        return false;
                    }
                    
                    if (newPass !== confirmPass) {
                        alert('Passwords do not match');
                        return false;
                    }
                    
                    return true;
                }
            </script>
        </div>
    </div>
</body>
</html>