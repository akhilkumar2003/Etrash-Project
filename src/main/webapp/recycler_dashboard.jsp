<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recycler Dashboard - E-Trash Platform</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>🚛 E-Trash</h2>
            <p class="subtitle">Recycler Portal</p>
            <ul>
                <li><a href="recycler_dashboard.jsp" class="active">📊 Dashboard</a></li>
                <li>
                    <a href="recycler_pickups">
                        📦 Assigned Pickups
                        <span class="tooltip">
                            <span class="help-icon" style="float: right;">?</span>
                            <span class="tooltiptext">View and manage pickup requests assigned to you</span>
                        </span>
                    </a>
                </li>
                <li><a href="recycler_history">📜 Collection History</a></li>
                <li><a href="recycler_profile">👤 Profile</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h1>Welcome, <%= session.getAttribute("recyclerName") != null ? session.getAttribute("recyclerName") : "Recycler" %>! 🚛</h1>
                <p>Thank you for being a certified recycling partner. Your work helps create a cleaner environment!</p>
            </div>
            
            <!-- Recycler Guide -->
            <div class="info-box" style="margin-bottom: 30px;">
                <h3>⚙️ Recycler Dashboard Guide</h3>
                <p style="margin-bottom: 10px;">
                    As a certified recycler, you play a crucial role in the e-waste management ecosystem:
                </p>
                <ul style="margin-left: 20px; line-height: 1.8;">
                    <li><strong>Accept Pickups:</strong> View and accept pickup requests in your service area</li>
                    <li><strong>Scan QR Codes:</strong> Verify collections using the QR code system</li>
                    <li><strong>Record Collections:</strong> Log the exact weight of e-waste collected</li>
                    <li><strong>Earn Income:</strong> Get paid based on the quantity of e-waste processed</li>
                </ul>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <!-- Performance Stats -->
            <h2>📈 Your Performance</h2>
            <div class="stats">
                <div class="stat-box">
                    <h3>Assigned Pickups</h3>
                    <p><%= request.getAttribute("assignedCount") != null ? request.getAttribute("assignedCount") : "0" %></p>
                    <span class="stat-icon">📦</span>
                    <small class="input-helper">Pending collections</small>
                </div>
                <div class="stat-box">
                    <h3>Completed Today</h3>
                    <p><%= request.getAttribute("completedToday") != null ? request.getAttribute("completedToday") : "0" %></p>
                    <span class="stat-icon">✅</span>
                    <small class="input-helper">Today's collections</small>
                </div>
                <div class="stat-box">
                    <h3>Total Collected</h3>
                    <p><%= request.getAttribute("totalCollected") != null ? request.getAttribute("totalCollected") : "0" %> kg</p>
                    <span class="stat-icon">♻️</span>
                    <small class="input-helper">Overall e-waste processed</small>
                </div>
                <div class="stat-box">
                    <h3>Rating</h3>
                    <p><%= request.getAttribute("rating") != null ? request.getAttribute("rating") : "4.5" %> ⭐</p>
                    <span class="stat-icon">⭐</span>
                    <small class="input-helper">User satisfaction score</small>
                </div>
            </div>
            
            <!-- QR Code Scanner Section -->
            <div class="qr-scan-section" style="margin-top: 40px;">
                <h2>📱 Complete Pickup by Scanning QR Code</h2>
                <div class="info-box" style="margin-bottom: 20px;">
                    <p style="margin: 0; font-size: 0.9rem;">
                        <strong>How it works:</strong> Each pickup request has a unique QR code. Scan it at the collection site 
                        to verify the pickup, then enter the actual weight collected. The system will automatically update 
                        the user's rewards and your collection records.
                    </p>
                </div>
                
                <form action="recycler_pickups" method="post" class="qr-form" style="background: white; padding: 30px; border-radius: 15px; box-shadow: var(--shadow-md);">
                    <div class="form-group">
                        <label>
                            QR Code:
                            <span class="required">*</span>
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Enter the QR code shown by the user or scan it using your device camera</span>
                            </span>
                        </label>
                        <input type="text" name="qrCode" placeholder="Enter or scan QR code (e.g., PU12345)" required>
                        <small class="input-helper">The unique code provided by the user during pickup</small>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            Collected Quantity (kg):
                            <span class="required">*</span>
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Weigh the e-waste and enter the exact quantity in kilograms</span>
                            </span>
                        </label>
                        <input type="number" name="collectedQuantity" step="0.1" min="0.1" placeholder="e.g., 5.5" required>
                        <small class="input-helper">Enter weight in kilograms (minimum 0.1 kg)</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Collection Notes (Optional):</label>
                        <textarea name="notes" placeholder="Add any observations or issues during collection" style="height: 80px;"></textarea>
                        <small class="input-helper">Document any special conditions or user feedback</small>
                    </div>
                    
                    <button type="submit" class="btn">✔️ Complete Pickup</button>
                </form>
            </div>
            
            <!-- Quick Actions -->
            <h2 style="margin-top: 40px; margin-bottom: 20px;">⚡ Quick Actions</h2>
            <div class="quick-actions">
                <div class="action-card" onclick="window.location.href='recycler_pickups'">
                    <h3>📦 View Assigned Pickups</h3>
                    <p>See all pickup requests assigned to you with locations and contact details</p>
                    <button class="btn">View Pickups</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='recycler_history'">
                    <h3>📜 Collection History</h3>
                    <p>Review your past collections, earnings, and performance metrics</p>
                    <button class="btn">View History</button>
                </div>
                
                <div class="action-card" onclick="window.location.href='recycler_profile'">
                    <h3>👤 Update Profile</h3>
                    <p>Manage your service areas, contact information, and availability</p>
                    <button class="btn">Edit Profile</button>
                </div>
            </div>
            
            <!-- Best Practices -->
            <div class="feature-highlight" style="margin-top: 30px;">
                <h3 style="color: var(--primary-color); margin-bottom: 15px;">💡 Best Practices for Recyclers</h3>
                <ul style="margin-left: 20px; line-height: 1.8;">
                    <li>✓ Always verify the QR code before starting collection</li>
                    <li>✓ Use calibrated weighing scales for accurate measurements</li>
                    <li>✓ Handle e-waste carefully and use appropriate safety equipment</li>
                    <li>✓ Maintain professional communication with users</li>
                    <li>✓ Complete pickups on schedule to maintain high ratings</li>
                    <li>✓ Report any damaged or hazardous items immediately</li>
                    <li>✓ Follow proper segregation guidelines for different e-waste types</li>
                </ul>
            </div>
            
            <!-- Safety Guidelines -->
            <div class="warning" style="margin-top: 20px;">
                <strong>⚠️ Safety First:</strong> Always wear protective gear (gloves, masks) when handling e-waste. 
                Some components may contain hazardous materials. Follow all safety protocols and disposal guidelines.
            </div>
        </div>
    </div>
</body>
</html>