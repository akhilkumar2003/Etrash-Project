package service;

import dao.ETrashDAO;
import model.MarketplaceListing;
import model.MarketplaceOrder;
import util.ValidationUtil;
import java.util.List;

public class MarketplaceService {
    
    private ETrashDAO dao;
    
    public MarketplaceService() {
        dao = new ETrashDAO();
    }
    
    public String createListing(int sellerId, String sellerType, String plasticType, String quantity, String price) {
        if (!ValidationUtil.isNotEmpty(plasticType)) {
            return "Plastic type is required";
        }
        if (!ValidationUtil.isValidQuantity(quantity)) {
            return "Invalid quantity";
        }
        if (!ValidationUtil.isValidPrice(price)) {
            return "Invalid price";
        }
        
        MarketplaceListing listing = new MarketplaceListing();
        listing.setSellerId(sellerId);
        listing.setSellerType(sellerType);
        listing.setPlasticType(plasticType);
        listing.setQuantity(Double.parseDouble(quantity));
        listing.setPrice(Double.parseDouble(price));
        
        if (dao.createMarketplaceListing(listing)) {
            return "Listing created successfully";
        }
        return "Failed to create listing";
    }
    
    public List<MarketplaceListing> getAllListings() {
        return dao.getAllMarketplaceListings();
    }
    
    public List<MarketplaceListing> getListingsBySeller(int sellerId, String sellerType) {
        return dao.getMarketplaceListingsBySeller(sellerId, sellerType);
    }
    
    public String purchaseListing(int listingId, int buyerId, String buyerType, String quantity) {
        if (!ValidationUtil.isValidQuantity(quantity)) {
            return "Invalid quantity";
        }
        
        MarketplaceListing listing = dao.getMarketplaceListingById(listingId);
        if (listing == null) {
            return "Listing not found";
        }
        
        double qty = Double.parseDouble(quantity);
        if (qty > listing.getQuantity()) {
            return "Requested quantity exceeds available quantity";
        }
        
        MarketplaceOrder order = new MarketplaceOrder();
        order.setListingId(listingId);
        order.setBuyerId(buyerId);
        order.setBuyerType(buyerType);
        order.setQuantity(qty);
        
        if (dao.createMarketplaceOrder(order)) {
            // Update remaining quantity
            double remaining = listing.getQuantity() - qty;
            if (remaining > 0) {
                dao.updateListingQuantity(listingId, remaining);
            } else {
                dao.deleteListing(listingId);
            }
            return "Purchase successful";
        }
        return "Purchase failed";
    }
}