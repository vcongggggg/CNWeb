package com.mobile.bo;

import com.mobile.dao.ProductDAO;
import com.mobile.model.Product;

import java.util.List;
import java.util.ArrayList;

public class ProductBO {
    private ProductDAO productDAO;
    
    public ProductBO() {
        this.productDAO = new ProductDAO();
    }
    
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Product> getPendingProducts() {
        return productDAO.getPendingProducts();
    }

    public boolean updateProductStatus(int productId, String status) {
        return productDAO.updateProductStatus(productId, status);
    }
    
    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }
    
    public List<Product> searchProducts(String keyword) {
        try {
            // Clean and validate keyword
            if (keyword == null) {
                keyword = "";
            }
            keyword = keyword.trim();
            
            // If keyword is empty, return all approved products
            if (keyword.isEmpty()) {
                return getAllProducts();
            }
            
            return productDAO.searchProducts(keyword);
        } catch (Exception e) {
            System.err.println("Error in ProductBO.searchProducts: " + e.getMessage());
            e.printStackTrace();
            // Return empty list instead of throwing exception
            return new ArrayList<>();
        }
    }
    
    public boolean addProduct(Product product) {
        // Validate product data
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() <= 0) {
            return false;
        }
        if (product.getStock() < 0) {
            return false;
        }
        
        return productDAO.addProduct(product);
    }
    
    public boolean updateProduct(Product product) {
        // Validate product data
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() <= 0) {
            return false;
        }
        if (product.getStock() < 0) {
            return false;
        }
        
        return productDAO.updateProduct(product);
    }
    
    public boolean deleteProduct(int id) {
        return productDAO.deleteProduct(id);
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productDAO.getProductsByCategory(category);
    }
    
    public List<Product> getProductsByBrand(String brand) {
        List<Product> allProducts = getAllProducts();
        return allProducts.stream()
                .filter(product -> brand.equals(product.getBrand()))
                .collect(java.util.stream.Collectors.toList());
    }
    
    public java.util.Map<String, Object> getProductStats() {
        return productDAO.getProductStats();
    }
    
    public boolean updateStockAfterOrder(int productId, int quantity) {
        return productDAO.updateStockAfterOrder(productId, quantity);
    }
    
    public boolean checkStockAvailability(int productId, int quantity) {
        return productDAO.checkStockAvailability(productId, quantity);
    }
    
    public List<Product> getProductsByIds(java.util.Set<Integer> productIds) {
        return productDAO.getProductsByIds(productIds);
    }
    
    public List<Product> getProductsBySellerId(int sellerId) {
        return productDAO.getProductsBySellerId(sellerId);
    }
    
    public boolean deleteProductBySeller(int productId, int sellerId) {
        return productDAO.deleteProductBySeller(productId, sellerId);
    }
    
    public boolean addProductBySeller(Product product, int sellerId) {
        // Validate product data
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() <= 0) {
            return false;
        }
        if (product.getStock() < 0) {
            return false;
        }
        if (product.getCondition() == null || product.getCondition().trim().isEmpty()) {
            return false;
        }
        
        // Set seller ID
        product.setSellerId(sellerId);
        
        return productDAO.addProduct(product);
    }
    
    public boolean updateProductBySeller(Product product, int sellerId) {
        // Validate product data
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() <= 0) {
            return false;
        }
        if (product.getStock() < 0) {
            return false;
        }
        if (product.getCondition() == null || product.getCondition().trim().isEmpty()) {
            return false;
        }
        
        // Verify seller ownership
        Product existingProduct = productDAO.getProductById(product.getId());
        if (existingProduct == null || existingProduct.getSellerId() != sellerId) {
            return false;
        }
        
        return productDAO.updateProduct(product);
    }
} 