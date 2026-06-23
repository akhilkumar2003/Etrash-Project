<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Admin</h2>
            <ul>
                <li><a href="admin_dashboard.jsp">Dashboard</a></li>
                <li><a href="admin_users">User Management</a></li>
                <li><a href="admin_recyclers">Recycler Management</a></li>
                <li><a href="admin_pickups">Pickup Management</a></li>
                <li><a href="admin_centers">Recycling Centers</a></li>
                <li><a href="admin_campaigns">Campaigns</a></li>
                <li><a href="admin_complaints">Complaints</a></li>
                <li><a href="admin_reports">Reports</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Reports & Analytics</h1>
            
            <div class="report-filters">
                <label>Report Type:</label>
                <select id="reportType" onchange="loadReport()">
                    <option value="summary">Summary Report</option>
                    <option value="users">User Report</option>
                    <option value="pickups">Pickup Report</option>
                    <option value="rewards">Rewards Report</option>
                    <option value="environmental">Environmental Impact</option>
                </select>
                
                <label>Date Range:</label>
                <input type="date" id="startDate">
                <input type="date" id="endDate">
                
                <button onclick="generateReport()" class="btn">Generate Report</button>
                <button onclick="printReport()" class="btn">Print</button>
                <button onclick="exportToCSV()" class="btn">Export to CSV</button>
            </div>
            
            <div id="reportContent" class="report-content">
                <!-- Report content will be loaded here -->
                <h2>Summary Report</h2>
                
                <div class="summary-stats">
                    <div class="stat-item">
                        <h3>Total Users</h3>
                        <p><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Total Recyclers</h3>
                        <p><%= request.getAttribute("totalRecyclers") != null ? request.getAttribute("totalRecyclers") : "0" %></p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Total Pickups</h3>
                        <p><%= request.getAttribute("totalPickups") != null ? request.getAttribute("totalPickups") : "0" %></p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Plastic Collected</h3>
                        <p><%= request.getAttribute("totalPlastic") != null ? request.getAttribute("totalPlastic") : "0" %> kg</p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>CO₂ Saved</h3>
                        <p><%= request.getAttribute("co2Saved") != null ? request.getAttribute("co2Saved") : "0" %> kg</p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Energy Saved</h3>
                        <p><%= request.getAttribute("energySaved") != null ? request.getAttribute("energySaved") : "0" %> kWh</p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Campaign Participants</h3>
                        <p><%= request.getAttribute("participants") != null ? request.getAttribute("participants") : "0" %></p>
                    </div>
                    
                    <div class="stat-item">
                        <h3>Reward Points Issued</h3>
                        <p><%= request.getAttribute("totalPoints") != null ? request.getAttribute("totalPoints") : "0" %></p>
                    </div>
                </div>
                
                <h2>Top Users</h2>
                <table id="topUsersTable">
                    <tr>
                        <th>Rank</th>
                        <th>User Name</th>
                        <th>Total Recycled (kg)</th>
                        <th>Points Earned</th>
                    </tr>
                    <%
                    List<model.User> topUsers = (List<model.User>) request.getAttribute("topUsers");
                    if (topUsers != null) {
                        int rank = 1;
                        for (model.User user : topUsers) {
                    %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getTotalRecycled() %> kg</td>
                        <td><%= user.getTotalRecycled() * 10 %></td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </table>
                
                <h2>Top Recyclers</h2>
                <table id="topRecyclersTable">
                    <tr>
                        <th>Rank</th>
                        <th>Recycler Name</th>
                        <th>Service Area</th>
                        <th>Total Collected (kg)</th>
                    </tr>
                    <%
                    List<model.Recycler> topRecyclers = (List<model.Recycler>) request.getAttribute("topRecyclers");
                    if (topRecyclers != null) {
                        int rank = 1;
                        for (model.Recycler recycler : topRecyclers) {
                    %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= recycler.getName() %></td>
                        <td><%= recycler.getServiceArea() %></td>
                        <td><%= recycler.getTotalCollected() %> kg</td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </table>
            </div>
            
            <style>
                .report-filters {
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    margin-bottom: 20px;
                }
                
                .report-filters select, .report-filters input {
                    margin: 0 10px;
                    padding: 8px;
                }
                
                .report-content {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                }
                
                .summary-stats {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin: 20px 0;
                }
                
                .stat-item {
                    background: #f8f9fa;
                    padding: 20px;
                    border-radius: 10px;
                    text-align: center;
                }
                
                .stat-item h3 {
                    color: #666;
                    font-size: 16px;
                    margin-bottom: 10px;
                }
                
                .stat-item p {
                    font-size: 24px;
                    font-weight: bold;
                    color: #2c3e50;
                }
            </style>
            
            <script>
                function loadReport() {
                    var reportType = document.getElementById("reportType").value;
                    // In a real application, this would load different report views
                    alert("Loading " + reportType + " report...");
                }
                
                function generateReport() {
                    var startDate = document.getElementById("startDate").value;
                    var endDate = document.getElementById("endDate").value;
                    
                    if (!startDate || !endDate) {
                        alert("Please select date range");
                        return;
                    }
                    
                    alert("Generating report from " + startDate + " to " + endDate);
                }
                
                function exportToCSV() {
                    var reportContent = document.getElementById("reportContent");
                    var tables = reportContent.getElementsByTagName("table");
                    
                    if (tables.length > 0) {
                        var csv = [];
                        var rows = tables[0].getElementsByTagName("tr");
                        
                        for (var i = 0; i < rows.length; i++) {
                            var row = [], cols = rows[i].getElementsByTagName("td");
                            if (cols.length === 0) {
                                cols = rows[i].getElementsByTagName("th");
                            }
                            
                            for (var j = 0; j < cols.length; j++) {
                                row.push(cols[j].innerText);
                            }
                            
                            csv.push(row.join(","));
                        }
                        
                        var csvContent = csv.join("\n");
                        var blob = new Blob([csvContent], { type: "text/csv" });
                        var url = window.URL.createObjectURL(blob);
                        var a = document.createElement("a");
                        a.href = url;
                        a.download = "report.csv";
                        a.click();
                    }
                }
            </script>
        </div>
    </div>
</body>
</html>