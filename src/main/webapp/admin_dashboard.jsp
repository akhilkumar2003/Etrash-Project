<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - E-Trash Platform</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>⚙️ E-Trash</h2>
            <p class="subtitle">Admin Portal</p>
            <ul>
                <li><a href="admin_dashboard.jsp" class="active">📊 Dashboard</a></li>
                <li>
                    <a href="admin_users">
                        👥 User Management
                        <span class="tooltip">
                            <span class="help-icon" style="float: right;">?</span>
                            <span class="tooltiptext">Manage user accounts, verify registrations, and handle user-related issues</span>
                        </span>
                    </a>
                </li>
                <li><a href="admin_recyclers">🚛 Recycler Management</a></li>
                <li><a href="admin_pickups">📦 Pickup Management</a></li>
                <li><a href="admin_centers">📍 Recycling Centers</a></li>
                <li><a href="admin_campaigns">🌐 Campaigns</a></li>
                <li><a href="admin_complaints">💬 Complaints</a></li>
                <li><a href="admin_reports">📋 Reports</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h1>Admin Control Center 🎛️</h1>
                <p>Manage the E-Trash platform, monitor activities, and ensure smooth operations</p>
            </div>
            
            <!-- Admin Guide -->
            <div class="info-box" style="margin-bottom: 30px;">
                <h3>📖 Admin Dashboard Guide</h3>
                <p style="margin-bottom: 10px;">
                    This dashboard provides you with comprehensive tools to manage all aspects of the E-Trash platform:
                </p>
                <ul style="margin-left: 20px; line-height: 1.8;">
                    <li><strong>User Management:</strong> Approve/reject user registrations, manage user accounts</li>
                    <li><strong>Recycler Management:</strong> Verify recycler credentials, assign service areas</li>
                    <li><strong>Pickup Management:</strong> Monitor pickup requests, resolve issues</li>
                    <li><strong>Reports:</strong> Generate analytics on recycling activities and environmental impact</li>
                </ul>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <!-- Platform Statistics -->
            <h2>📈 Platform Statistics</h2>
            <div class="stats">
                <div class="stat-box">
                    <h3>Total Users</h3>
                    <p><%= request.getAttribute("userCount") != null ? request.getAttribute("userCount") : "0" %></p>
                    <span class="stat-icon">👥</span>
                    <small class="input-helper">Registered platform users</small>
                </div>
                <div class="stat-box">
                    <h3>Total Recyclers</h3>
                    <p><%= request.getAttribute("recyclerCount") != null ? request.getAttribute("recyclerCount") : "0" %></p>
                    <span class="stat-icon">👷</span>
                    <small class="input-helper">Active recycling partners</small>
                </div>
                <div class="stat-box">
                    <h3>Pending Pickups</h3>
                    <p><%= request.getAttribute("pendingPickups") != null ? request.getAttribute("pendingPickups") : "0" %></p>
                    <span class="stat-icon">⏳</span>
                    <small class="input-helper">Awaiting assignment/completion</small>
                </div>
                <div class="stat-box">
                    <h3>Total Recycled</h3>
                    <p><%= request.getAttribute("totalRecycled") != null ? request.getAttribute("totalRecycled") : "0" %> kg</p>
                    <span class="stat-icon">♻️</span>
                    <small class="input-helper">Overall e-waste processed</small>
                </div>
            </div>
            
            <!-- Quick Actions for Admin -->
            <h2 style="margin-top: 40px; margin-bottom: 20px;">⚡ Quick Admin Actions</h2>
            <div class="quick-actions">
                <div class="action-card" onclick="window.location.href='admin_users'">
                    <h3>👥 Verify New Users</h3>
                    <p>Review and approve pending user registrations to maintain platform quality</p>
                    <button class="btn">Manage Users</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='admin_pickups'">
                    <h3>🖥️ Monitor Pickups</h3>
                    <p>Track pickup requests, resolve issues, and ensure timely collections</p>
                    <button class="btn">View Pickups</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='admin_complaints'">
                    <h3>💬 Handle Complaints</h3>
                    <p>Address user and recycler complaints promptly to maintain service quality</p>
                    <button class="btn">View Complaints</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='admin_reports'">
                    <h3>📊 Generate Reports</h3>
                    <p>Access detailed analytics and generate reports on platform performance</p>
                    <button class="btn">View Reports</button>
                </div>
            </div>
            
            <!-- Recent Activity -->
            <div class="recent-activity" style="margin-top: 40px;">
                <h2>🕐 Recent Pickup Requests</h2>
                <div class="info-box" style="margin-bottom: 15px;">
                    <p style="margin: 0; font-size: 0.9rem;">
                        Monitor the latest pickup requests. Click on any row to view details and take action.
                    </p>
                </div>
                
                <% 
                List<model.PickupRequest> recentRequests = (List<model.PickupRequest>) request.getAttribute("recentRequests");
                if (recentRequests != null && !recentRequests.isEmpty()) {
                %>
                <div style="overflow-x: auto;">
                    <table>
                        <thead>
                            <tr>
                                <th>Pickup ID</th>
                                <th>User ID</th>
                                <th>E-Waste Type</th>
                                <th>Quantity</th>
                                <th>Pickup Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                        for (model.PickupRequest req : recentRequests) {
                            String statusClass = "";
                            if ("Completed".equals(req.getStatus())) statusClass = "badge-success";
                            else if ("Pending".equals(req.getStatus())) statusClass = "badge-warning";
                            else if ("Cancelled".equals(req.getStatus())) statusClass = "badge-danger";
                        %>
                        <tr>
                            <td><strong>#<%= req.getPickupId() %></strong></td>
                            <td><%= req.getUserId() %></td>
                            <td><%= req.getPlasticType() %></td>
                            <td><%= req.getQuantity() %> kg</td>
                            <td><%= req.getPickupDate() %></td>
                            <td><span class="badge <%= statusClass %>"><%= req.getStatus() %></span></td>
                        </tr>
                        <%
                        }
                        %>
                        </tbody>
                    </table>
                </div>
                <% 
                } else {
                %>
                <div class="info-box">
                    <p style="margin: 0; text-align: center;">
                        ❌ No recent pickup requests found. Check back later for new activities.
                    </p>
                </div>
                <% } %>
            </div>
            
            <!-- Admin Tips -->
            <div class="feature-highlight" style="margin-top: 30px;">
                <h3 style="color: var(--secondary-color); margin-bottom: 15px;">💡 Admin Best Practices</h3>
                <ul style="margin-left: 20px; line-height: 1.8;">
                    <li>Verify user registrations within 24 hours to maintain user satisfaction</li>
                    <li>Regularly review recycler performance and address complaints promptly</li>
                    <li>Monitor pending pickups to ensure timely assignment to recyclers</li>
                    <li>Generate weekly reports to track platform growth and environmental impact</li>
                    <li>Keep recycling center information updated for accurate user guidance</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>