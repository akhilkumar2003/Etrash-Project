package service;

import dao.ETrashDAO;
import java.util.List;
import java.util.Map;

public class RewardService {
    
    private ETrashDAO dao;
    private static final int POINTS_PER_KG = 10;
    
    public RewardService() {
        dao = new ETrashDAO();
    }
    
    public int calculatePoints(double quantity) {
        return (int) (quantity * POINTS_PER_KG);
    }
    
    public String addRewardPoints(int userId, double quantity) {
        int points = calculatePoints(quantity);
        if (dao.addRewardPoints(userId, points)) {
            return points + " reward points added";
        }
        return "Failed to add reward points";
    }
    
    public int getUserPoints(int userId) {
        return dao.getUserRewardPoints(userId);
    }
    
    public List<Map<String, Object>> getLeaderboard() {
        return dao.getLeaderboard();
    }
    
    public String getBadge(int points) {
        if (points >= 1000) {
            return "Eco Champion";
        } else if (points >= 500) {
            return "Plastic Saver";
        } else if (points >= 100) {
            return "Green Warrior";
        } else {
            return "Beginner";
        }
    }
}