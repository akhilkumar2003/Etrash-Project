package service;

import dao.ETrashDAO;
import model.PickupRequest;
import model.WasteCollection;
import util.QRCodeGenerator;
import util.ValidationUtil;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class PickupService {
    
    private ETrashDAO dao;
    
    public PickupService() {
        dao = new ETrashDAO();
    }
    
    public String createPickupRequest(int userId, String plasticType, String quantity, String pickupDate, String pickupTime) {
        if (!ValidationUtil.isNotEmpty(plasticType)) {
            return "Plastic type is required";
        }
        if (!ValidationUtil.isValidQuantity(quantity)) {
            return "Invalid quantity";
        }
        if (pickupDate == null || pickupDate.isEmpty()) {
            return "Pickup date is required";
        }
        if (pickupTime == null || pickupTime.isEmpty()) {
            return "Pickup time is required";
        }
        
        PickupRequest request = new PickupRequest();
        request.setUserId(userId);
        request.setPlasticType(plasticType);
        request.setQuantity(Double.parseDouble(quantity));
        request.setPickupDate(Date.valueOf(pickupDate));
        request.setPickupTime(Time.valueOf(pickupTime + ":00"));
        request.setQrCode(QRCodeGenerator.generateQRCode());
        request.setStatus("Pending");
        
        if (dao.createPickupRequest(request)) {
            return "Pickup request created successfully. QR Code: " + request.getQrCode();
        }
        return "Failed to create pickup request";
    }
    
    public List<PickupRequest> getAllPickupRequests() {
        return dao.getAllPickupRequests();
    }
    
    public List<PickupRequest> getUserPickupRequests(int userId) {
        return dao.getPickupRequestsByUser(userId);
    }
    
    public List<PickupRequest> getAssignedPickups(int recyclerId) {
        return dao.getAssignedPickups(recyclerId);
    }
    
    public String assignRecycler(int pickupId, int recyclerId) {
        if (dao.assignRecycler(pickupId, recyclerId)) {
            return "Recycler assigned successfully";
        }
        return "Failed to assign recycler";
    }
    
    public String completePickup(String qrCode, int recyclerId, String collectedQuantity) {
        if (!ValidationUtil.isValidQuantity(collectedQuantity)) {
            return "Invalid collected quantity";
        }
        
        PickupRequest request = dao.getPickupRequestByQR(qrCode);
        if (request == null) {
            return "Invalid QR code";
        }
        
        if (!"Assigned".equals(request.getStatus())) {
            return "Pickup request is not in assigned state";
        }
        
        WasteCollection collection = new WasteCollection();
        collection.setPickupId(request.getPickupId());
        collection.setRecyclerId(recyclerId);
        collection.setCollectedQuantity(Double.parseDouble(collectedQuantity));
        collection.setCollectionDate(new Date(System.currentTimeMillis()));
        
        if (dao.recordWasteCollection(collection)) {
            dao.updatePickupStatus(request.getPickupId(), "Completed");
            
            // Add reward points (10 points per kg)
            int points = (int) (Double.parseDouble(collectedQuantity) * 10);
            dao.addRewardPoints(request.getUserId(), points);
            
            return "Pickup completed successfully. " + points + " reward points added to user.";
        }
        return "Failed to complete pickup";
    }
    
    public String deletePickupRequest(int pickupId) {
        if (dao.deletePickupRequest(pickupId)) {
            return "Pickup request deleted successfully";
        }
        return "Failed to delete pickup request";
    }
    
    public String cancelPickupRequest(int pickupId) {
        if (dao.updatePickupStatus(pickupId, "Cancelled")) {
            return "Pickup request cancelled successfully";
        }
        return "Failed to cancel pickup request";
    }
}