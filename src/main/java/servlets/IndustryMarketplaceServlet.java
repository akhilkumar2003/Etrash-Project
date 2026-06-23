package servlets;

import service.MarketplaceService;
import model.MarketplaceListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/industry_marketplace")
public class IndustryMarketplaceServlet extends HttpServlet {
    
    private MarketplaceService marketplaceService;
    
    @Override
    public void init() {
        marketplaceService = new MarketplaceService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect("industry_login.jsp");
            return;
        }
        
        // Get all marketplace listings
        List<MarketplaceListing> listings = marketplaceService.getAllListings();
        request.setAttribute("listings", listings);
        
        request.getRequestDispatcher("/industry_marketplace.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect("industry_login.jsp");
            return;
        }
        
        int buyerId = (int) session.getAttribute("buyerId");
        String action = request.getParameter("action");
        String message;
        
        if ("purchase".equals(action)) {
            int listingId = Integer.parseInt(request.getParameter("listingId"));
            String quantity = request.getParameter("quantity");
            
            // If quantity not provided, default to full amount
            if (quantity == null || quantity.isEmpty()) {
                quantity = "0"; // This will be handled by the service to purchase full quantity
            }
            
            message = marketplaceService.purchaseListing(listingId, buyerId, "industry", quantity);
            request.setAttribute("message", message);
        }
        
        // Reload listings
        List<MarketplaceListing> listings = marketplaceService.getAllListings();
        request.setAttribute("listings", listings);
        
        request.getRequestDispatcher("/industry_marketplace.jsp").forward(request, response);
    }
}
