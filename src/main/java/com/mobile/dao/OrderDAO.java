package com.mobile.dao;

import com.mobile.model.Order;
import com.mobile.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE status = ? ORDER BY order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int addOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, order_date, total_amount, status, shipping_address, payment_method) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getUserId());
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setDouble(3, order.getTotalAmount());
            stmt.setString(4, order.getStatus());
            stmt.setString(5, order.getShippingAddress());
            stmt.setString(6, order.getPaymentMethod());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateOrder(Order order) {
        String sql = "UPDATE orders SET user_id = ?, total_amount = ?, status = ?, shipping_address = ?, payment_method = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, order.getStatus());
            stmt.setString(4, order.getShippingAddress());
            stmt.setString(5, order.getPaymentMethod());
            stmt.setInt(6, order.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addOrderItem(int orderId, int productId, int quantity, double price) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, price);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.name as product_name, p.image as product_image FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE oi.order_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPaymentMethod(rs.getString("payment_method"));
        return order;
    }

    // Inner class for order items
    public static class OrderItem {
        private int id;
        private int orderId;
        private int productId;
        private int quantity;
        private double price;
        private String productName;
        private String productImage;

        // Getters and setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getOrderId() {
            return orderId;
        }

        public void setOrderId(int orderId) {
            this.orderId = orderId;
        }

        public int getProductId() {
            return productId;
        }

        public void setProductId(int productId) {
            this.productId = productId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public String getProductName() {
            return productName;
        }

        public void setProductName(String productName) {
            this.productName = productName;
        }

        public String getProductImage() {
            return productImage;
        }

        public void setProductImage(String productImage) {
            this.productImage = productImage;
        }
    }

    public java.util.Map<String, Object> getMonthlyStats() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sql = "SELECT MONTH(order_date) as month, YEAR(order_date) as year, " +
                "COUNT(*) as total_orders, SUM(total_amount) as total_revenue " +
                "FROM orders WHERE status IN ('delivered', 'confirmed') " +
                "GROUP BY YEAR(order_date), MONTH(order_date) " +
                "ORDER BY year DESC, month DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            java.util.List<java.util.Map<String, Object>> monthlyData = new java.util.ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> month = new java.util.HashMap<>();
                month.put("month", rs.getInt("month"));
                month.put("year", rs.getInt("year"));
                month.put("total_orders", rs.getInt("total_orders"));
                month.put("total_revenue", rs.getDouble("total_revenue"));
                monthlyData.add(month);
            }
            stats.put("monthly_data", monthlyData);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public List<Order> getOrdersBySellerId(int sellerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT DISTINCT o.* FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE p.seller_id = ? ORDER BY o.order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public java.util.List<java.util.Map<String, Object>> getTopSellingProducts() {
        java.util.List<java.util.Map<String, Object>> topProducts = new java.util.ArrayList<>();
        String sql = "SELECT p.id, p.name, p.brand, p.image, " +
                "SUM(oi.quantity) as total_sold, " +
                "SUM(oi.quantity * oi.price) as total_revenue " +
                "FROM products p " +
                "JOIN order_items oi ON p.id = oi.product_id " +
                "JOIN orders o ON oi.order_id = o.id " +
                "WHERE o.status IN ('delivered', 'confirmed') " +
                "GROUP BY p.id, p.name, p.brand, p.image " +
                "ORDER BY total_sold DESC " +
                "LIMIT 10";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                java.util.Map<String, Object> product = new java.util.HashMap<>();
                product.put("id", rs.getInt("id"));
                product.put("name", rs.getString("name"));
                product.put("brand", rs.getString("brand"));
                product.put("image", rs.getString("image"));
                product.put("total_sold", rs.getInt("total_sold"));
                product.put("total_revenue", rs.getDouble("total_revenue"));
                topProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topProducts;
    }

}