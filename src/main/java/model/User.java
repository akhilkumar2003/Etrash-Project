package model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String password;
    private String status;
    
    public User() {}
    
    public User(String name, String email, String phone, String address, String password) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.status = "Pending";
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
 // Add these fields to existing User class
    private double totalRecycled;

    // Add getter and setter
    public double getTotalRecycled() { return totalRecycled; }
    public void setTotalRecycled(double totalRecycled) { this.totalRecycled = totalRecycled; }
}