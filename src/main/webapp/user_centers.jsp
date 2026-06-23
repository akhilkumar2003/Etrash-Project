<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.RecyclingCenter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recycling Centers - E-Trash</title>
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
            <h1>Recycling Centers</h1>
            
            <div class="search-bar">
                <input type="text" id="searchInput" onkeyup="filterCenters()" placeholder="Search by center name or location...">
            </div>
            
            <table id="centersTable">
                <tr>
                    <th>Center Name</th>
                    <th>Address</th>
                    <th>Contact Number</th>
                    <th>Action</th>
                </tr>
                <%
                List<RecyclingCenter> centers = (List<RecyclingCenter>) request.getAttribute("centers");
                if (centers != null) {
                    for (RecyclingCenter center : centers) {
                %>
                <tr>
                    <td><%= center.getCenterName() %></td>
                    <td><%= center.getAddress() %></td>
                    <td><%= center.getContactNumber() %></td>
                    <td><a href="#" onclick="getDirections('<%= center.getAddress() %>')" class="action-btn">Get Directions</a></td>
                </tr>
                <%
                    }
                }
                %>
            </table>
        </div>
    </div>
    
    <script>
        function filterCenters() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toUpperCase();
            var table = document.getElementById("centersTable");
            var rows = table.getElementsByTagName("tr");
            
            for (var i = 1; i < rows.length; i++) {
                var centerName = rows[i].getElementsByTagName("td")[0];
                var address = rows[i].getElementsByTagName("td")[1];
                if (centerName || address) {
                    var nameText = centerName.textContent || centerName.innerText;
                    var addressText = address.textContent || address.innerText;
                    if (nameText.toUpperCase().indexOf(filter) > -1 || addressText.toUpperCase().indexOf(filter) > -1) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            }
        }
        
        function getDirections(address) {
            // Open Google Maps with the address
            var encodedAddress = encodeURIComponent(address);
            window.open('https://www.google.com/maps/search/?api=1&query=' + encodedAddress, '_blank');
        }
    </script>
</body>
</html>