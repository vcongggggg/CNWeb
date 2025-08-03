package com.mobile.controller;

import com.mobile.bo.OrderBO;
import com.mobile.bo.ProductBO;
import com.mobile.dao.OrderDAO;
import com.mobile.model.Order;
import com.mobile.model.Product;
import com.mobile.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/order/*")
public class OrderController extends HttpServlet {
    private OrderBO orderBO;
    private ProductBO productBO;

    @Override
    public void init() throws ServletException {
        orderBO = new OrderBO();
        productBO = new ProductBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            pathInfo = "/";
        }

        switch (pathInfo) {
            case "/":
            case "/list":
                listOrders(request, response);
                break;
            case "/view":
                viewOrder(request, response);
                break;
            case "/cart":
                viewCart(request, response);
                break;
            case "/checkout":
                checkout(request, response);
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

        switch (pathInfo) {
            case "/add-to-cart":
                addToCart(request, response);
                break;
            case "/remove-from-cart":
                removeFromCart(request, response);
                break;
            case "/update-cart":
                updateCart(request, response);
                break;
            case "/place-order":
                placeOrder(request, response);
                break;
            case "/cancel-order":
                cancelOrder(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Order> orders = orderBO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/order-list.jsp").forward(request, response);
    }

    private void viewOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order/list");
            return;
        }

        try {
            int id = Integer.parseInt(orderId);
            Order order = orderBO.getOrderById(id);
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Get order items
            List<OrderDAO.OrderItem> orderItems = orderBO.getOrderItems(id);
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            System.out.println("=== viewCart called ===");
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            System.out.println("User: " + (user != null ? user.getUsername() : "null"));
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get cart from session
            @SuppressWarnings("unchecked")
            java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
            
            System.out.println("Cart: " + (cart != null ? cart.toString() : "null"));
            
            if (cart != null && !cart.isEmpty()) {
                System.out.println("Cart size: " + cart.size());
                System.out.println("Cart keys: " + cart.keySet());
                
                List<Product> cartItems = productBO.getProductsByIds(cart.keySet());
                System.out.println("Cart items: " + (cartItems != null ? cartItems.size() : "null"));
                
                if (cartItems != null && !cartItems.isEmpty()) {
                    // Add quantity to each product
                    for (Product product : cartItems) {
                        int quantity = cart.get(product.getId());
                        product.setStock(quantity); // Using stock field for quantity
                        System.out.println("Product: " + product.getName() + ", Quantity: " + quantity);
                    }
                    
                    double subtotal = 0;
                    for (Product product : cartItems) {
                        subtotal += product.getPrice() * product.getStock(); // Using stock as quantity
                    }
                    
                    System.out.println("Subtotal: " + subtotal);
                    
                    request.setAttribute("cartItems", cartItems);
                    request.setAttribute("subtotal", subtotal);
                    request.setAttribute("total", subtotal); // No shipping fee
                } else {
                    System.out.println("No cart items found");
                    request.setAttribute("cartItems", new java.util.ArrayList<>());
                    request.setAttribute("subtotal", 0.0);
                    request.setAttribute("total", 0.0);
                }
            } else {
                System.out.println("Cart is empty or null");
                request.setAttribute("cartItems", new java.util.ArrayList<>());
                request.setAttribute("subtotal", 0.0);
                request.setAttribute("total", 0.0);
            }
            
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in viewCart: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cart: " + e.getMessage());
        }
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("=== checkout called ===");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("User: " + (user != null ? user.getUsername() : "null"));
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
        java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
        
        System.out.println("Cart: " + (cart != null ? cart.toString() : "null"));
        
        if (cart == null || cart.isEmpty()) {
            System.out.println("Cart is empty, redirecting to cart");
            response.sendRedirect(request.getContextPath() + "/order/cart");
            return;
        }

        System.out.println("Getting products for cart keys: " + cart.keySet());
        List<Product> cartProducts = productBO.getProductsByIds(cart.keySet());
        System.out.println("Cart products: " + (cartProducts != null ? cartProducts.size() : "null"));
        
        if (cartProducts != null && !cartProducts.isEmpty()) {
            // Add quantity to each product and calculate totals
            double subtotal = 0;
            for (Product product : cartProducts) {
                int quantity = cart.get(product.getId());
                product.setStock(quantity); // Using stock field for quantity
                subtotal += product.getPrice() * quantity;
                System.out.println("Product: " + product.getName() + ", Quantity: " + quantity + ", Price: " + product.getPrice());
            }
            
            System.out.println("Subtotal: " + subtotal);
            
            request.setAttribute("cartProducts", cartProducts);
            request.setAttribute("cart", cart);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("total", subtotal); // No shipping fee
        } else {
            System.out.println("No cart products found");
            response.sendRedirect(request.getContextPath() + "/order/cart");
            return;
        }
        
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("=== addToCart called ===");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("User: " + (user != null ? user.getUsername() : "null"));
        
        if (user == null) {
            System.out.println("User not logged in");
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");

        System.out.println("Product ID: " + productId);
        System.out.println("Quantity: " + quantity);

        if (productId == null || quantity == null) {
            System.out.println("Missing parameters");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(productId);
            int qty = Integer.parseInt(quantity);

            System.out.println("Parsed ID: " + id);
            System.out.println("Parsed Quantity: " + qty);

            // Check if user is trying to buy their own product
            Product product = productBO.getProductById(id);
            if (product != null && product.getSellerId() == user.getId()) {
                System.out.println("User trying to buy their own product");
                response.sendRedirect(request.getContextPath() + "/product/view?id=" + id + "&error=own_product");
                return;
            }

            @SuppressWarnings("unchecked")
            java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new java.util.HashMap<>();
                session.setAttribute("cart", cart);
                System.out.println("Created new cart");
            }

            cart.put(id, cart.getOrDefault(id, 0) + qty);
            System.out.println("Added to cart. Cart size: " + cart.size());
            
            // Redirect to cart page instead of JSON response
            response.sendRedirect(request.getContextPath() + "/order/cart?success=true");
            
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");

        if (productId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(productId);
            @SuppressWarnings("unchecked")
            java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
            
            if (cart != null) {
                cart.remove(id);
                System.out.println("Removed product " + id + " from cart. Cart size: " + cart.size());
            }

            // Redirect back to cart page instead of JSON response
            response.sendRedirect(request.getContextPath() + "/order/cart?removed=true");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");

        if (productId == null || quantity == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(productId);
            int qty = Integer.parseInt(quantity);

            @SuppressWarnings("unchecked")
            java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
            
            if (cart != null) {
                if (qty <= 0) {
                    cart.remove(id);
                } else {
                    cart.put(id, qty);
                }
            }

            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"message\": \"Đã cập nhật giỏ hàng\"}");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        if (shippingAddress == null || paymentMethod == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        @SuppressWarnings("unchecked")
        java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Giỏ hàng trống");
            return;
        }

        try {
            boolean success = orderBO.placeOrder(user.getId(), cart, shippingAddress, paymentMethod);
            
            if (success) {
                // Clear cart after successful order
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/order/list?success=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể đặt hàng");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String orderId = request.getParameter("orderId");
        if (orderId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(orderId);
            boolean success = orderBO.cancelOrder(id, user.getId());
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/order/list?cancelled=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể hủy đơn hàng");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 