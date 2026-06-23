package util;

import java.util.regex.Pattern;

public class ValidationUtil {
    
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && Pattern.matches(emailRegex, email);
    }
    
    public static boolean isValidPhone(String phone) {
        String phoneRegex = "^[0-9]{10}$";
        return phone != null && Pattern.matches(phoneRegex, phone);
    }
    
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
    
    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    public static boolean isValidQuantity(String quantity) {
        try {
            double q = Double.parseDouble(quantity);
            return q > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    public static boolean isValidPrice(String price) {
        try {
            double p = Double.parseDouble(price);
            return p >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}