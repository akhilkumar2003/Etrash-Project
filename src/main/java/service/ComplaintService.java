package service;

import dao.ETrashDAO;
import model.Complaint;
import util.ValidationUtil;
import java.util.List;

public class ComplaintService {
    
    private ETrashDAO dao;
    
    public ComplaintService() {
        dao = new ETrashDAO();
    }
    
    public String submitComplaint(int userId, String complaintType, String description) {
        if (!ValidationUtil.isNotEmpty(complaintType)) {
            return "Complaint type is required";
        }
        if (!ValidationUtil.isNotEmpty(description)) {
            return "Description is required";
        }
        
        Complaint complaint = new Complaint(userId, complaintType, description);
        
        if (dao.createComplaint(complaint)) {
            return "Complaint submitted successfully";
        }
        return "Failed to submit complaint";
    }
    
    public List<Complaint> getAllComplaints() {
        return dao.getAllComplaints();
    }
    
    public List<Complaint> getUserComplaints(int userId) {
        return dao.getComplaintsByUser(userId);
    }
    
    public String resolveComplaint(int complaintId) {
        if (dao.updateComplaintStatus(complaintId, "Resolved")) {
            return "Complaint resolved successfully";
        }
        return "Failed to resolve complaint";
    }
}