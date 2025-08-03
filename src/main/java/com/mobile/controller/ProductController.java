package com.mobile.controller;

import com.mobile.bo.ProductBO;
import com.mobile.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/product/*")
public class ProductController extends HttpServlet {
    private ProductBO productBO;
    
    @Override
    public void init() throws ServletException {
        productBO = new ProductBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all products
            List<Product> products = productBO.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/product-list.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // View single product
            try {
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
                    return;
                }
                
                int productId = Integer.parseInt(idParam);
                Product product = productBO.getProductById(productId);
                
                if (product == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    return;
                }
                
                request.setAttribute("product", product);
                request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
            }
        } else if (pathInfo.equals("/search")) {
            // Search products
            String keyword = request.getParameter("keyword");
            List<Product> products = productBO.searchProducts(keyword);
            request.setAttribute("products", products);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/product-search.jsp").forward(request, response);
        } else if (pathInfo.equals("/category")) {
            // Filter by category
            String category = request.getParameter("category");
            List<Product> products = productBO.getProductsByCategory(category);
            request.setAttribute("products", products);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/product-category.jsp").forward(request, response);
        } else if (pathInfo.equals("/my-products")) {
            // User's own products
            javax.servlet.http.HttpSession session = request.getSession();
            com.mobile.model.User user = (com.mobile.model.User) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            List<Product> myProducts = productBO.getProductsBySellerId(user.getId());
            request.setAttribute("myProducts", myProducts);
            request.getRequestDispatcher("/my-products.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/add")) {
            // Add new product by seller
            javax.servlet.http.HttpSession session = request.getSession();
            com.mobile.model.User user = (com.mobile.model.User) session.getAttribute("user");
            
            if (user == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            Product product = new Product();
            product.setName(request.getParameter("name"));
            product.setBrand(request.getParameter("brand"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setStock(Integer.parseInt(request.getParameter("stock")));
            product.setImage(request.getParameter("imageUrl") != null && !request.getParameter("imageUrl").isEmpty() ? 
                           request.getParameter("imageUrl") : "https://via.placeholder.com/300x300?text=No+Image");
            product.setCategory("Điện thoại"); // Default category since we only sell phones
            product.setCondition(request.getParameter("condition"));
            product.setWarranty(request.getParameter("warranty"));
            product.setLocation(request.getParameter("location"));
            product.setContactInfo(request.getParameter("contactInfo"));
            product.setStatus("pending"); // Set status to pending for approval
            
            boolean success = productBO.addProductBySeller(product, user.getId());
            if (success) {
                response.sendRedirect(request.getContextPath() + "/product/my-products?success=true");
            } else {
                request.setAttribute("error", "Không thể đăng bán sản phẩm. Vui lòng kiểm tra lại thông tin.");
                request.getRequestDispatcher("/sell-product.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/update")) {
            // Update product
            Product product = new Product();
            product.setId(Integer.parseInt(request.getParameter("id")));
            product.setName(request.getParameter("name"));
            product.setBrand(request.getParameter("brand"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setStock(Integer.parseInt(request.getParameter("stock")));
            product.setImage(request.getParameter("image"));
            product.setCategory(request.getParameter("category"));
            
            boolean success = productBO.updateProduct(product);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/product/");
            } else {
                request.setAttribute("error", "Failed to update product");
                request.getRequestDispatcher("/product-edit.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/delete")) {
            // Delete product by seller
            javax.servlet.http.HttpSession session = request.getSession();
            com.mobile.model.User user = (com.mobile.model.User) session.getAttribute("user");
            
            if (user == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            int productId = Integer.parseInt(request.getParameter("id"));
            boolean success = productBO.deleteProductBySeller(productId, user.getId());
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/product/my-products?deleted=true");
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không thể xóa sản phẩm này");
            }
        }
    }
} 