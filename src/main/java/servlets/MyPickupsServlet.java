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

@WebServlet("/my_pickups")
public class MyPickupsServlet extends HttpServlet {
    
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
        request.getRequestDispatcher("/my_pickups.jsp").forward(request, response);
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
        int pickupId = Integer.parseInt(request.getParameter("pickupId"));
        String message;
        
        if ("cancel".equals(action)) {
            message = pickupService.cancelPickupRequest(pickupId);
        } else {
            message = pickupService.deletePickupRequest(pickupId);
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}
