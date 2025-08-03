package com.mobile.controller;

import com.mobile.bo.ProductBO;
import com.mobile.bo.OrderBO;
import com.mobile.bo.UserBO;
import com.mobile.model.Product;
import com.mobile.model.Order;
import com.mobile.model.User;
import com.mobile.dao.OrderDAO;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/seller/*")
public class SellerController extends HttpServlet {
    private ProductBO productBO;
    private OrderBO orderBO;
    private UserBO userBO;

    @Override
    public void init() throws ServletException {
        productBO = new ProductBO();
        orderBO = new OrderBO();
        userBO = new UserBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        switch (pathInfo) {
            case "/":
            case "/products":
                showMyProducts(request, response, user);
                break;
            case "/orders":
                showMyOrders(request, response, user);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        switch (pathInfo) {
            case "/approve-order":
                approveOrder(request, response, user);
                break;
            case "/reject-order":
                rejectOrder(request, response, user);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void showMyProducts(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            // Get products by seller
            List<Product> myProducts = productBO.getProductsBySellerId(user.getId());
            
            // Calculate statistics
            int totalProducts = myProducts.size();
            int activeProducts = (int) myProducts.stream()
                .filter(p -> "approved".equals(p.getStatus()) && p.getStock() > 0)
                .count();
            int soldProducts = (int) myProducts.stream()
                .filter(p -> p.getStock() == 0)
                .count();
            
            double totalRevenue = myProducts.stream()
                .mapToDouble(Product::getPrice)
                .sum();

            request.setAttribute("myProducts", myProducts);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("activeProducts", activeProducts);
            request.setAttribute("soldProducts", soldProducts);
            request.setAttribute("totalRevenue", totalRevenue);
            
            request.getRequestDispatcher("/my-products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showMyOrders(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            // Get orders for products sold by this seller
            List<Order> sellerOrders = orderBO.getOrdersBySellerId(user.getId());
            
            // Get order details with customer info and order items
            List<java.util.Map<String, Object>> orderDetails = new ArrayList<>();
            for (Order order : sellerOrders) {
                java.util.Map<String, Object> detail = new java.util.HashMap<>();
                detail.put("order", order);
                
                // Get customer info
                User customer = userBO.getUserById(order.getUserId());
                detail.put("customer", customer);
                
                // Get order items
                List<OrderDAO.OrderItem> items = orderBO.getOrderItems(order.getId());
                detail.put("items", items);
                
                orderDetails.add(detail);
            }
            
            request.setAttribute("orderDetails", orderDetails);
            request.getRequestDispatcher("/seller-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void approveOrder(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            // Update order status to confirmed (not processing)
            boolean success = orderBO.updateOrderStatus(orderId, "confirmed");
            
            if (success) {
                request.getSession().setAttribute("message", "Đơn hàng đã được chấp nhận!");
            } else {
                request.getSession().setAttribute("error", "Không thể chấp nhận đơn hàng!");
            }
            
            response.sendRedirect(request.getContextPath() + "/seller/orders");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void rejectOrder(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            // Update order status to cancelled
            boolean success = orderBO.updateOrderStatus(orderId, "cancelled");
            
            if (success) {
                // Restore stock
                orderBO.restoreStockForOrder(orderId);
                request.getSession().setAttribute("message", "Đơn hàng đã được từ chối!");
            } else {
                request.getSession().setAttribute("error", "Không thể từ chối đơn hàng!");
            }
            
            response.sendRedirect(request.getContextPath() + "/seller/orders");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
} 