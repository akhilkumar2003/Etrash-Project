<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Trash - Login to Your Account</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>🌿 E-Trash Platform</h2>
            <h3>Recycling Made Easy & Rewarding</h3>
            
            <!-- Project Info Banner -->
            <div class="info-box" style="margin-bottom: 25px;">
                <p style="font-size: 0.9rem; margin: 0;">
                    <strong>Welcome!</strong> Join the green revolution. Login to manage your e-waste pickups, 
                    earn rewards, and contribute to a cleaner environment.
                </p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <form action="login" method="post">
                <div class="form-group">
                    <label>
                        Login As:
                        <span class="tooltip">
                            <span class="help-icon">?</span>
                            <span class="tooltiptext">Select your account type: User (for waste disposal), Recycler (for pickup services), or Admin (for management)</span>
                        </span>
                    </label>
                    <select name="userType" required>
                        <option value="user">👤 User - Dispose E-Waste & Earn Rewards</option>
                        <option value="recycler">👷 Recycler - Pickup & Process E-Waste</option>
                        <option value="admin">👑 Admin - Platform Management</option>
                    </select>
                    <small class="input-helper">Choose the role that matches your account</small>
                </div>
                
                <div class="form-group">
                    <label>
                        Username/Email/Phone:
                        <span class="required">*</span>
                    </label>
                    <input type="text" name="username" placeholder="Enter your username, email, or phone" required>
                    <small class="input-helper">You can use any of your registered credentials</small>
                </div>
                
                <div class="form-group">
                    <label>
                        Password:
                        <span class="required">*</span>
                    </label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                    <small class="input-helper">Password must be at least 6 characters</small>
                </div>
                
                <button type="submit" class="btn">Login Now</button>
            </form>
            
            <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                <p style="margin-bottom: 10px;">Don't have an account? <a href="register.jsp">Register here</a></p>
                <p style="font-size: 0.85rem; color: #6b7280; margin: 0;">
                    New to E-Trash? Sign up to start disposing e-waste responsibly and earn rewards!
                </p>
            </div>
            
            <!-- Feature Highlights -->
            <div class="feature-highlight" style="margin-top: 20px;">
                <strong>Why E-Trash?</strong>
                <ul style="margin: 10px 0 0 20px; font-size: 0.85rem;">
                    <li>📱 Schedule convenient pickups</li>
                    <li>🎁 Earn rewards for recycling</li>
                    <li>🌍 Track your environmental impact</li>
                    <li>♻️ Safe & certified disposal</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>