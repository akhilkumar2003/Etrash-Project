<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.PickupRequest, model.Recycler" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pickup Management - E-Trash</title>
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
            <h1>Pickup Request Management</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Plastic Type</th>
                    <th>Quantity</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>QR Code</th>
                    <th>Status</th>
                    <th>Assign Recycler</th>
                </tr>
                <%
                List<PickupRequest> requests = (List<PickupRequest>) request.getAttribute("requests");
                List<Recycler> recyclers = (List<Recycler>) request.getAttribute("recyclers");
                
                System.out.println("Recycler LEN...."+recyclers.size());
                System.out.println("Requests LEN...."+requests.size());
                
                if (requests != null) {
                    for (PickupRequest req : requests) {
                %>
                <tr>
                    <td><%= req.getPickupId() %></td>
                    <td><%= req.getUserId() %></td>
                    <td><%= req.getPlasticType() %></td>
                    <td><%= req.getQuantity() %> kg</td>
                    <td><%= req.getPickupDate() %></td>
                    <td><%= req.getPickupTime() %></td>
                    <td><%= req.getQrCode() %></td>
                    <td><%= req.getStatus() %></td>
                    <td>
                        <% if ("Pending".equals(req.getStatus()) && recyclers != null) { 
                        	
                        	System.out.println("IF....");
                            // Count active recyclers
                            int activeRecyclersCount = 0;
                            for (Recycler r : recyclers) { 
                            	
                            	System.out.println("for...."+r.getName());
                            			
                                if ("Active".equals(r.getStatus())) {
                                	
                                	System.out.println("FOR IF...."+r.getStatus());
                                	
                                    activeRecyclersCount++;
                                }
                                else
                                {
                                	System.out.println("FOR ELSE...."+r.getStatus());
                                }
                            }
                            if (activeRecyclersCount > 0) {
                            	
                            	System.out.println("DROP DWON IF....");
                        %>
                            <form action="admin_pickups" method="post" style="display:inline;">
                                <input type="hidden" name="pickupId" value="<%= req.getPickupId() %>">
                                <select name="recyclerId" required style="min-width: 150px;">
                                    <option value="">Select Recycler</option>
                                    <% for (Recycler r : recyclers) { 
                                    	System.out.println("DOROP DOWN FOR...."+r.getName());
                                    	
                                        if ("Active".equals(r.getStatus())) {
                                        	
                                        	System.out.println("DOROP IF...."+r.getStatus());
                                        	
                                        	%>
                                    <option value="<%= r.getRecyclerId() %>"><%= r.getName() %> (ID: <%= r.getRecyclerId() %>)</option>
                                    <% }
                                        else
                                        {
                                        	System.out.println("DOROP ELSE...."+r.getStatus());
                                        }
                                    
                                    } %>
                                </select>
                                <button type="submit">Assign</button>
                            </form>
                        <% } else { %>
                            <span style="color: red;">No active recyclers available</span>
                        <% } %>
                        <% } else if ("Pending".equals(req.getStatus())) { %>
                            <span style="color: red;">No recyclers loaded</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </table>
        </div>
    </div>
</body>
</html>