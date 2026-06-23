package servlets;

import service.UserService;
import service.RecyclerService;
import model.User;
import model.IndustryBuyer;
import model.Recycler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import dao.ETrashDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserService userService;
    private RecyclerService recyclerService;
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
        userService = new UserService();
        recyclerService = new RecyclerService();
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if ("user".equals(userType)) {
            User user = userService.loginUser(username, password);
            if (user != null) {
                if ("Active".equals(user.getStatus())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userName", user.getName());
                    session.setAttribute("userType", "user");
                    response.sendRedirect("user_dashboard.jsp");
                } else {
                    request.setAttribute("error", "Your account is not active. Please contact admin.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else if ("recycler".equals(userType)) {
            Recycler recycler = recyclerService.loginRecycler(username, password);
            if (recycler != null) {
                if ("Active".equals(recycler.getStatus())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("recyclerId", recycler.getRecyclerId());
                    session.setAttribute("recyclerName", recycler.getName());
                    session.setAttribute("userType", "recycler");
                    response.sendRedirect("recycler_dashboard.jsp");
                } else {
                    request.setAttribute("error", "Your account is not active. Please contact admin.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else if ("admin".equals(userType)) {
            if ("admin".equals(username) && "admin123".equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("adminId", 1);
                session.setAttribute("userType", "admin");
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid admin credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        }
        
        else if ("industry".equals(userType)) {
            IndustryBuyer buyer = dao.validateIndustryBuyer(username, password);
            if (buyer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("buyerId", buyer.getBuyerId());
                session.setAttribute("industryName", buyer.getIndustryName());
                session.setAttribute("contactPerson", buyer.getContactPerson());
                session.setAttribute("userType", "industry");
                response.sendRedirect("industry_dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("/industry_login.jsp").forward(request, response);
            }
        }
    }
}