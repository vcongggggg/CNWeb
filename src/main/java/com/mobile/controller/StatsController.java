package com.mobile.controller;

import com.mobile.bo.ProductBO;
import com.mobile.bo.OrderBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/stats/*")
public class StatsController extends HttpServlet {
    private ProductBO productBO;
    private OrderBO orderBO;

    @Override
    public void init() throws ServletException {
        productBO = new ProductBO();
        orderBO = new OrderBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Show main stats page
            showMainStats(request, response);
        } else if (pathInfo.equals("/products")) {
            // Show product statistics
            showProductStats(request, response);
        } else if (pathInfo.equals("/orders")) {
            // Show order statistics
            showOrderStats(request, response);
        } else if (pathInfo.equals("/category")) {
            // Show category statistics
            showCategoryStats(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showMainStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get basic statistics
        int totalProducts = productBO.getAllProducts().size();
        int totalOrders = orderBO.getTotalOrders();
        int pendingOrders = orderBO.getPendingOrders();
        double totalRevenue = orderBO.getTotalRevenue();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/admin/stats.jsp").forward(request, response);
    }

    private void showProductStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Object> productStats = productBO.getProductStats();
        request.setAttribute("productStats", productStats);

        request.getRequestDispatcher("/admin/product-stats.jsp").forward(request, response);
    }

    private void showOrderStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get order statistics
        int totalOrders = orderBO.getTotalOrders();
        int pendingOrders = orderBO.getPendingOrders();
        int completedOrders = orderBO.getCompletedOrders();
        int shippedOrders = orderBO.getShippedOrders();
        int cancelledOrders = orderBO.getCancelledOrders();
        double totalRevenue = orderBO.getTotalRevenue();

        // Get monthly statistics
        java.util.Map<String, Object> monthlyStats = orderBO.getMonthlyStats();

        // Get top selling products
        java.util.List<java.util.Map<String, Object>> topProducts = orderBO.getTopSellingProducts();

        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("shippedOrders", shippedOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("monthlyStats", monthlyStats);
        request.setAttribute("topProducts", topProducts);

        request.getRequestDispatcher("/admin-pages/order-stats.jsp").forward(request, response);
    }

    private void showCategoryStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Object> categoryStats = productBO.getProductStats();
        request.setAttribute("categoryStats", categoryStats);

        request.getRequestDispatcher("/admin/category-stats.jsp").forward(request, response);
    }
}