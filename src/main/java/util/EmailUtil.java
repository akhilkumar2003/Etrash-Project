package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "your-email@gmail.com";
    private static final String SMTP_PASSWORD = "your-app-password";
    
    private static Properties getProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        return props;
    }
    
    public static boolean sendEmail(String to, String subject, String content) {
        Session session = Session.getInstance(getProperties(), new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static void sendRegistrationConfirmation(String to, String name) {
        String subject = "Welcome to E-Trash Platform";
        String content = "<h2>Welcome " + name + "!</h2>"
                + "<p>Thank you for registering with E-Trash platform.</p>"
                + "<p>Your account is pending approval from admin. You will receive another email once your account is approved.</p>"
                + "<p>Together we can make a difference in plastic waste management!</p>";
        sendEmail(to, subject, content);
    }
    
    public static void sendAccountApproved(String to, String name) {
        String subject = "Account Approved - E-Trash Platform";
        String content = "<h2>Congratulations " + name + "!</h2>"
                + "<p>Your account has been approved by the admin.</p>"
                + "<p>You can now login and start using the platform.</p>"
                + "<p><a href='http://localhost:8080/E-Trash/login.jsp'>Click here to login</a></p>";
        sendEmail(to, subject, content);
    }
    
    public static void sendPickupConfirmation(String to, String name, String qrCode, String date) {
        String subject = "Pickup Request Confirmed - E-Trash";
        String content = "<h2>Hello " + name + "!</h2>"
                + "<p>Your pickup request has been confirmed.</p>"
                + "<p><strong>QR Code:</strong> " + qrCode + "</p>"
                + "<p><strong>Pickup Date:</strong> " + date + "</p>"
                + "<p>Please show this QR code to the recycler at the time of pickup.</p>";
        sendEmail(to, subject, content);
    }
    
    public static void sendPickupCompleted(String to, String name, double quantity, int points) {
        String subject = "Pickup Completed - E-Trash";
        String content = "<h2>Hello " + name + "!</h2>"
                + "<p>Your pickup has been completed successfully.</p>"
                + "<p><strong>Quantity Collected:</strong> " + quantity + " kg</p>"
                + "<p><strong>Reward Points Earned:</strong> " + points + "</p>"
                + "<p>Thank you for contributing to a cleaner environment!</p>";
        sendEmail(to, subject, content);
    }
    
    public static void sendComplaintUpdate(String to, String name, int complaintId, String status) {
        String subject = "Complaint Update - E-Trash";
        String content = "<h2>Hello " + name + "!</h2>"
                + "<p>Your complaint #" + complaintId + " has been updated.</p>"
                + "<p><strong>New Status:</strong> " + status + "</p>"
                + "<p>Thank you for your patience.</p>";
        sendEmail(to, subject, content);
    }
}