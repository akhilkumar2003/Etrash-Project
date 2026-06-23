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

@WebServlet("/recycler_history")
public class RecyclerHistoryServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        dao = new ETrashDAO();
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
        
        // Get collection history
        List<Map<String, Object>> collections = dao.getCollectionsByRecycler(recyclerId);
        request.setAttribute("collections", collections);
        
        // Calculate statistics
        double totalQuantity = 0.0;
        for (Map<String, Object> collection : collections) {
            totalQuantity += (double) collection.get("collectedQuantity");
        }
        
        request.setAttribute("totalCollections", collections.size());
        request.setAttribute("totalQuantity", totalQuantity);
        
        request.getRequestDispatcher("/recycler_history.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
