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

@WebServlet("/user_marketplace")
public class UserMarketplaceServlet extends HttpServlet {
    
    private MarketplaceService marketplaceService;
    
    @Override
    public void init() {
        marketplaceService = new MarketplaceService();
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
        
        List<MarketplaceListing> listings = marketplaceService.getAllListings();
        List<MarketplaceListing> myListings = marketplaceService.getListingsBySeller(userId, "user");
        
        request.setAttribute("listings", listings);
        request.setAttribute("myListings", myListings);
        
        request.getRequestDispatcher("/user_marketplace.jsp").forward(request, response);
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
        String message;
        
        if ("sell".equals(action)) {
            String plasticType = request.getParameter("plasticType");
            String quantity = request.getParameter("quantity");
            String price = request.getParameter("price");
            
            message = marketplaceService.createListing(userId, "user", plasticType, quantity, price);
        } else if ("buy".equals(action)) {
            int listingId = Integer.parseInt(request.getParameter("listingId"));
            String quantity = request.getParameter("quantity");
            
            message = marketplaceService.purchaseListing(listingId, userId, "user", quantity);
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}