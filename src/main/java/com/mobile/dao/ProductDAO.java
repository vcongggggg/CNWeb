package com.mobile.dao;

import com.mobile.model.Product;
import com.mobile.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE status = 'approved' ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setStatus(rs.getString("status"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR brand LIKE ? OR description LIKE ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, brand, description, price, stock, image, category, seller_id, `condition`, warranty, location, contact_info, status, created_date, updated_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getBrand());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getImage());
            ps.setString(7, product.getCategory());
            ps.setInt(8, product.getSellerId());
            ps.setString(9, product.getCondition());
            ps.setString(10, product.getWarranty());
            ps.setString(11, product.getLocation());
            ps.setString(12, product.getContactInfo());
            ps.setString(13, product.getStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, brand=?, description=?, price=?, stock=?, image=?, category=?, `condition`=?, warranty=?, location=?, contact_info=?, updated_date=NOW() WHERE id=?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getBrand());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getImage());
            ps.setString(7, product.getCategory());
            ps.setString(8, product.getCondition());
            ps.setString(9, product.getWarranty());
            ps.setString(10, product.getLocation());
            ps.setString(11, product.getContactInfo());
            ps.setInt(12, product.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Product> getProductsByIds(java.util.Set<Integer> productIds) {
        List<Product> products = new ArrayList<>();
        if (productIds == null || productIds.isEmpty()) {
            return products;
        }
        
        // Build SQL with placeholders
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE id IN (");
        for (int i = 0; i < productIds.size(); i++) {
            if (i > 0) sql.append(",");
            sql.append("?");
        }
        sql.append(")");
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            for (Integer id : productIds) {
                ps.setInt(paramIndex++, id);
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getProductsBySellerId(int sellerId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE seller_id = ? ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setStatus(rs.getString("status"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean deleteProductBySeller(int productId, int sellerId) {
        String sql = "DELETE FROM products WHERE id = ? AND seller_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            ps.setInt(2, sellerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE brand = ? ORDER BY price DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public java.util.Map<String, Object> getProductStats() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sql = "SELECT category, COUNT(*) as total_products, AVG(price) as avg_price, SUM(stock) as total_stock FROM products GROUP BY category";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            java.util.List<java.util.Map<String, Object>> categoryStats = new java.util.ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> category = new java.util.HashMap<>();
                category.put("category", rs.getString("category"));
                category.put("total_products", rs.getInt("total_products"));
                category.put("avg_price", rs.getDouble("avg_price"));
                category.put("total_stock", rs.getInt("total_stock"));
                categoryStats.add(category);
            }
            stats.put("category_stats", categoryStats);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    public boolean updateStockAfterOrder(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean checkStockAvailability(int productId, int quantity) {
        String sql = "SELECT stock FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int currentStock = rs.getInt("stock");
                return currentStock >= quantity;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean restoreStockAfterCancellation(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock + ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Product> getPendingProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE status = 'pending' ORDER BY created_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategory(rs.getString("category"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setCondition(rs.getString("condition"));
                product.setWarranty(rs.getString("warranty"));
                product.setLocation(rs.getString("location"));
                product.setContactInfo(rs.getString("contact_info"));
                product.setStatus(rs.getString("status"));
                product.setCreatedDate(rs.getTimestamp("created_date"));
                product.setUpdatedDate(rs.getTimestamp("updated_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean updateProductStatus(int productId, String status) {
        String sql = "UPDATE products SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 