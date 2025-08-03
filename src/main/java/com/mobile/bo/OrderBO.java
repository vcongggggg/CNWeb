package com.mobile.bo;

import com.mobile.dao.OrderDAO;
import com.mobile.dao.ProductDAO;
import com.mobile.model.Order;
import com.mobile.model.Product;

import java.util.List;
import java.util.Map;

public class OrderBO {
    private OrderDAO orderDAO;
    private ProductDAO productDAO;

    public OrderBO() {
        orderDAO = new OrderDAO();
        productDAO = new ProductDAO();
    }

    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public boolean placeOrder(int userId, Map<Integer, Integer> cart, String shippingAddress, String paymentMethod) {
        try {
            // Validate cart
            if (cart == null || cart.isEmpty()) {
                return false;
            }

            // Check stock availability using new method
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                if (!productDAO.checkStockAvailability(entry.getKey(), entry.getValue())) {
                    return false; // Insufficient stock
                }
            }

            // Calculate total amount
            double totalAmount = 0;
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productDAO.getProductById(entry.getKey());
                if (product != null) {
                    totalAmount += product.getPrice() * entry.getValue();
                }
            }

            // Create order
            Order order = new Order();
            order.setUserId(userId);
            order.setTotalAmount(totalAmount);
            order.setStatus("pending");
            order.setShippingAddress(shippingAddress);
            order.setPaymentMethod(paymentMethod);

            int orderId = orderDAO.addOrder(order);
            if (orderId > 0) {
                // Add order items and update stock using new method
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    Product product = productDAO.getProductById(entry.getKey());
                    if (product != null) {
                        // Add order item
                        orderDAO.addOrderItem(orderId, entry.getKey(), entry.getValue(), product.getPrice());
                        
                        // Update stock using new method
                        productDAO.updateStockAfterOrder(entry.getKey(), entry.getValue());
                    }
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }

    public boolean deleteOrder(int orderId) {
        return orderDAO.deleteOrder(orderId);
    }

    public List<Order> getOrdersByStatus(String status) {
        return orderDAO.getOrdersByStatus(status);
    }

    public double getTotalRevenue() {
        List<Order> orders = orderDAO.getAllOrders();
        return orders.stream()
                .filter(order -> "delivered".equals(order.getStatus()) || "completed".equals(order.getStatus()))
                .mapToDouble(Order::getTotalAmount)
                .sum();
    }
    
    public int getCompletedOrders() {
        List<Order> orders = orderDAO.getAllOrders();
        return (int) orders.stream()
                .filter(order -> "delivered".equals(order.getStatus()) || "completed".equals(order.getStatus()))
                .count();
    }
    
    public int getShippedOrders() {
        List<Order> orders = orderDAO.getAllOrders();
        return (int) orders.stream()
                .filter(order -> "shipped".equals(order.getStatus()))
                .count();
    }
    
    public int getCancelledOrders() {
        List<Order> orders = orderDAO.getAllOrders();
        return (int) orders.stream()
                .filter(order -> "cancelled".equals(order.getStatus()))
                .count();
    }
    
    public java.util.Map<String, Object> getMonthlyStats() {
        return orderDAO.getMonthlyStats();
    }

    public int getTotalOrders() {
        return orderDAO.getAllOrders().size();
    }

    public int getPendingOrders() {
        return orderDAO.getOrdersByStatus("pending").size();
    }

    public List<OrderDAO.OrderItem> getOrderItems(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }

    public boolean cancelOrder(int orderId, int userId) {
        try {
            // Check if order exists and belongs to user
            Order order = orderDAO.getOrderById(orderId);
            if (order == null || order.getUserId() != userId) {
                return false;
            }

            // Check if order can be cancelled (only pending orders)
            if (!"pending".equals(order.getStatus())) {
                return false;
            }

            // Update order status to cancelled
            boolean success = orderDAO.updateOrderStatus(orderId, "cancelled");
            
            if (success) {
                // Restore stock for cancelled order
                List<OrderDAO.OrderItem> items = orderDAO.getOrderItems(orderId);
                for (OrderDAO.OrderItem item : items) {
                    productDAO.restoreStockAfterCancellation(item.getProductId(), item.getQuantity());
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
} 