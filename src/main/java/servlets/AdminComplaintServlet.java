package servlets;

import service.ComplaintService;
import model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_complaints")
public class AdminComplaintServlet extends HttpServlet {
    
    private ComplaintService complaintService;
    
    @Override
    public void init() {
        complaintService = new ComplaintService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Complaint> complaints = complaintService.getAllComplaints();
        request.setAttribute("complaints", complaints);
        request.getRequestDispatcher("/admin_complaints.jsp").forward(request, response);
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
        
        if ("resolve".equals(action)) {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            message = complaintService.resolveComplaint(complaintId);
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}