package model;

public class MarketplaceListing {
    private int listingId;
    private int sellerId;
    private String sellerType;
    private String plasticType;
    private double quantity;
    private double price;
    
    public MarketplaceListing() {}
    
    public MarketplaceListing(int sellerId, String sellerType, String plasticType, double quantity, double price) {
        this.sellerId = sellerId;
        this.sellerType = sellerType;
        this.plasticType = plasticType;
        this.quantity = quantity;
        this.price = price;
    }
    
    // Getters and Setters
    public int getListingId() { return listingId; }
    public void setListingId(int listingId) { this.listingId = listingId; }
    
    public int getSellerId() { return sellerId; }
    public void setSellerId(int sellerId) { this.sellerId = sellerId; }
    
    public String getSellerType() { return sellerType; }
    public void setSellerType(String sellerType) { this.sellerType = sellerType; }
    
    public String getPlasticType() { return plasticType; }
    public void setPlasticType(String plasticType) { this.plasticType = plasticType; }
    
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}