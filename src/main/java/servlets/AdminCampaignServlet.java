package servlets;

import service.CampaignService;
import model.CampaignEvent;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_campaigns")
public class AdminCampaignServlet extends HttpServlet {
    
    private CampaignService campaignService;
    
    @Override
    public void init() {
        campaignService = new CampaignService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if ("view".equals(action)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            // Get volunteers for this event
            request.setAttribute("volunteers", campaignService.getEventVolunteers(eventId));
        }
        
        List<CampaignEvent> events = campaignService.getAllCampaigns();
        request.setAttribute("events", events);
        
        // Set volunteer counts
        for (CampaignEvent event : events) {
            request.setAttribute("volunteerCount_" + event.getEventId(), 
                               campaignService.getVolunteerCount(event.getEventId()));
        }
        
        request.getRequestDispatcher("/admin_campaigns.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String message;
        
        if ("add".equals(action)) {
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String eventDate = request.getParameter("eventDate");
            
            message = campaignService.createCampaign(eventName, description, eventDate);
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}