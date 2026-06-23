<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.Recycler" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recycler Profile - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Recycler</h2>
            <ul>
                <li><a href="recycler_dashboard.jsp">📊 Dashboard</a></li>
                <li><a href="recycler_pickups">📦 Assigned Pickups</a></li>
                <li><a href="recycler_history">📜 Collection History</a></li>
                <li><a href="recycler_profile" class="active">👤 Profile</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Recycler Profile</h1>
            
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
            
            <% Recycler recycler = (Recycler) request.getAttribute("recycler"); %>
            
            <div class="profile-container">
                <!-- Profile Information -->
                <div class="profile-section">
                    <h2>Profile Information</h2>
                    <form action="recycler_profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        
                        <div class="form-group">
                            <label>Name:</label>
                            <input type="text" name="name" value="<%= recycler != null ? recycler.getName() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Phone:</label>
                            <input type="text" name="phone" value="<%= recycler != null ? recycler.getPhone() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Status:</label>
                            <input type="text" value="<%= recycler != null ? recycler.getStatus() : "" %>" disabled>
                        </div>
                        
                        <button type="submit" class="btn">Update Profile</button>
                    </form>
                </div>
                
                <!-- Change Password -->
                <div class="profile-section">
                    <h2>Change Password</h2>
                    <form action="recycler_profile" method="post">
                        <input type="hidden" name="action" value="changePassword">
                        
                        <div class="form-group">
                            <label>Current Password:</label>
                            <input type="password" name="currentPassword" required>
                        </div>
                        
                        <div class="form-group">
                            <label>New Password:</label>
                            <input type="password" name="newPassword" required minlength="6">
                            <small>Minimum 6 characters</small>
                        </div>
                        
                        <div class="form-group">
                            <label>Confirm New Password:</label>
                            <input type="password" name="confirmPassword" required minlength="6">
                        </div>
                        
                        <button type="submit" class="btn">Change Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .profile-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 20px;
        }
        
        .profile-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: var(--shadow-md);
        }
        
        .profile-section h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
        }
        
        .form-group input:disabled {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
        
        .form-group small {
            display: block;
            margin-top: 5px;
            color: #666;
            font-size: 0.9rem;
        }
        
        .btn {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        
        @media (max-width: 768px) {
            .profile-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>
