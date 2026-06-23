package servlets;

import service.PickupService;
import service.RecyclerService;
import model.PickupRequest;
import model.Recycler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_pickups")
public class AdminPickupManagementServlet extends HttpServlet {
    
    private PickupService pickupService;
    private RecyclerService recyclerService;
    
    @Override
    public void init() {
        pickupService = new PickupService();
        recyclerService = new RecyclerService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<PickupRequest> requests = pickupService.getAllPickupRequests();
        List<Recycler> recyclers = recyclerService.getAllRecyclers();
        request.setAttribute("requests", requests);
        request.setAttribute("recyclers", recyclers);
        request.getRequestDispatcher("/admin_pickups.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int pickupId = Integer.parseInt(request.getParameter("pickupId"));
        int recyclerId = Integer.parseInt(request.getParameter("recyclerId"));
        
        String message = pickupService.assignRecycler(pickupId, recyclerId);
        request.setAttribute("message", message);
        
        doGet(request, response);
    }
}