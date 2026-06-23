package servlets;

import dao.ETrashDAO;
import model.RecyclingCenter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_centers")
public class AdminCenterServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<RecyclingCenter> centers = dao.getAllRecyclingCenters();
        request.setAttribute("centers", centers);
        request.getRequestDispatcher("/admin_centers.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String message;
        
        if ("add".equals(action)) {
            String centerName = request.getParameter("centerName");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");
            
            RecyclingCenter center = new RecyclingCenter(centerName, address, contactNumber);
            if (dao.addRecyclingCenter(center)) {
                message = "Recycling center added successfully";
            } else {
                message = "Failed to add recycling center";
            }
        } else if ("delete".equals(action)) {
            int centerId = Integer.parseInt(request.getParameter("centerId"));
            if (dao.deleteRecyclingCenter(centerId)) {
                message = "Recycling center deleted successfully";
            } else {
                message = "Failed to delete recycling center";
            }
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}