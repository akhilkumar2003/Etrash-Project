package util;

import java.util.UUID;

public class QRCodeGenerator {
    
    public static String generateQRCode() {
        return "QR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}