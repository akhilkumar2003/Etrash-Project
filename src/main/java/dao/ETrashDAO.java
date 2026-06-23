package dao;

import model.*;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ETrashDAO {
    
    private Connection connection;
    
    public ETrashDAO() {
        connection = DBConnection.getConnection();
    }
    
    // Admin Operations
    public Admin validateAdmin(String username, String password) {
        String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // User Operations
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (name, email, phone, address, password, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getPassword());
            pstmt.setString(6, user.getStatus());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User validateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setPassword(rs.getString("password"));
                user.setStatus(rs.getString("status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public boolean updateUserStatus(int userId, String status) {
        String query = "UPDATE users SET status = ? WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Recycler Operations
    public boolean registerRecycler(Recycler recycler) {
        String query = "INSERT INTO recycler (name, phone, service_area, password, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, recycler.getName());
            pstmt.setString(2, recycler.getPhone());
            pstmt.setString(3, recycler.getServiceArea());
            pstmt.setString(4, recycler.getPassword());
            pstmt.setString(5, recycler.getStatus());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Recycler validateRecycler(String phone, String password) {
        String query = "SELECT * FROM recycler WHERE phone = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, phone);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Recycler recycler = new Recycler();
                recycler.setRecyclerId(rs.getInt("recycler_id"));
                recycler.setName(rs.getString("name"));
                recycler.setPhone(rs.getString("phone"));
                recycler.setServiceArea(rs.getString("service_area"));
                recycler.setPassword(rs.getString("password"));
                recycler.setStatus(rs.getString("status"));
                return recycler;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Recycler> getAllRecyclers() {
        List<Recycler> recyclers = new ArrayList<>();
        String query = "SELECT * FROM recycler";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Recycler recycler = new Recycler();
                recycler.setRecyclerId(rs.getInt("recycler_id"));
                recycler.setName(rs.getString("name"));
                recycler.setPhone(rs.getString("phone"));
                recycler.setServiceArea(rs.getString("service_area"));
                recycler.setStatus(rs.getString("status"));
                recyclers.add(recycler);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recyclers;
    }
    
    public boolean updateRecyclerStatus(int recyclerId, String status) {
        String query = "UPDATE recycler SET status = ? WHERE recycler_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, recyclerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteRecycler(int recyclerId) {
        String query = "DELETE FROM recycler WHERE recycler_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, recyclerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Industry Buyer Operations
    public boolean registerIndustryBuyer(IndustryBuyer buyer) {
        String query = "INSERT INTO industry_buyers (industry_name, contact_person, phone, password) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, buyer.getIndustryName());
            pstmt.setString(2, buyer.getContactPerson());
            pstmt.setString(3, buyer.getPhone());
            pstmt.setString(4, buyer.getPassword());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public IndustryBuyer validateIndustryBuyer(String phone, String password) {
        String query = "SELECT * FROM industry_buyers WHERE phone = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, phone);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                IndustryBuyer buyer = new IndustryBuyer();
                buyer.setBuyerId(rs.getInt("buyer_id"));
                buyer.setIndustryName(rs.getString("industry_name"));
                buyer.setContactPerson(rs.getString("contact_person"));
                buyer.setPhone(rs.getString("phone"));
                return buyer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Recycling Center Operations
    public boolean addRecyclingCenter(RecyclingCenter center) {
        String query = "INSERT INTO recycling_centers (center_name, address, contact_number) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, center.getCenterName());
            pstmt.setString(2, center.getAddress());
            pstmt.setString(3, center.getContactNumber());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<RecyclingCenter> getAllRecyclingCenters() {
        List<RecyclingCenter> centers = new ArrayList<>();
        String query = "SELECT * FROM recycling_centers";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                RecyclingCenter center = new RecyclingCenter();
                center.setCenterId(rs.getInt("center_id"));
                center.setCenterName(rs.getString("center_name"));
                center.setAddress(rs.getString("address"));
                center.setContactNumber(rs.getString("contact_number"));
                centers.add(center);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return centers;
    }
    
    public boolean deleteRecyclingCenter(int centerId) {
        String query = "DELETE FROM recycling_centers WHERE center_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, centerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Pickup Request Operations
    public boolean createPickupRequest(PickupRequest request) {
        String query = "INSERT INTO pickup_requests (user_id, plastic_type, quantity, pickup_date, pickup_time, qr_code, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, request.getUserId());
            pstmt.setString(2, request.getPlasticType());
            pstmt.setDouble(3, request.getQuantity());
            pstmt.setDate(4, request.getPickupDate());
            pstmt.setTime(5, request.getPickupTime());
            pstmt.setString(6, request.getQrCode());
            pstmt.setString(7, request.getStatus());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<PickupRequest> getAllPickupRequests() {
        List<PickupRequest> requests = new ArrayList<>();
        String query = "SELECT * FROM pickup_requests ORDER BY pickup_date DESC";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                PickupRequest request = new PickupRequest();
                request.setPickupId(rs.getInt("pickup_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setPlasticType(rs.getString("plastic_type"));
                request.setQuantity(rs.getDouble("quantity"));
                request.setPickupDate(rs.getDate("pickup_date"));
                request.setPickupTime(rs.getTime("pickup_time"));
                request.setRecyclerId(rs.getInt("recycler_id"));
                request.setQrCode(rs.getString("qr_code"));
                request.setStatus(rs.getString("status"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public List<PickupRequest> getPickupRequestsByUser(int userId) {
        List<PickupRequest> requests = new ArrayList<>();
        String query = "SELECT * FROM pickup_requests WHERE user_id = ? ORDER BY pickup_date DESC";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PickupRequest request = new PickupRequest();
                request.setPickupId(rs.getInt("pickup_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setPlasticType(rs.getString("plastic_type"));
                request.setQuantity(rs.getDouble("quantity"));
                request.setPickupDate(rs.getDate("pickup_date"));
                request.setPickupTime(rs.getTime("pickup_time"));
                request.setRecyclerId(rs.getInt("recycler_id"));
                request.setQrCode(rs.getString("qr_code"));
                request.setStatus(rs.getString("status"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public List<PickupRequest> getAssignedPickups(int recyclerId) {
        List<PickupRequest> requests = new ArrayList<>();
        String query = "SELECT * FROM pickup_requests WHERE recycler_id = ? AND status = 'Assigned' ORDER BY pickup_date";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, recyclerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PickupRequest request = new PickupRequest();
                request.setPickupId(rs.getInt("pickup_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setPlasticType(rs.getString("plastic_type"));
                request.setQuantity(rs.getDouble("quantity"));
                request.setPickupDate(rs.getDate("pickup_date"));
                request.setPickupTime(rs.getTime("pickup_time"));
                request.setRecyclerId(rs.getInt("recycler_id"));
                request.setQrCode(rs.getString("qr_code"));
                request.setStatus(rs.getString("status"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public boolean assignRecycler(int pickupId, int recyclerId) {
        String query = "UPDATE pickup_requests SET recycler_id = ?, status = 'Assigned' WHERE pickup_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, recyclerId);
            pstmt.setInt(2, pickupId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public PickupRequest getPickupRequestByQR(String qrCode) {
        String query = "SELECT * FROM pickup_requests WHERE qr_code = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, qrCode);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                PickupRequest request = new PickupRequest();
                request.setPickupId(rs.getInt("pickup_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setPlasticType(rs.getString("plastic_type"));
                request.setQuantity(rs.getDouble("quantity"));
                request.setPickupDate(rs.getDate("pickup_date"));
                request.setPickupTime(rs.getTime("pickup_time"));
                request.setRecyclerId(rs.getInt("recycler_id"));
                request.setQrCode(rs.getString("qr_code"));
                request.setStatus(rs.getString("status"));
                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Waste Collection Operations
    public boolean recordWasteCollection(WasteCollection collection) {
        String query = "INSERT INTO waste_collection (pickup_id, recycler_id, collected_quantity, collection_date) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, collection.getPickupId());
            pstmt.setInt(2, collection.getRecyclerId());
            pstmt.setDouble(3, collection.getCollectedQuantity());
            pstmt.setDate(4, collection.getCollectionDate());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updatePickupStatus(int pickupId, String status) {
        String query = "UPDATE pickup_requests SET status = ? WHERE pickup_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, pickupId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deletePickupRequest(int pickupId) {
        String query = "DELETE FROM pickup_requests WHERE pickup_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, pickupId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Rewards Operations
    public boolean addRewardPoints(int userId, int points) {
        String checkQuery = "SELECT * FROM rewards WHERE user_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                String updateQuery = "UPDATE rewards SET points = points + ? WHERE user_id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, points);
                    updateStmt.setInt(2, userId);
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                String insertQuery = "INSERT INTO rewards (user_id, points) VALUES (?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, points);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getUserRewardPoints(int userId) {
        String query = "SELECT points FROM rewards WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("points");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Campaign Events Operations
    public boolean createCampaignEvent(CampaignEvent event) {
        String query = "INSERT INTO campaign_events (event_name, description, event_date) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, event.getEventName());
            pstmt.setString(2, event.getDescription());
            pstmt.setDate(3, event.getEventDate());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<CampaignEvent> getAllCampaignEvents() {
        List<CampaignEvent> events = new ArrayList<>();
        String query = "SELECT * FROM campaign_events ORDER BY event_date DESC";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                CampaignEvent event = new CampaignEvent();
                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getDate("event_date"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    public boolean registerVolunteer(int eventId, int userId) {
        String query = "INSERT INTO event_volunteers (event_id, user_id) VALUES (?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Marketplace Operations
    public boolean createMarketplaceListing(MarketplaceListing listing) {
        String query = "INSERT INTO marketplace_listings (seller_id, seller_type, plastic_type, quantity, price) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, listing.getSellerId());
            pstmt.setString(2, listing.getSellerType());
            pstmt.setString(3, listing.getPlasticType());
            pstmt.setDouble(4, listing.getQuantity());
            pstmt.setDouble(5, listing.getPrice());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<MarketplaceListing> getAllMarketplaceListings() {
        List<MarketplaceListing> listings = new ArrayList<>();
        String query = "SELECT * FROM marketplace_listings";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                MarketplaceListing listing = new MarketplaceListing();
                listing.setListingId(rs.getInt("listing_id"));
                listing.setSellerId(rs.getInt("seller_id"));
                listing.setSellerType(rs.getString("seller_type"));
                listing.setPlasticType(rs.getString("plastic_type"));
                listing.setQuantity(rs.getDouble("quantity"));
                listing.setPrice(rs.getDouble("price"));
                listings.add(listing);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public boolean createMarketplaceOrder(MarketplaceOrder order) {
        String query = "INSERT INTO marketplace_orders (listing_id, buyer_id, buyer_type, quantity) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, order.getListingId());
            pstmt.setInt(2, order.getBuyerId());
            pstmt.setString(3, order.getBuyerType());
            pstmt.setDouble(4, order.getQuantity());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Complaints Operations
    public boolean createComplaint(Complaint complaint) {
        String query = "INSERT INTO complaints (user_id, complaint_type, description, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, complaint.getUserId());
            pstmt.setString(2, complaint.getComplaintType());
            pstmt.setString(3, complaint.getDescription());
            pstmt.setString(4, complaint.getStatus());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Complaint> getAllComplaints() {
        List<Complaint> complaints = new ArrayList<>();
        String query = "SELECT * FROM complaints ORDER BY complaint_id DESC";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaint_id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setComplaintType(rs.getString("complaint_type"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaints.add(complaint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaints;
    }
    
    public List<Complaint> getComplaintsByUser(int userId) {
        List<Complaint> complaints = new ArrayList<>();
        String query = "SELECT * FROM complaints WHERE user_id = ? ORDER BY complaint_id DESC";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaint_id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setComplaintType(rs.getString("complaint_type"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaints.add(complaint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaints;
    }
    
    public boolean updateComplaintStatus(int complaintId, String status) {
        String query = "UPDATE complaints SET status = ? WHERE complaint_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, complaintId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Leaderboard Operations
    public List<User> getTopUsers() {
        List<User> topUsers = new ArrayList<>();
        String query = "SELECT u.*, COALESCE(SUM(wc.collected_quantity), 0) as total_recycled " +
                       "FROM users u " +
                       "LEFT JOIN pickup_requests pr ON u.user_id = pr.user_id " +
                       "LEFT JOIN waste_collection wc ON pr.pickup_id = wc.pickup_id " +
                       "WHERE u.status = 'Approved' " +
                       "GROUP BY u.user_id " +
                       "ORDER BY total_recycled DESC " +
                       "LIMIT 10";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setTotalRecycled(rs.getDouble("total_recycled"));
                topUsers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topUsers;
    }
    
    public List<Recycler> getTopRecyclers() {
        List<Recycler> topRecyclers = new ArrayList<>();
        String query = "SELECT r.*, COALESCE(SUM(wc.collected_quantity), 0) as total_collected " +
                       "FROM recycler r " +
                       "LEFT JOIN waste_collection wc ON r.recycler_id = wc.recycler_id " +
                       "WHERE r.status = 'Approved' " +
                       "GROUP BY r.recycler_id " +
                       "ORDER BY total_collected DESC " +
                       "LIMIT 10";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Recycler recycler = new Recycler();
                recycler.setRecyclerId(rs.getInt("recycler_id"));
                recycler.setName(rs.getString("name"));
                recycler.setPhone(rs.getString("phone"));
                recycler.setServiceArea(rs.getString("service_area"));
                recycler.setTotalCollected(rs.getDouble("total_collected"));
                topRecyclers.add(recycler);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topRecyclers;
    }
    
    // Reports Operations
    public double getTotalPlasticCollected() {
        String query = "SELECT COALESCE(SUM(collected_quantity), 0) as total FROM waste_collection";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalCampaignParticipants() {
        String query = "SELECT COUNT(DISTINCT user_id) as total FROM event_volunteers";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
 // Add these methods to the existing ETrashDAO class

    public boolean isVolunteerRegistered(int eventId, int userId) {
        String query = "SELECT * FROM event_volunteers WHERE event_id = ? AND user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getVolunteerCount(int eventId) {
        String query = "SELECT COUNT(*) as count FROM event_volunteers WHERE event_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<EventVolunteer> getEventVolunteers(int eventId) {
        List<EventVolunteer> volunteers = new ArrayList<>();
        String query = "SELECT ev.*, u.name, u.email, u.phone " +
                       "FROM event_volunteers ev " +
                       "JOIN users u ON ev.user_id = u.user_id " +
                       "WHERE ev.event_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, eventId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                EventVolunteer volunteer = new EventVolunteer();
                volunteer.setVolunteerId(rs.getInt("volunteer_id"));
                volunteer.setEventId(rs.getInt("event_id"));
                volunteer.setUserId(rs.getInt("user_id"));
                volunteer.setUserName(rs.getString("name"));
                volunteer.setUserEmail(rs.getString("email"));
                volunteer.setUserPhone(rs.getString("phone"));
                volunteers.add(volunteer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return volunteers;
    }

    public MarketplaceListing getMarketplaceListingById(int listingId) {
        String query = "SELECT * FROM marketplace_listings WHERE listing_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, listingId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                MarketplaceListing listing = new MarketplaceListing();
                listing.setListingId(rs.getInt("listing_id"));
                listing.setSellerId(rs.getInt("seller_id"));
                listing.setSellerType(rs.getString("seller_type"));
                listing.setPlasticType(rs.getString("plastic_type"));
                listing.setQuantity(rs.getDouble("quantity"));
                listing.setPrice(rs.getDouble("price"));
                return listing;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateListingQuantity(int listingId, double quantity) {
        String query = "UPDATE marketplace_listings SET quantity = ? WHERE listing_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setDouble(1, quantity);
            pstmt.setInt(2, listingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteListing(int listingId) {
        String query = "DELETE FROM marketplace_listings WHERE listing_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, listingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<MarketplaceListing> getMarketplaceListingsBySeller(int sellerId, String sellerType) {
        List<MarketplaceListing> listings = new ArrayList<>();
        String query = "SELECT * FROM marketplace_listings WHERE seller_id = ? AND seller_type = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, sellerId);
            pstmt.setString(2, sellerType);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                MarketplaceListing listing = new MarketplaceListing();
                listing.setListingId(rs.getInt("listing_id"));
                listing.setSellerId(rs.getInt("seller_id"));
                listing.setSellerType(rs.getString("seller_type"));
                listing.setPlasticType(rs.getString("plastic_type"));
                listing.setQuantity(rs.getDouble("quantity"));
                listing.setPrice(rs.getDouble("price"));
                listings.add(listing);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }

    public int getTotalUsers() {
        String query = "SELECT COUNT(*) as count FROM users";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalRecyclers() {
        String query = "SELECT COUNT(*) as count FROM recycler";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalPickups() {
        String query = "SELECT COUNT(*) as count FROM pickup_requests";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalRewardPoints() {
        String query = "SELECT COALESCE(SUM(points), 0) as total FROM rewards";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public User getUserById(int userId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updateUserProfile(int userId, String name, String phone, String address) {
        String query = "UPDATE users SET name = ?, phone = ?, address = ? WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, address);
            pstmt.setInt(4, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateUserPassword(int userId, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getUserPickupCount(int userId) {
        String query = "SELECT COUNT(*) as count FROM pickup_requests WHERE user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getUserTotalRecycled(int userId) {
        String query = "SELECT COALESCE(SUM(wc.collected_quantity), 0) as total " +
                       "FROM waste_collection wc " +
                       "JOIN pickup_requests pr ON wc.pickup_id = pr.pickup_id " +
                       "WHERE pr.user_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getLeaderboard() {
        List<Map<String, Object>> leaderboard = new ArrayList<>();
        String query = "SELECT u.user_id, u.name, COALESCE(SUM(wc.collected_quantity), 0) as total_recycled, " +
                       "COALESCE(MAX(r.points), 0) as points " +
                       "FROM users u " +
                       "LEFT JOIN pickup_requests pr ON u.user_id = pr.user_id " +
                       "LEFT JOIN waste_collection wc ON pr.pickup_id = wc.pickup_id " +
                       "LEFT JOIN rewards r ON u.user_id = r.user_id " +
                       "WHERE u.status = 'Active' " +
                       "GROUP BY u.user_id, u.name " +
                       "ORDER BY total_recycled DESC " +
                       "LIMIT 10";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, Object> entry = new HashMap<>();
                entry.put("userId", rs.getInt("user_id"));
                entry.put("name", rs.getString("name"));
                entry.put("totalRecycled", rs.getDouble("total_recycled"));
                entry.put("points", rs.getInt("points"));
                leaderboard.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaderboard;
    }

    public List<PickupRequest> getPickupsInDateRange(String startDate, String endDate) {
        List<PickupRequest> pickups = new ArrayList<>();
        String query = "SELECT * FROM pickup_requests WHERE pickup_date BETWEEN ? AND ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PickupRequest request = new PickupRequest();
                request.setPickupId(rs.getInt("pickup_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setPlasticType(rs.getString("plastic_type"));
                request.setQuantity(rs.getDouble("quantity"));
                request.setPickupDate(rs.getDate("pickup_date"));
                request.setPickupTime(rs.getTime("pickup_time"));
                request.setRecyclerId(rs.getInt("recycler_id"));
                request.setStatus(rs.getString("status"));
                pickups.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pickups;
    }

    public double getTotalPlasticInDateRange(String startDate, String endDate) {
        String query = "SELECT COALESCE(SUM(wc.collected_quantity), 0) as total " +
                       "FROM waste_collection wc " +
                       "JOIN pickup_requests pr ON wc.pickup_id = pr.pickup_id " +
                       "WHERE pr.pickup_date BETWEEN ? AND ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<WasteCollection> getCollectionsInDateRange(String startDate, String endDate) {
        List<WasteCollection> collections = new ArrayList<>();
        String query = "SELECT * FROM waste_collection WHERE collection_date BETWEEN ? AND ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                WasteCollection collection = new WasteCollection();
                collection.setCollectionId(rs.getInt("collection_id"));
                collection.setPickupId(rs.getInt("pickup_id"));
                collection.setRecyclerId(rs.getInt("recycler_id"));
                collection.setCollectedQuantity(rs.getDouble("collected_quantity"));
                collection.setCollectionDate(rs.getDate("collection_date"));
                collections.add(collection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return collections;
    }

    public List<User> getNewUsersInDateRange(String startDate, String endDate) {
        // This assumes you have a registration_date field, if not, add it to users table
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE registration_date BETWEEN ? AND ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    /**
     * Get industry buyer by ID
     * @param buyerId The buyer ID to search for
     * @return IndustryBuyer object if found, null otherwise
     */
    public IndustryBuyer getIndustryBuyerById(int buyerId) {
        String query = "SELECT * FROM industry_buyers WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, buyerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                IndustryBuyer buyer = new IndustryBuyer();
                buyer.setBuyerId(rs.getInt("buyer_id"));
                buyer.setIndustryName(rs.getString("industry_name"));
                buyer.setContactPerson(rs.getString("contact_person"));
                buyer.setPhone(rs.getString("phone"));
                buyer.setPassword(rs.getString("password")); // Include password for validation
                return buyer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update industry buyer information
     * @param buyer The IndustryBuyer object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateIndustryBuyer(IndustryBuyer buyer) {
        String query = "UPDATE industry_buyers SET industry_name = ?, contact_person = ?, phone = ? WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, buyer.getIndustryName());
            pstmt.setString(2, buyer.getContactPerson());
            pstmt.setString(3, buyer.getPhone());
            pstmt.setInt(4, buyer.getBuyerId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validate industry buyer password
     * @param buyerId The buyer ID
     * @param password The password to validate
     * @return true if password matches, false otherwise
     */
    public boolean validateIndustryBuyerPassword(int buyerId, String password) {
        String query = "SELECT * FROM industry_buyers WHERE buyer_id = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, buyerId);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            return rs.next(); // Returns true if a record is found
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update industry buyer password
     * @param buyerId The buyer ID
     * @param newPassword The new password to set
     * @return true if update successful, false otherwise
     */
    public boolean updateIndustryBuyerPassword(int buyerId, String newPassword) {
        String query = "UPDATE industry_buyers SET password = ? WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, buyerId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all industry buyers (for admin management)
     * @return List of all industry buyers
     */
    public List<IndustryBuyer> getAllIndustryBuyers() {
        List<IndustryBuyer> buyers = new ArrayList<>();
        String query = "SELECT * FROM industry_buyers ORDER BY buyer_id DESC";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                IndustryBuyer buyer = new IndustryBuyer();
                buyer.setBuyerId(rs.getInt("buyer_id"));
                buyer.setIndustryName(rs.getString("industry_name"));
                buyer.setContactPerson(rs.getString("contact_person"));
                buyer.setPhone(rs.getString("phone"));
                buyers.add(buyer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return buyers;
    }

    /**
     * Delete industry buyer (for admin management)
     * @param buyerId The buyer ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteIndustryBuyer(int buyerId) {
        // First delete any marketplace orders associated with this buyer
        String deleteOrdersQuery = "DELETE FROM marketplace_orders WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(deleteOrdersQuery)) {
            pstmt.setInt(1, buyerId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Then delete the buyer
        String deleteBuyerQuery = "DELETE FROM industry_buyers WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(deleteBuyerQuery)) {
            pstmt.setInt(1, buyerId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get industry buyer purchase statistics
     * @param buyerId The buyer ID
     * @return Map containing purchase statistics
     */
    public Map<String, Object> getIndustryBuyerStatistics(int buyerId) {
        Map<String, Object> stats = new HashMap<>();
        
        // Total purchases count
        String countQuery = "SELECT COUNT(*) as total_orders FROM marketplace_orders WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(countQuery)) {
            pstmt.setInt(1, buyerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                stats.put("totalOrders", rs.getInt("total_orders"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Total quantity purchased
        String quantityQuery = "SELECT COALESCE(SUM(quantity), 0) as total_quantity FROM marketplace_orders WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(quantityQuery)) {
            pstmt.setInt(1, buyerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                stats.put("totalQuantity", rs.getDouble("total_quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Total spent (calculate by joining with listings)
        String spentQuery = "SELECT COALESCE(SUM(mo.quantity * ml.price), 0) as total_spent " +
                            "FROM marketplace_orders mo " +
                            "JOIN marketplace_listings ml ON mo.listing_id = ml.listing_id " +
                            "WHERE mo.buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(spentQuery)) {
            pstmt.setInt(1, buyerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                stats.put("totalSpent", rs.getDouble("total_spent"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }

    /**
     * Get purchase history for an industry buyer
     * @param buyerId The buyer ID
     * @return List of purchases with details
     */
    public List<Map<String, Object>> getIndustryPurchaseHistory(int buyerId) {
        List<Map<String, Object>> purchases = new ArrayList<>();
        String query = "SELECT mo.order_id, mo.quantity as order_quantity, mo.listing_id, " +
                       "ml.plastic_type, ml.quantity as listing_quantity, ml.price, " +
                       "ml.seller_id, ml.seller_type, " +
                       "mo.order_id, mo.quantity " +
                       "FROM marketplace_orders mo " +
                       "JOIN marketplace_listings ml ON mo.listing_id = ml.listing_id " +
                       "WHERE mo.buyer_id = ? " +
                       "ORDER BY mo.order_id DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, buyerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> purchase = new HashMap<>();
                purchase.put("orderId", rs.getInt("order_id"));
                purchase.put("listingId", rs.getInt("listing_id"));
                purchase.put("plasticType", rs.getString("plastic_type"));
                purchase.put("quantity", rs.getDouble("order_quantity"));
                purchase.put("price", rs.getDouble("price"));
                purchase.put("total", rs.getDouble("order_quantity") * rs.getDouble("price"));
                purchase.put("sellerId", rs.getInt("seller_id"));
                purchase.put("sellerType", rs.getString("seller_type"));
                
                // Get seller name based on seller type
                if ("user".equals(rs.getString("seller_type"))) {
                    String sellerQuery = "SELECT name FROM users WHERE user_id = ?";
                    try (PreparedStatement sellerStmt = connection.prepareStatement(sellerQuery)) {
                        sellerStmt.setInt(1, rs.getInt("seller_id"));
                        ResultSet sellerRs = sellerStmt.executeQuery();
                        if (sellerRs.next()) {
                            purchase.put("sellerName", sellerRs.getString("name"));
                        }
                    }
                } else if ("recycler".equals(rs.getString("seller_type"))) {
                    String sellerQuery = "SELECT name FROM recycler WHERE recycler_id = ?";
                    try (PreparedStatement sellerStmt = connection.prepareStatement(sellerQuery)) {
                        sellerStmt.setInt(1, rs.getInt("seller_id"));
                        ResultSet sellerRs = sellerStmt.executeQuery();
                        if (sellerRs.next()) {
                            purchase.put("sellerName", sellerRs.getString("name"));
                        }
                    }
                }
                
                purchases.add(purchase);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return purchases;
    }

    /**
     * Check if phone number already exists for industry buyer
     * @param phone The phone number to check
     * @return true if exists, false otherwise
     */
    public boolean isIndustryPhoneExists(String phone) {
        String query = "SELECT * FROM industry_buyers WHERE phone = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, phone);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update industry buyer status (for future use if needed)
     * @param buyerId The buyer ID
     * @param status The new status
     * @return true if update successful, false otherwise
     */
    public boolean updateIndustryBuyerStatus(int buyerId, String status) {
        // First check if status column exists in industry_buyers table
        // If not, you'll need to add it to the database schema
        String query = "UPDATE industry_buyers SET status = ? WHERE buyer_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, buyerId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            // If column doesn't exist, return false
            return false;
        }
    }
    
    /**
     * Get all waste collections by recycler
     * @param recyclerId The recycler ID
     * @return List of WasteCollection objects with pickup details
     */
    public List<Map<String, Object>> getCollectionsByRecycler(int recyclerId) {
        List<Map<String, Object>> collections = new ArrayList<>();
        String query = "SELECT wc.*, pr.user_id, pr.plastic_type, u.address " +
                       "FROM waste_collection wc " +
                       "JOIN pickup_requests pr ON wc.pickup_id = pr.pickup_id " +
                       "JOIN users u ON pr.user_id = u.user_id " +
                       "WHERE wc.recycler_id = ? " +
                       "ORDER BY wc.collection_date DESC";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, recyclerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> collection = new HashMap<>();
                collection.put("collectionId", rs.getInt("collection_id"));
                collection.put("pickupId", rs.getInt("pickup_id"));
                collection.put("userId", rs.getInt("user_id"));
                collection.put("plasticType", rs.getString("plastic_type"));
                collection.put("collectedQuantity", rs.getDouble("collected_quantity"));
                collection.put("collectionDate", rs.getDate("collection_date"));
                collection.put("address", rs.getString("address"));
                collections.add(collection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return collections;
    }
    
    /**
     * Get recycler by ID
     * @param recyclerId The recycler ID
     * @return Recycler object or null
     */
    public Recycler getRecyclerById(int recyclerId) {
        String query = "SELECT * FROM recycler WHERE recycler_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, recyclerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Recycler recycler = new Recycler();
                recycler.setRecyclerId(rs.getInt("recycler_id"));
                recycler.setName(rs.getString("name"));
                recycler.setPhone(rs.getString("phone"));
                recycler.setStatus(rs.getString("status"));
                return recycler;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Update recycler profile
     * @param recycler The recycler with updated data
     * @return true if update successful, false otherwise
     */
    public boolean updateRecycler(Recycler recycler) {
        String query = "UPDATE recycler SET name = ?, phone = ? WHERE recycler_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, recycler.getName());
            pstmt.setString(2, recycler.getPhone());
            pstmt.setInt(3, recycler.getRecyclerId());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update recycler password
     * @param recyclerId The recycler ID
     * @param newPassword The new password
     * @return true if update successful, false otherwise
     */
    public boolean updateRecyclerPassword(int recyclerId, String newPassword) {
        String query = "UPDATE recycler SET password = ? WHERE recycler_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, recyclerId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}