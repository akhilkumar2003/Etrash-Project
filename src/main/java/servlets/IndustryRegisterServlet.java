package servlets;

import dao.ETrashDAO;
import model.IndustryBuyer;
import util.ValidationUtil;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/industry_register")
public class IndustryRegisterServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String industryName = request.getParameter("industryName");
        String contactPerson = request.getParameter("contactPerson");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        
        // Validation
        if (!ValidationUtil.isNotEmpty(industryName)) {
            request.setAttribute("error", "Industry name is required");
            request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isNotEmpty(contactPerson)) {
            request.setAttribute("error", "Contact person name is required");
            request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Invalid phone number");
            request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 6 characters");
            request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
            return;
        }
        
        IndustryBuyer buyer = new IndustryBuyer(industryName, contactPerson, phone, password);
        
        if (dao.registerIndustryBuyer(buyer)) {
            // Send confirmation email
            EmailUtil.sendRegistrationConfirmation(contactPerson + "@email.com", contactPerson);
            request.setAttribute("message", "Registration successful! You can now login.");
            request.getRequestDispatcher("/industry_login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Phone number may already exist.");
            request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/industry_register.jsp").forward(request, response);
    }
}