package servlets;

import service.RecyclerService;
import model.Recycler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_recyclers")
public class AdminRecyclerManagementServlet extends HttpServlet {
    
    private RecyclerService recyclerService;
    
    @Override
    public void init() {
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
        
        List<Recycler> recyclers = recyclerService.getAllRecyclers();
        request.setAttribute("recyclers", recyclers);
        request.getRequestDispatcher("/admin_recyclers.jsp").forward(request, response);
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
        int recyclerId = Integer.parseInt(request.getParameter("recyclerId"));
        String message;
        
        if ("approve".equals(action)) {
            message = recyclerService.approveRecycler(recyclerId);
        } else if ("reject".equals(action)) {
            message = recyclerService.rejectRecycler(recyclerId);
        } else if ("delete".equals(action)) {
            message = recyclerService.deleteRecycler(recyclerId);
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}