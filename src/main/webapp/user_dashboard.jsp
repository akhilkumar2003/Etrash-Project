<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - E-Trash Platform</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>🌿 E-Trash</h2>
            <p class="subtitle">User Portal</p>
            <ul>
                <li><a href="user_dashboard.jsp" class="active">📊 Dashboard</a></li>
                <li>
                    <a href="pickup_request">
                        📦 Request Pickup
                        <span class="tooltip">
                            <span class="help-icon" style="float: right;">?</span>
                            <span class="tooltiptext">Schedule a doorstep pickup for your e-waste items</span>
                        </span>
                    </a>
                </li>
                <li><a href="pickup_request">📦 My Pickups</a></li>
                <li><a href="user_rewards">🎁 My Rewards</a></li>
                <li><a href="user_centers">📍 Recycling Centers</a></li>
                <li><a href="user_campaigns">📢 Campaigns</a></li>                <li><a href="volunteer">🙋 Volunteer</a></li>
                <li><a href="leaderboard">🏅 Leaderboard</a></li>                <li><a href="user_marketplace">🏪 Marketplace</a></li>
                <li><a href="user_complaints">💬 Complaints</a></li>
                <li><a href="user_profile">👤 Profile</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h1>Welcome back, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User" %>! 👋</h1>
                <p>Thank you for contributing to a cleaner, greener planet. Every small action counts!</p>
            </div>
            
            <!-- Project Information -->
            <div class="project-info">
                <h2>🌐 About E-Trash Platform</h2>
                <p>
                    E-Trash is your one-stop solution for responsible electronic waste disposal. We connect users with 
                    certified recyclers to ensure your old electronics are processed safely and sustainably.
                </p>
                <h3>How It Works:</h3>
                <ul>
                    <li><strong>Schedule Pickup:</strong> Request a convenient time for doorstep collection</li>
                    <li><strong>Get Verified:</strong> Our certified recyclers collect and verify your e-waste</li>
                    <li><strong>Earn Rewards:</strong> Receive points based on the weight and type of waste</li>
                    <li><strong>Track Impact:</strong> See how much you've contributed to environmental conservation</li>
                </ul>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <!-- Environmental Impact Stats -->
            <div class="impact-stats">
                <h2>📈 Your Environmental Impact</h2>
                <div class="info-box" style="margin-bottom: 20px;">
                    <p style="margin: 0; font-size: 0.9rem;">
                        Track your contribution to environmental conservation. Each kilogram of e-waste you recycle 
                        helps reduce pollution and conserve natural resources.
                    </p>
                </div>
                
                <div class="stat-grid">
                    <div class="stat-card">
                        <h3>Total Recycled</h3>
                        <p><%= request.getAttribute("totalRecycled") != null ? request.getAttribute("totalRecycled") : "0" %> kg</p>
                        <span class="stat-icon">♻️</span>
                        <small class="input-helper">Weight of e-waste you've disposed</small>
                    </div>
                    <div class="stat-card">
                        <h3>CO₂ Saved</h3>
                        <p><%= request.getAttribute("co2Saved") != null ? request.getAttribute("co2Saved") : "0" %> kg</p>
                        <span class="stat-icon">🌍</span>
                        <small class="input-helper">Carbon emissions prevented</small>
                    </div>
                    <div class="stat-card">
                        <h3>Reward Points</h3>
                        <p><%= request.getAttribute("rewardPoints") != null ? request.getAttribute("rewardPoints") : "0" %></p>
                        <span class="stat-icon">🎁</span>
                        <small class="input-helper">Points earned for recycling</small>
                    </div>
                    <div class="stat-card">
                        <h3>Pickups Completed</h3>
                        <p><%= request.getAttribute("pickupCount") != null ? request.getAttribute("pickupCount") : "0" %></p>
                        <span class="stat-icon">✅</span>
                        <small class="input-helper">Successful collections</small>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <h2 style="margin-top: 40px; margin-bottom: 20px;">⚡ Quick Actions</h2>
            <div class="quick-actions">
                <div class="action-card" onclick="window.location.href='pickup_request'">
                    <h3>🚛 Request Pickup</h3>
                    <p>Schedule a convenient time for our recyclers to collect your e-waste from your doorstep</p>
                    <button class="btn">Schedule Now</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='user_centers'">
                    <h3>📍 Find Recycling Center</h3>
                    <p>Locate nearby certified recycling centers where you can drop off your e-waste directly</p>
                    <button class="btn">View Centers</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='user_campaigns'">
                    <h3>📢 Join Campaign</h3>
                    <p>Participate in awareness campaigns and community events to promote e-waste recycling</p>
                    <button class="btn">Explore Campaigns</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='user_marketplace'">
                    <h3>🏪 Browse Marketplace</h3>
                    <p>Buy or sell refurbished electronics and give devices a second life</p>
                    <button class="btn">Visit Marketplace</button>
                </div>
            </div>
            
            <!-- Helpful Tips -->
            <div class="info-box" style="margin-top: 30px;">
                <h3>💡 Helpful Tips</h3>
                <ul style="margin-left: 20px; line-height: 1.8;">
                    <li><strong>Prepare your e-waste:</strong> Remove batteries and personal data before pickup</li>
                    <li><strong>Earn more points:</strong> Larger and rarer items earn higher rewards</li>
                    <li><strong>Track pickups:</strong> Check "My Pickups" to monitor collection status</li>
                    <li><strong>Spread awareness:</strong> Share campaigns with friends and family</li>
                    <li><strong>Redeem rewards:</strong> Use points in our marketplace or for discount coupons</li>
                </ul>
            </div>
            
            <!-- What Can Be Recycled -->
            <div class="feature-highlight" style="margin-top: 20px;">
                <h3 style="color: var(--primary-color); margin-bottom: 15px;">♻️ What Can You Recycle?</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                    <div>
                        <strong>📱 Phones & Tablets</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Mobile phones, smartphones, tablets</p>
                    </div>
                    <div>
                        <strong>💻 Computers</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Laptops, desktops, monitors</p>
                    </div>
                    <div>
                        <strong>⌨️ Accessories</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Keyboards, mice, cables, chargers</p>
                    </div>
                    <div>
                        <strong>🖨️ Peripherals</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Printers, scanners, speakers</p>
                    </div>
                    <div>
                        <strong>🎮 Electronics</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Gaming consoles, cameras</p>
                    </div>
                    <div>
                        <strong>🏠 Appliances</strong>
                        <p style="font-size: 0.85rem; margin: 5px 0 0 0;">Small household electronics</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>