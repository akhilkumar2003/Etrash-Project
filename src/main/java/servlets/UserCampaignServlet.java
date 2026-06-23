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

@WebServlet("/user_campaigns")
public class UserCampaignServlet extends HttpServlet {
    
    private CampaignService campaignService;
    
    @Override
    public void init() {
        campaignService = new CampaignService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<CampaignEvent> events = campaignService.getAllCampaigns();
        request.setAttribute("events", events);
        request.getRequestDispatcher("/user_campaigns.jsp").forward(request, response);
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
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        
        String message = campaignService.registerVolunteer(eventId, userId);
        request.setAttribute("message", message);
        
        doGet(request, response);
    }
}