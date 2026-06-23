package servlets;

import dao.ETrashDAO;
import model.CampaignEvent;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/volunteer")
public class EventVolunteerServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get all campaign events
        List<CampaignEvent> events = dao.getAllCampaignEvents();
        request.setAttribute("events", events);
        
        int userId = (int) session.getAttribute("userId");
        
        // For each event, check if user is registered
        for (CampaignEvent event : events) {
            boolean isRegistered = dao.isVolunteerRegistered(event.getEventId(), userId);
            int volunteerCount = dao.getVolunteerCount(event.getEventId());
            event.setDescription(event.getDescription() + "|" + isRegistered + "|" + volunteerCount);
        }
        
        request.getRequestDispatcher("/volunteer.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            
            // Check if already registered
            if (dao.isVolunteerRegistered(eventId, userId)) {
                request.setAttribute("error", "You are already registered for this event!");
            } else {
                boolean registered = dao.registerVolunteer(eventId, userId);
                if (registered) {
                    request.setAttribute("message", "Successfully registered as a volunteer!");
                } else {
                    request.setAttribute("error", "Failed to register. Please try again.");
                }
            }
        }
        
        // Reload events
        doGet(request, response);
    }
}
