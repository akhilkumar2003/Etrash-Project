package servlets;

import dao.ETrashDAO;
import model.Recycler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/recycler_profile")
public class RecyclerProfileServlet extends HttpServlet {
    
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
        Recycler recycler = dao.getRecyclerById(recyclerId);
        
        if (recycler != null) {
            request.setAttribute("recycler", recycler);
        }
        
        request.getRequestDispatcher("/recycler_profile.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            
            Recycler recycler = new Recycler();
            recycler.setRecyclerId(recyclerId);
            recycler.setName(name);
            recycler.setPhone(phone);
            
            boolean updated = dao.updateRecycler(recycler);
            if (updated) {
                session.setAttribute("recyclerName", name);
                request.setAttribute("message", "Profile updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
            
        } else if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validate that recycler exists and current password is correct
            Recycler recycler = dao.getRecyclerById(recyclerId);
            if (recycler == null) {
                request.setAttribute("error", "Recycler not found");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match");
            } else if (newPassword.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters");
            } else {
                // Update password
                boolean updated = dao.updateRecyclerPassword(recyclerId, newPassword);
                if (updated) {
                    request.setAttribute("message", "Password changed successfully!");
                } else {
                    request.setAttribute("error", "Failed to change password");
                }
            }
        }
        
        // Reload recycler data
        Recycler recycler = dao.getRecyclerById(recyclerId);
        request.setAttribute("recycler", recycler);
        request.getRequestDispatcher("/recycler_profile.jsp").forward(request, response);
    }
}
