package model;

import java.sql.Date;

public class CampaignEvent {
    private int eventId;
    private String eventName;
    private String description;
    private Date eventDate;
    
    public CampaignEvent() {}
    
    public CampaignEvent(String eventName, String description, Date eventDate) {
        this.eventName = eventName;
        this.description = description;
        this.eventDate = eventDate;
    }
    
    // Getters and Setters
    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }
    
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }
}