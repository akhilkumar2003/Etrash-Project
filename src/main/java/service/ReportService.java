package service;

import dao.ETrashDAO;
import java.util.HashMap;
import java.util.Map;

public class ReportService {
    
    private ETrashDAO dao;
    
    public ReportService() {
        dao = new ETrashDAO();
    }
    
    public Map<String, Object> getSummaryReport() {
        Map<String, Object> report = new HashMap<>();
        
        report.put("totalUsers", dao.getTotalUsers());
        report.put("totalRecyclers", dao.getTotalRecyclers());
        report.put("totalPickups", dao.getTotalPickups());
        report.put("totalPlastic", dao.getTotalPlasticCollected());
        report.put("totalPoints", dao.getTotalRewardPoints());
        report.put("participants", dao.getTotalCampaignParticipants());
        
        // Calculate environmental impact
        double totalPlastic = (double) report.get("totalPlastic");
        report.put("co2Saved", totalPlastic * 3.0); // 3kg CO2 saved per kg plastic recycled
        report.put("energySaved", totalPlastic * 5.0); // 5kWh energy saved per kg plastic
        report.put("landfillReduction", totalPlastic * 2.0); // 2x volume reduction
        
        report.put("topUsers", dao.getTopUsers());
        report.put("topRecyclers", dao.getTopRecyclers());
        
        return report;
    }
    
    public Map<String, Object> getUserReport(int userId) {
        Map<String, Object> report = new HashMap<>();
        
        report.put("userDetails", dao.getUserById(userId));
        report.put("totalPickups", dao.getUserPickupCount(userId));
        report.put("totalRecycled", dao.getUserTotalRecycled(userId));
        report.put("rewardPoints", dao.getUserRewardPoints(userId));
        report.put("pickupHistory", dao.getPickupRequestsByUser(userId));
        report.put("complaints", dao.getComplaintsByUser(userId));
        
        return report;
    }
    
    public Map<String, Object> getDateRangeReport(String startDate, String endDate) {
        Map<String, Object> report = new HashMap<>();
        
        report.put("pickups", dao.getPickupsInDateRange(startDate, endDate));
        report.put("totalPlastic", dao.getTotalPlasticInDateRange(startDate, endDate));
        report.put("collections", dao.getCollectionsInDateRange(startDate, endDate));
        report.put("newUsers", dao.getNewUsersInDateRange(startDate, endDate));
        
        return report;
    }
}