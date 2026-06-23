package model;

import java.sql.Date;

public class WasteCollection {
    private int collectionId;
    private int pickupId;
    private int recyclerId;
    private double collectedQuantity;
    private Date collectionDate;
    
    public WasteCollection() {}
    
    public WasteCollection(int pickupId, int recyclerId, double collectedQuantity, Date collectionDate) {
        this.pickupId = pickupId;
        this.recyclerId = recyclerId;
        this.collectedQuantity = collectedQuantity;
        this.collectionDate = collectionDate;
    }
    
    // Getters and Setters
    public int getCollectionId() { return collectionId; }
    public void setCollectionId(int collectionId) { this.collectionId = collectionId; }
    
    public int getPickupId() { return pickupId; }
    public void setPickupId(int pickupId) { this.pickupId = pickupId; }
    
    public int getRecyclerId() { return recyclerId; }
    public void setRecyclerId(int recyclerId) { this.recyclerId = recyclerId; }
    
    public double getCollectedQuantity() { return collectedQuantity; }
    public void setCollectedQuantity(double collectedQuantity) { this.collectedQuantity = collectedQuantity; }
    
    public Date getCollectionDate() { return collectionDate; }
    public void setCollectionDate(Date collectionDate) { this.collectionDate = collectionDate; }
}