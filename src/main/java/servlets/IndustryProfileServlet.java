package servlets;

import dao.ETrashDAO;
import model.IndustryBuyer;
import util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/industry_profile")
public class IndustryProfileServlet extends HttpServlet {
    
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
        IndustryBuyer buyer = dao.getIndustryBuyerById(buyerId);
        
        if (buyer != null) {
            request.setAttribute("buyer", buyer);
            // Get purchase statistics
            request.setAttribute("stats", dao.getIndustryBuyerStatistics(buyerId));
            request.setAttribute("purchases", dao.getIndustryPurchaseHistory(buyerId));
        }
        
        request.getRequestDispatcher("/industry_profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect("industry_login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String message = "";
        String messageType = "error";
        
        if ("update".equals(action)) {
            // Update profile
            int buyerId = (int) session.getAttribute("buyerId");
            String industryName = request.getParameter("industryName");
            String contactPerson = request.getParameter("contactPerson");
            String phone = request.getParameter("phone");
            
            // Validate inputs
            if (!ValidationUtil.isNotEmpty(industryName)) {
                message = "Industry name is required";
            } else if (!ValidationUtil.isNotEmpty(contactPerson)) {
                message = "Contact person name is required";
            } else if (!ValidationUtil.isValidPhone(phone)) {
                message = "Phone number must be 10 digits";
            } else {
                IndustryBuyer buyer = new IndustryBuyer();
                buyer.setBuyerId(buyerId);
                buyer.setIndustryName(industryName);
                buyer.setContactPerson(contactPerson);
                buyer.setPhone(phone);
                
                if (dao.updateIndustryBuyer(buyer)) {
                    // Update session attributes
                    session.setAttribute("industryName", industryName);
                    session.setAttribute("contactPerson", contactPerson);
                    message = "Profile updated successfully";
                    messageType = "success";
                } else {
                    message = "Failed to update profile";
                }
            }
            
        } else if ("changepassword".equals(action)) {
            // Change password
            int buyerId = (int) session.getAttribute("buyerId");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validate passwords
            if (!ValidationUtil.isValidPassword(currentPassword)) {
                message = "Current password is invalid";
            } else if (!ValidationUtil.isValidPassword(newPassword)) {
                message = "New password must be at least 6 characters";
            } else if (!newPassword.equals(confirmPassword)) {
                message = "New passwords do not match";
            } else if (currentPassword.equals(newPassword)) {
                message = "New password must be different from current password";
            } else {
                // Verify current password
                if (dao.validateIndustryBuyerPassword(buyerId, currentPassword)) {
                    if (dao.updateIndustryBuyerPassword(buyerId, newPassword)) {
                        message = "Password changed successfully";
                        messageType = "success";
                    } else {
                        message = "Failed to change password";
                    }
                } else {
                    message = "Current password is incorrect";
                }
            }
            
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        
        // Refresh the page with updated data
        doGet(request, response);
    }
}