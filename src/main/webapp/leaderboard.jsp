<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard - E-Trash</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash User</h2>
            <ul>
                <li><a href="user_dashboard.jsp">📊 Dashboard</a></li>
                <li><a href="pickup_request">📦 Request Pickup</a></li>
                <li><a href="pickup_request">📋 My Pickups</a></li>
                <li><a href="user_rewards">🏆 My Rewards</a></li>
                <li><a href="user_centers">📍 Recycling Centers</a></li>
                <li><a href="user_campaigns">📢 Campaigns</a></li>
                <li><a href="volunteer">🙋 Volunteer</a></li>
                <li><a href="leaderboard" class="active">🏅 Leaderboard</a></li>
                <li><a href="user_marketplace">🛒 Marketplace</a></li>
                <li><a href="user_complaints">💬 Complaints</a></li>
                <li><a href="user_profile">👤 Profile</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>🏅 Eco-Warrior Leaderboard</h1>
            
            <div class="gamification-banner">
                <h2>Compete. Recycle. Lead!</h2>
                <p>Earn points by recycling more e-waste and climb the leaderboard to become a sustainability champion!</p>
            </div>
            
            <% 
            String badge = (String) request.getAttribute("badge");
            int userRank = (int) request.getAttribute("userRank");
            int pickupCount = (int) request.getAttribute("pickupCount");
            double totalRecycled = (double) request.getAttribute("totalRecycled");
            int rewardPoints = (int) request.getAttribute("rewardPoints");
            %>
            
            <!-- User Stats Card -->
            <div class="user-stats-card">
                <div class="badge-section">
                    <div class="badge badge-<%= badge %>">
                        <div class="badge-icon">
                            <% if ("platinum".equals(badge)) { %>
                                💎
                            <% } else if ("gold".equals(badge)) { %>
                                🥇
                            <% } else if ("silver".equals(badge)) { %>
                                🥈
                            <% } else if ("bronze".equals(badge)) { %>
                                🥉
                            <% } else { %>
                                🌱
                            <% } %>
                        </div>
                        <div class="badge-name"><%= badge.toUpperCase() %></div>
                    </div>
                </div>
                <div class="stats-section">
                    <div class="stat-item">
                        <div class="stat-label">Your Rank</div>
                        <div class="stat-value">#<%= userRank > 0 ? userRank : "-" %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Total Pickups</div>
                        <div class="stat-value"><%= pickupCount %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Recycled (kg)</div>
                        <div class="stat-value"><%= String.format("%.2f", totalRecycled) %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Reward Points</div>
                        <div class="stat-value"><%= rewardPoints %></div>
                    </div>
                </div>
            </div>
            
            <!-- Badge Progression -->
            <div class="badge-progression">
                <h3>Badge Levels</h3>
                <div class="progression-track">
                    <div class="level <%= badge.equals("beginner") ? "active" : "completed" %>">
                        <div class="level-icon">🌱</div>
                        <div class="level-name">Beginner</div>
                        <div class="level-req">0-99 points</div>
                    </div>
                    <div class="level <%= badge.equals("bronze") ? "active" : (rewardPoints >= 100 ? "completed" : "") %>">
                        <div class="level-icon">🥉</div>
                        <div class="level-name">Bronze</div>
                        <div class="level-req">100+ points</div>
                    </div>
                    <div class="level <%= badge.equals("silver") ? "active" : (rewardPoints >= 250 ? "completed" : "") %>">
                        <div class="level-icon">🥈</div>
                        <div class="level-name">Silver</div>
                        <div class="level-req">250+ points</div>
                    </div>
                    <div class="level <%= badge.equals("gold") ? "active" : (rewardPoints >= 500 ? "completed" : "") %>">
                        <div class="level-icon">🥇</div>
                        <div class="level-name">Gold</div>
                        <div class="level-req">500+ points</div>
                    </div>
                    <div class="level <%= badge.equals("platinum") ? "active" : (rewardPoints >= 1000 ? "completed" : "") %>">
                        <div class="level-icon">⭐</div>
                        <div class="level-name">Platinum</div>
                        <div class="level-req">1000+ points</div>
                    </div>
                </div>
            </div>
            
            <!-- Leaderboard Table -->
            <h2>Top Eco-Warriors</h2>
            <div class="leaderboard-table">
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>User</th>
                            <th>Total Recycled (kg)</th>
                            <th>Reward Points</th>
                            <th>Badge</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    List<Map<String, Object>> leaderboard = (List<Map<String, Object>>) request.getAttribute("leaderboard");
                    if (leaderboard != null && !leaderboard.isEmpty()) {
                        int rank = 1;
                        for (Map<String, Object> entry : leaderboard) {
                            String userName = (String) entry.get("name");
                            double userRecycled = (double) entry.get("totalRecycled");
                            int userPoints = (int) entry.get("points");
                            
                            String userBadge = "beginner";
                            if (userPoints >= 1000) userBadge = "platinum";
                            else if (userPoints >= 500) userBadge = "gold";
                            else if (userPoints >= 250) userBadge = "silver";
                            else if (userPoints >= 100) userBadge = "bronze";
                            
                            String rankClass = "";
                            if (rank == 1) rankClass = "rank-1";
                            else if (rank == 2) rankClass = "rank-2";
                            else if (rank == 3) rankClass = "rank-3";
                    %>
                        <tr class="<%= rankClass %>">
                            <td class="rank-cell">
                                <% if (rank == 1) { %>
                                    🥇
                                <% } else if (rank == 2) { %>
                                    🥈
                                <% } else if (rank == 3) { %>
                                    🥉
                                <% } else { %>
                                    <%= rank %>
                                <% } %>
                            </td>
                            <td class="user-cell"><%= userName %></td>
                            <td><%= String.format("%.2f", userRecycled) %></td>
                            <td class="points-cell"><%= userPoints %></td>
                            <td class="badge-cell">
                                <span class="badge-mini badge-<%= userBadge %>"><%= userBadge.toUpperCase() %></span>
                            </td>
                        </tr>
                    <%
                            rank++;
                        }
                    } else {
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 40px;">
                                <p>No leaderboard data yet. Start recycling to see rankings!</p>
                            </td>
                        </tr>
                    <%
                    }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <style>
        .gamification-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
        }
        
        .gamification-banner h2 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .user-stats-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 30px;
        }
        
        .badge {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            box-shadow: var(--shadow-lg);
            position: relative;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .badge-platinum { background: linear-gradient(135deg, #e0e0e0, #b0b0b0); }
        .badge-gold { background: linear-gradient(135deg, #ffd700, #ffed4e); }
        .badge-silver { background: linear-gradient(135deg, #c0c0c0, #e8e8e8); }
        .badge-bronze { background: linear-gradient(135deg, #cd7f32, #e89e66); }
        .badge-beginner { background: linear-gradient(135deg, #81c784, #66bb6a); }
        
        .badge-icon {
            font-size: 3rem;
        }
        
        .badge-name {
            font-weight: bold;
            margin-top: 10px;
            text-transform: uppercase;
        }
        
        .stats-section {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .badge-progression {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-md);
        }
        
        .progression-track {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 20px;
        }
        
        .level {
            flex: 1;
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            background: #f5f5f5;
            transition: all 0.3s;
        }
        
        .level.active {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: scale(1.05);
        }
        
        .level.completed {
            background: #e8f5e9;
        }
        
        .level-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .level-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .level-req {
            font-size: 0.85rem;
            opacity: 0.8;
        }
        
        .leaderboard-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: var(--shadow-md);
        }
        
        .leaderboard-table table {
            width: 100%;
        }
        
        .rank-1 { background: #fff8e1 !important; }
        .rank-2 { background: #f5f5f5 !important; }
        .rank-3 { background: #ffe0b2 !important; }
        
        .rank-cell {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
        }
        
        .user-cell {
            font-weight: 600;
        }
        
        .points-cell {
            color: var(--primary-color);
            font-weight: bold;
        }
        
        .badge-mini {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            display: inline-block;
        }
        
        @media (max-width: 768px) {
            .user-stats-card {
                grid-template-columns: 1fr;
            }
            
            .stats-section {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .progression-track {
                flex-direction: column;
            }
        }
    </style>
</body>
</html>
