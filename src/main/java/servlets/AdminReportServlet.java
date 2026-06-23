package servlets;

import service.ReportService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin_reports")
public class AdminReportServlet extends HttpServlet {
    
    private ReportService reportService;
    
    @Override
    public void init() {
        reportService = new ReportService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Map<String, Object> summaryReport = reportService.getSummaryReport();
        
        // Set all report attributes
        request.setAttribute("totalUsers", summaryReport.get("totalUsers"));
        request.setAttribute("totalRecyclers", summaryReport.get("totalRecyclers"));
        request.setAttribute("totalPickups", summaryReport.get("totalPickups"));
        request.setAttribute("totalPlastic", summaryReport.get("totalPlastic"));
        request.setAttribute("totalPoints", summaryReport.get("totalPoints"));
        request.setAttribute("participants", summaryReport.get("participants"));
        request.setAttribute("co2Saved", summaryReport.get("co2Saved"));
        request.setAttribute("energySaved", summaryReport.get("energySaved"));
        request.setAttribute("landfillReduction", summaryReport.get("landfillReduction"));
        request.setAttribute("topUsers", summaryReport.get("topUsers"));
        request.setAttribute("topRecyclers", summaryReport.get("topRecyclers"));
        
        request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
    }
}