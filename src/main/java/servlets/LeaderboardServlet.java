package servlets;

import dao.ETrashDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    
    private ETrashDAO dao;
    
    @Override
    public void init() {
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
        
        // Get leaderboard data
        List<Map<String, Object>> leaderboard = dao.getLeaderboard();
        request.setAttribute("leaderboard", leaderboard);
        
        // Find current user's rank and data
        int userRank = 0;
        Map<String, Object> userData = null;
        for (int i = 0; i < leaderboard.size(); i++) {
            Map<String, Object> entry = leaderboard.get(i);
            if ((int)entry.get("userId") == userId) {
                userRank = i + 1;
                userData = entry;
                break;
            }
        }
        
        request.setAttribute("userRank", userRank);
        request.setAttribute("userData", userData);
        
        // Get user statistics
        int pickupCount = dao.getUserPickupCount(userId);
        double totalRecycled = dao.getUserTotalRecycled(userId);
        int rewardPoints = dao.getUserRewardPoints(userId);
        
        request.setAttribute("pickupCount", pickupCount);
        request.setAttribute("totalRecycled", totalRecycled);
        request.setAttribute("rewardPoints", rewardPoints);
        
        // Calculate badge level based on achievements
        String badge = calculateBadge(pickupCount, totalRecycled, rewardPoints);
        request.setAttribute("badge", badge);
        
        request.getRequestDispatcher("/leaderboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private String calculateBadge(int pickupCount, double totalRecycled, int rewardPoints) {
        if (rewardPoints >= 1000 || totalRecycled >= 100) {
            return "platinum";
        } else if (rewardPoints >= 500 || totalRecycled >= 50) {
            return "gold";
        } else if (rewardPoints >= 250 || totalRecycled >= 25) {
            return "silver";
        } else if (rewardPoints >= 100 || totalRecycled >= 10) {
            return "bronze";
        } else {
            return "beginner";
        }
    }
}
