package model;

public class Rewards {
    private int rewardId;
    private int userId;
    private int points;
    
    public Rewards() {}
    
    public Rewards(int userId, int points) {
        this.userId = userId;
        this.points = points;
    }
    
    // Getters and Setters
    public int getRewardId() { return rewardId; }
    public void setRewardId(int rewardId) { this.rewardId = rewardId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
}