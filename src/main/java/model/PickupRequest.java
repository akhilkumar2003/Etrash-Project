package model;

import java.sql.Date;
import java.sql.Time;

public class PickupRequest {
    private int pickupId;
    private int userId;
    private String plasticType;
    private double quantity;
    private Date pickupDate;
    private Time pickupTime;
    private Integer recyclerId;
    private String qrCode;
    private String status;
    
    public PickupRequest() {}
    
    public PickupRequest(int userId, String plasticType, double quantity, Date pickupDate, Time pickupTime, String qrCode) {
        this.userId = userId;
        this.plasticType = plasticType;
        this.quantity = quantity;
        this.pickupDate = pickupDate;
        this.pickupTime = pickupTime;
        this.qrCode = qrCode;
        this.status = "Pending";
    }
    
    // Getters and Setters
    public int getPickupId() { return pickupId; }
    public void setPickupId(int pickupId) { this.pickupId = pickupId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getPlasticType() { return plasticType; }
    public void setPlasticType(String plasticType) { this.plasticType = plasticType; }
    
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
    
    public Date getPickupDate() { return pickupDate; }
    public void setPickupDate(Date pickupDate) { this.pickupDate = pickupDate; }
    
    public Time getPickupTime() { return pickupTime; }
    public void setPickupTime(Time pickupTime) { this.pickupTime = pickupTime; }
    
    public Integer getRecyclerId() { return recyclerId; }
    public void setRecyclerId(Integer recyclerId) { this.recyclerId = recyclerId; }
    
    public String getQrCode() { return qrCode; }
    public void setQrCode(String qrCode) { this.qrCode = qrCode; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}