package servlets;

import dao.ETrashDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/industry_purchases")
public class IndustryPurchasesServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect("industry_login.jsp");
            return;
        }
        
        int buyerId = (int) session.getAttribute("buyerId");
        
        // Get purchase history
        List<Map<String, Object>> purchases = dao.getIndustryPurchaseHistory(buyerId);
        request.setAttribute("purchases", purchases);
        
        // Get statistics
        Map<String, Object> stats = dao.getIndustryBuyerStatistics(buyerId);
        request.setAttribute("totalPurchases", stats.get("totalPurchases"));
        request.setAttribute("totalQuantity", stats.get("totalQuantity"));
        request.setAttribute("totalAmount", stats.get("totalAmount"));
        
        request.getRequestDispatcher("/industry_purchases.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
