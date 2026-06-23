package model;

public class IndustryBuyer {
    private int buyerId;
    private String industryName;
    private String contactPerson;
    private String phone;
    private String password;
    
    public IndustryBuyer() {}
    
    public IndustryBuyer(String industryName, String contactPerson, String phone, String password) {
        this.industryName = industryName;
        this.contactPerson = contactPerson;
        this.phone = phone;
        this.password = password;
    }
    
    // Getters and Setters
    public int getBuyerId() { return buyerId; }
    public void setBuyerId(int buyerId) { this.buyerId = buyerId; }
    
    public String getIndustryName() { return industryName; }
    public void setIndustryName(String industryName) { this.industryName = industryName; }
    
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}