package service;

import dao.ETrashDAO;
import model.User;
import util.ValidationUtil;
import java.util.List;

public class UserService {
    
    private ETrashDAO dao;
    
    public UserService() {
        dao = new ETrashDAO();
    }
    
    public String registerUser(User user) {
        if (!ValidationUtil.isNotEmpty(user.getName())) {
            return "Name is required";
        }
        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            return "Invalid email format";
        }
        if (!ValidationUtil.isValidPhone(user.getPhone())) {
            return "Phone number must be 10 digits";
        }
        if (!ValidationUtil.isValidPassword(user.getPassword())) {
            return "Password must be at least 6 characters";
        }
        if (!ValidationUtil.isNotEmpty(user.getAddress())) {
            return "Address is required";
        }
        
        if (dao.registerUser(user)) {
            return "Registration successful. Please wait for admin to activate your account.";
        }
        return "Registration failed. Email may already exist.";
    }
    
    public User loginUser(String email, String password) {
        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isValidPassword(password)) {
            return null;
        }
        return dao.validateUser(email, password);
    }
    
    public List<User> getAllUsers() {
        return dao.getAllUsers();
    }
    
    public String approveUser(int userId) {
        if (dao.updateUserStatus(userId, "Active")) {
            return "User activated successfully";
        }
        return "Failed to activate user";
    }
    
    public String rejectUser(int userId) {
        if (dao.updateUserStatus(userId, "Inactive")) {
            return "User deactivated successfully";
        }
        return "Failed to deactivate user";
    }
    
    public String deleteUser(int userId) {
        if (dao.deleteUser(userId)) {
            return "User deleted successfully";
        }
        return "Failed to delete user";
    }
    
    public User getUserById(int userId) {
        return dao.getUserById(userId);
    }
    
    public String updateUserProfile(int userId, String name, String phone, String address) {
        if (!ValidationUtil.isNotEmpty(name)) {
            return "Name is required";
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            return "Phone number must be 10 digits";
        }
        if (!ValidationUtil.isNotEmpty(address)) {
            return "Address is required";
        }
        
        if (dao.updateUserProfile(userId, name, phone, address)) {
            return "Profile updated successfully";
        }
        return "Failed to update profile";
    }
    
    public String updateUserPassword(int userId, String currentPassword, String newPassword) {
        if (!ValidationUtil.isValidPassword(newPassword)) {
            return "Password must be at least 6 characters";
        }
        
        // Verify current password
        User user = dao.getUserById(userId);
        if (user == null || !user.getPassword().equals(currentPassword)) {
            return "Current password is incorrect";
        }
        
        if (dao.updateUserPassword(userId, newPassword)) {
            return "Password changed successfully";
        }
        return "Failed to change password";
    }
}