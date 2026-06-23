package service;

import dao.ETrashDAO;
import model.Recycler;
import util.ValidationUtil;
import java.util.List;

public class RecyclerService {
    
    private ETrashDAO dao;
    
    public RecyclerService() {
        dao = new ETrashDAO();
    }
    
    public String registerRecycler(Recycler recycler) {
        if (!ValidationUtil.isNotEmpty(recycler.getName())) {
            return "Name is required";
        }
        if (!ValidationUtil.isValidPhone(recycler.getPhone())) {
            return "Phone number must be 10 digits";
        }
        if (!ValidationUtil.isNotEmpty(recycler.getServiceArea())) {
            return "Service area is required";
        }
        if (!ValidationUtil.isValidPassword(recycler.getPassword())) {
            return "Password must be at least 6 characters";
        }
        
        if (dao.registerRecycler(recycler)) {
            return "Registration successful. Please wait for admin to activate your account.";
        }
        return "Registration failed. Phone number may already exist.";
    }
    
    public Recycler loginRecycler(String phone, String password) {
        if (!ValidationUtil.isValidPhone(phone) || !ValidationUtil.isValidPassword(password)) {
            return null;
        }
        return dao.validateRecycler(phone, password);
    }
    
    public List<Recycler> getAllRecyclers() {
        return dao.getAllRecyclers();
    }
    
    public String approveRecycler(int recyclerId) {
        if (dao.updateRecyclerStatus(recyclerId, "Active")) {
            return "Recycler activated successfully";
        }
        return "Failed to activate recycler";
    }
    
    public String rejectRecycler(int recyclerId) {
        if (dao.updateRecyclerStatus(recyclerId, "Inactive")) {
            return "Recycler deactivated successfully";
        }
        return "Failed to deactivate recycler";
    }
    
    public String deleteRecycler(int recyclerId) {
        if (dao.deleteRecycler(recyclerId)) {
            return "Recycler deleted successfully";
        }
        return "Failed to delete recycler";
    }
}