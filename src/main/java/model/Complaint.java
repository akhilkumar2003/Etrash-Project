package model;

public class Complaint {
    private int complaintId;
    private int userId;
    private String complaintType;
    private String description;
    private String status;
    
    public Complaint() {}
    
    public Complaint(int userId, String complaintType, String description) {
        this.userId = userId;
        this.complaintType = complaintType;
        this.description = description;
        this.status = "Pending";
    }
    
    // Getters and Setters
    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getComplaintType() { return complaintType; }
    public void setComplaintType(String complaintType) { this.complaintType = complaintType; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}