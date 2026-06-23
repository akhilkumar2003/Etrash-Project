package model;

public class MarketplaceOrder {
    private int orderId;
    private int listingId;
    private int buyerId;
    private String buyerType;
    private double quantity;
    
    public MarketplaceOrder() {}
    
    public MarketplaceOrder(int listingId, int buyerId, String buyerType, double quantity) {
        this.listingId = listingId;
        this.buyerId = buyerId;
        this.buyerType = buyerType;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    
    public int getListingId() { return listingId; }
    public void setListingId(int listingId) { this.listingId = listingId; }
    
    public int getBuyerId() { return buyerId; }
    public void setBuyerId(int buyerId) { this.buyerId = buyerId; }
    
    public String getBuyerType() { return buyerType; }
    public void setBuyerType(String buyerType) { this.buyerType = buyerType; }
    
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
}