<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Rewards - E-Trash</title>
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
            <h1>My Rewards</h1>
            
            <div class="rewards-summary">
                <div class="reward-card">
                    <h3>Current Points</h3>
                    <p class="points"><%= request.getAttribute("points") != null ? request.getAttribute("points") : "0" %></p>
                </div>
                
                <div class="reward-card">
                    <h3>Lifetime Recycled</h3>
                    <p class="recycled"><%= request.getAttribute("totalRecycled") != null ? request.getAttribute("totalRecycled") : "0" %> kg</p>
                </div>
            </div>
            
            <div class="badges-section">
                <h2>Your Badges</h2>
                <div class="badges-grid">
                    <%
                    int points = request.getAttribute("points") != null ? (Integer) request.getAttribute("points") : 0;
                    %>
                    
                    <div class="badge <%= points >= 100 ? "earned" : "locked" %>">
                        <div class="badge-icon">🌿</div>
                        <h4>Green Warrior</h4>
                        <p>Earn 100 points</p>
                        <% if (points >= 100) { %>
                            <span class="badge-status">Earned</span>
                        <% } %>
                    </div>
                    
                    <div class="badge <%= points >= 500 ? "earned" : "locked" %>">
                        <div class="badge-icon">♻️</div>
                        <h4>Plastic Saver</h4>
                        <p>Earn 500 points</p>
                        <% if (points >= 500) { %>
                            <span class="badge-status">Earned</span>
                        <% } %>
                    </div>
                    
                    <div class="badge <%= points >= 1000 ? "earned" : "locked" %>">
                        <div class="badge-icon">🏆</div>
                        <h4>Eco Champion</h4>
                        <p>Earn 1000 points</p>
                        <% if (points >= 1000) { %>
                            <span class="badge-status">Earned</span>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <style>
                .rewards-summary {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                    gap: 20px;
                    margin-bottom: 30px;
                }
                
                .reward-card {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                    text-align: center;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                }
                
                .reward-card h3 {
                    color: #666;
                    margin-bottom: 15px;
                }
                
                .reward-card .points {
                    font-size: 48px;
                    font-weight: bold;
                    color: #667eea;
                }
                
                .reward-card .recycled {
                    font-size: 36px;
                    font-weight: bold;
                    color: #28a745;
                }
                
                .badges-section {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                }
                
                .badges-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin-top: 20px;
                }
                
                .badge {
                    text-align: center;
                    padding: 20px;
                    border-radius: 10px;
                    background: #f8f9fa;
                }
                
                .badge.earned {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                }
                
                .badge.locked {
                    opacity: 0.6;
                }
                
                .badge-icon {
                    font-size: 48px;
                    margin-bottom: 10px;
                }
                
                .badge h4 {
                    margin-bottom: 5px;
                }
                
                .badge p {
                    font-size: 14px;
                    margin-bottom: 10px;
                }
                
                .badge-status {
                    display: inline-block;
                    padding: 5px 10px;
                    background: rgba(255,255,255,0.2);
                    border-radius: 5px;
                    font-size: 12px;
                }
            </style>
        </div>
    </div>
</body>
</html>