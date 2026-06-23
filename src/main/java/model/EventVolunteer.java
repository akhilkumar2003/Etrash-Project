package model;

public class EventVolunteer {
    private int volunteerId;
    private int eventId;
    private int userId;
    private String userName;
    private String userEmail;
    private String userPhone;
    
    public EventVolunteer() {}
    
    public EventVolunteer(int eventId, int userId) {
        this.eventId = eventId;
        this.userId = userId;
    }
    
    // Getters and Setters
    public int getVolunteerId() { return volunteerId; }
    public void setVolunteerId(int volunteerId) { this.volunteerId = volunteerId; }
    
    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }
}