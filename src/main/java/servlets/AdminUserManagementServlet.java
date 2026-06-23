package servlets;

import service.UserService;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin_users")
public class AdminUserManagementServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin_users.jsp").forward(request, response);
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
        int userId = Integer.parseInt(request.getParameter("userId"));
        String message;
        
        if ("approve".equals(action)) {
            message = userService.approveUser(userId);
        } else if ("reject".equals(action)) {
            message = userService.rejectUser(userId);
        } else if ("delete".equals(action)) {
            message = userService.deleteUser(userId);
        } else {
            message = "Invalid action";
        }
        
        request.setAttribute("message", message);
        doGet(request, response);
    }
}