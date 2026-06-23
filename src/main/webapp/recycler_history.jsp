<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Collection History - Recycler</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>E-Trash Recycler</h2>
            <ul>
                <li><a href="recycler_dashboard.jsp">Dashboard</a></li>
                <li><a href="recycler_pickups">Assigned Pickups</a></li>
                <li><a href="recycler_history">Collection History</a></li>
                <li><a href="recycler_profile">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <h1>Collection History</h1>
            
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card">
                    <h3>Total Collections</h3>
                    <p class="stat-number"><%= request.getAttribute("totalCollections") != null ? request.getAttribute("totalCollections") : 0 %></p>
                </div>
                <div class="stat-card">
                    <h3>Total Quantity Collected</h3>
                    <p class="stat-number"><%= request.getAttribute("totalQuantity") != null ? String.format("%.2f", request.getAttribute("totalQuantity")) : "0.00" %> kg</p>
                </div>
            </div>
            
            <table id="historyTable">
                <thead>
                    <tr>
                        <th>Collection ID</th>
                        <th>Pickup ID</th>
                        <th>Plastic Type</th>
                        <th>Quantity (kg)</th>
                        <th>Collection Date</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody>
                <%
                List<Map<String, Object>> collections = (List<Map<String, Object>>) request.getAttribute("collections");
                if (collections != null && !collections.isEmpty()) {
                    for (Map<String, Object> collection : collections) {
                %>
                <tr>
                    <td><%= collection.get("collectionId") %></td>
                    <td><%= collection.get("pickupId") %></td>
                    <td><%= collection.get("plasticType") %></td>
                    <td><%= String.format("%.2f", collection.get("collectedQuantity")) %></td>
                    <td><%= collection.get("collectionDate") %></td>
                    <td><%= collection.get("address") %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px;">
                        <p>No collection history found. Complete pickups to see your collection history here.</p>
                    </td>
                </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    margin-top: 20px;
                }
            </style>
            
            <script>
                function filterHistory() {
                    var startDate = document.getElementById("startDate").value;
                    var endDate = document.getElementById("endDate").value;
                    var table = document.getElementById("historyTable");
                    var rows = table.getElementsByTagName("tr");
                    
                    for (var i = 1; i < rows.length; i++) {
                        var rowDate = rows[i].getAttribute("data-date");
                        if (startDate && endDate) {
                            if (rowDate >= startDate && rowDate <= endDate) {
                                rows[i].style.display = "";
                            } else {
                                rows[i].style.display = "none";
                            }
                        } else {
                            rows[i].style.display = "";
                        }
                    }
                }
            </script>
        </div>
    </div>
</body>
</html>