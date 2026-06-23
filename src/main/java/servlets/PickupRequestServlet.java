package servlets;

import service.PickupService;
import model.PickupRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/pickup_request")
public class PickupRequestServlet extends HttpServlet {
    
    private PickupService pickupService;
    
    @Override
    public void init() {
        pickupService = new PickupService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        List<PickupRequest> requests = pickupService.getUserPickupRequests(userId);
        request.setAttribute("requests", requests);
        request.getRequestDispatcher("/user_pickups.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        int userId = (int) session.getAttribute("userId");
        String message;
        
        if ("delete".equals(action)) {
            int pickupId = Integer.parseInt(request.getParameter("pickupId"));
            message = pickupService.deletePickupRequest(pickupId);
        } else {
            String plasticType = request.getParameter("plasticType");
            String quantity = request.getParameter("quantity");
            String pickupDate = request.getParameter("pickupDate");
            String pickupTime = request.getParameter("pickupTime");
            
            message = pickupService.createPickupRequest(userId, plasticType, quantity, pickupDate, pickupTime);
        }
        
        request.setAttribute("message", message);
        
        // Refresh the requests list
        List<PickupRequest> requests = pickupService.getUserPickupRequests(userId);
        request.setAttribute("requests", requests);
        request.getRequestDispatcher("/user_pickups.jsp").forward(request, response);
    }
}