package service;

import dao.ETrashDAO;
import model.CampaignEvent;
import model.EventVolunteer;
import util.ValidationUtil;
import java.sql.Date;
import java.util.List;

public class CampaignService {
    
    private ETrashDAO dao;
    
    public CampaignService() {
        dao = new ETrashDAO();
    }
    
    public String createCampaign(String eventName, String description, String eventDate) {
        if (!ValidationUtil.isNotEmpty(eventName)) {
            return "Campaign name is required";
        }
        if (!ValidationUtil.isNotEmpty(description)) {
            return "Description is required";
        }
        if (eventDate == null || eventDate.isEmpty()) {
            return "Event date is required";
        }
        
        CampaignEvent event = new CampaignEvent();
        event.setEventName(eventName);
        event.setDescription(description);
        event.setEventDate(Date.valueOf(eventDate));
        
        if (dao.createCampaignEvent(event)) {
            return "Campaign created successfully";
        }
        return "Failed to create campaign";
    }
    
    public List<CampaignEvent> getAllCampaigns() {
        return dao.getAllCampaignEvents();
    }
    
    public String registerVolunteer(int eventId, int userId) {
        // Check if already registered
        if (dao.isVolunteerRegistered(eventId, userId)) {
            return "You are already registered for this event";
        }
        
        if (dao.registerVolunteer(eventId, userId)) {
            return "Successfully registered as volunteer";
        }
        return "Failed to register as volunteer";
    }
    
    public int getVolunteerCount(int eventId) {
        return dao.getVolunteerCount(eventId);
    }
    
    public List<EventVolunteer> getEventVolunteers(int eventId) {
        return dao.getEventVolunteers(eventId);
    }
}