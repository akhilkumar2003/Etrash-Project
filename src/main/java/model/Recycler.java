package model;

public class Recycler {
    private int recyclerId;
    private String name;
    private String phone;
    private String serviceArea;
    private String password;
    private String status;
    
    public Recycler() {}
    
    public Recycler(String name, String phone, String serviceArea, String password) {
        this.name = name;
        this.phone = phone;
        this.serviceArea = serviceArea;
        this.password = password;
        this.status = "Pending";
    }
    
    // Getters and Setters
    public int getRecyclerId() { return recyclerId; }
    public void setRecyclerId(int recyclerId) { this.recyclerId = recyclerId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getServiceArea() { return serviceArea; }
    public void setServiceArea(String serviceArea) { this.serviceArea = serviceArea; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
 // Add these fields to existing Recycler class
    private double totalCollected;

    // Add getter and setter
    public double getTotalCollected() { return totalCollected; }
    public void setTotalCollected(double totalCollected) { this.totalCollected = totalCollected; }
}