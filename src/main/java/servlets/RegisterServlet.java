package servlets;

import service.UserService;
import service.RecyclerService;
import model.User;
import model.Recycler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    private UserService userService;
    private RecyclerService recyclerService;
    
    @Override
    public void init() {
        userService = new UserService();
        recyclerService = new RecyclerService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String message;
        
        if ("user".equals(userType)) {
            User user = new User();
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            user.setPassword(request.getParameter("password"));
            user.setStatus("Inactive");
            
            message = userService.registerUser(user);
        } else {
            Recycler recycler = new Recycler();
            recycler.setName(request.getParameter("name"));
            recycler.setPhone(request.getParameter("phone"));
            recycler.setServiceArea(request.getParameter("serviceArea"));
            recycler.setPassword(request.getParameter("password"));
            recycler.setStatus("Inactive");
            
            message = recyclerService.registerRecycler(recycler);
        }
        
        request.setAttribute("message", message);
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}