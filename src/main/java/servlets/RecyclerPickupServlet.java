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

@WebServlet("/recycler_pickups")
public class RecyclerPickupServlet extends HttpServlet {
    
    private PickupService pickupService;
    
    @Override
    public void init() {
        pickupService = new PickupService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("recyclerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int recyclerId = (int) session.getAttribute("recyclerId");
        List<PickupRequest> pickups = pickupService.getAssignedPickups(recyclerId);
        request.setAttribute("pickups", pickups);
        request.getRequestDispatcher("/recycler_pickups.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("recyclerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int recyclerId = (int) session.getAttribute("recyclerId");
        String qrCode = request.getParameter("qrCode");
        String collectedQuantity = request.getParameter("collectedQuantity");
        
        String message = pickupService.completePickup(qrCode, recyclerId, collectedQuantity);
        request.setAttribute("message", message);
        
        doGet(request, response);
    }
}