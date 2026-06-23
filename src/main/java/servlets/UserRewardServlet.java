package servlets;

import service.RewardService;
import dao.ETrashDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user_rewards")
public class UserRewardServlet extends HttpServlet {
    
    private RewardService rewardService;
    private ETrashDAO dao;
    
    @Override
    public void init() {
        rewardService = new RewardService();
        dao = new ETrashDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        int points = rewardService.getUserPoints(userId);
        double totalRecycled = dao.getUserTotalRecycled(userId);
        
        request.setAttribute("points", points);
        request.setAttribute("totalRecycled", totalRecycled);
        request.setAttribute("badge", rewardService.getBadge(points));
        
        request.getRequestDispatcher("/user_rewards.jsp").forward(request, response);
    }
}