package com.mobile.controller;

import com.mobile.bo.ProductBO;
import com.mobile.bo.OrderBO;
import com.mobile.bo.UserBO;
import com.mobile.model.Product;
import com.mobile.model.User;
import com.mobile.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
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
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            pathInfo = "/";
        }

        // Check if user is admin
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        switch (pathInfo) {
            case "/":
            case "/dashboard":
                showDashboard(request, response);
                break;
            case "/products":
                showAllProducts(request, response);
                break;
            case "/pending-products":
                showPendingProducts(request, response);
                break;
            case "/users":
                showAllUsers(request, response);
                break;
            case "/orders":
                showAllOrders(request, response);
                break;
            case "/stats":
                showMainStats(request, response);
                break;
            case "/product-stats":
                showProductStats(request, response);
                break;
            case "/order-stats":
                showOrderStats(request, response);
                break;
            case "/category-stats":
                showCategoryStats(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            pathInfo = "/";
        }

        // Check if user is admin
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        switch (pathInfo) {
            case "/approve-product":
                approveProduct(request, response);
                break;
            case "/delete-product":
                deleteProduct(request, response);
                break;
            case "/update-user":
                updateUser(request, response);
                break;
            case "/delete-user":
                deleteUser(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get dashboard statistics
            List<Product> allProducts = productBO.getAllProducts();
            int totalProducts = allProducts != null ? allProducts.size() : 0;
            List<Product> pendingProductsList = productBO.getPendingProducts();
            int pendingProducts = pendingProductsList != null ? pendingProductsList.size() : 0;
            List<User> allUsers = userBO.getAllUsers();
            int totalUsers = allUsers != null ? allUsers.size() : 0;
            int totalOrders = orderBO.getTotalOrders();
            double totalRevenue = orderBO.getTotalRevenue();
            
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("pendingProducts", pendingProducts);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showAllProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Product> products = productBO.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showPendingProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Product> pendingProducts = productBO.getPendingProducts();
            request.setAttribute("pendingProducts", pendingProducts);
            request.getRequestDispatcher("/admin/pending-products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showAllUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<User> users = userBO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showAllOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Order> orders = orderBO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showMainStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get basic statistics
            List<Product> allProducts = productBO.getAllProducts();
            int totalProducts = allProducts != null ? allProducts.size() : 0;
            List<Product> pendingProductsList = productBO.getPendingProducts();
            int pendingProducts = pendingProductsList != null ? pendingProductsList.size() : 0;
            List<User> allUsers = userBO.getAllUsers();
            int totalUsers = allUsers != null ? allUsers.size() : 0;
            
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("pendingProducts", pendingProducts);
            request.setAttribute("totalUsers", totalUsers);
            
            request.getRequestDispatcher("/admin/stats.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showProductStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Map<String, Object> productStats = productBO.getProductStats();
            request.setAttribute("productStats", productStats);
            request.getRequestDispatcher("/admin/product-stats.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showOrderStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get order statistics
            int totalOrders = orderBO.getTotalOrders();
            int pendingOrders = orderBO.getPendingOrders();
            double totalRevenue = orderBO.getTotalRevenue();
            
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            
            request.getRequestDispatcher("/admin/order-stats.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showCategoryStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Map<String, Object> categoryStats = productBO.getProductStats();
            request.setAttribute("categoryStats", categoryStats);
            request.getRequestDispatcher("/admin/category-stats.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void approveProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String action = request.getParameter("action");
        
        if (productId == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(productId);
            String status = "approve".equals(action) ? "approved" : "rejected";
            
            boolean success = productBO.updateProductStatus(id, status);
            
            if (success) {
                String message = "approve".equals(action) ? 
                    "Sản phẩm đã được duyệt thành công!" : 
                    "Sản phẩm đã bị từ chối!";
                
                response.sendRedirect(request.getContextPath() + "/admin/pending-products?message=" + 
                                   java.net.URLEncoder.encode(message, "UTF-8"));
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật trạng thái sản phẩm");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        
        if (productId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(productId);
            boolean success = productBO.deleteProduct(id);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?message=" + 
                                   java.net.URLEncoder.encode("Sản phẩm đã được xóa thành công!", "UTF-8"));
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa sản phẩm");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String role = request.getParameter("role");
        
        if (userId == null || role == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(userId);
            boolean success = userBO.updateUserRole(id, role);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users?message=" + 
                                   java.net.URLEncoder.encode("Cập nhật vai trò người dùng thành công!", "UTF-8"));
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật vai trò người dùng");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(userId);
            boolean success = userBO.deleteUser(id);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users?message=" + 
                                   java.net.URLEncoder.encode("Người dùng đã được xóa thành công!", "UTF-8"));
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa người dùng");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 