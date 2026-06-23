package model;

public class RecyclingCenter {
    private int centerId;
    private String centerName;
    private String address;
    private String contactNumber;
    
    public RecyclingCenter() {}
    
    public RecyclingCenter(String centerName, String address, String contactNumber) {
        this.centerName = centerName;
        this.address = address;
        this.contactNumber = contactNumber;
    }
    
    // Getters and Setters
    public int getCenterId() { return centerId; }
    public void setCenterId(int centerId) { this.centerId = centerId; }
    
    public String getCenterName() { return centerName; }
    public void setCenterName(String centerName) { this.centerName = centerName; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
}