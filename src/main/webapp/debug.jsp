<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Debug - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Debug Page - Mobile Shop</h1>
        
        <div class="row">
            <div class="col-md-6">
                <h3>Database Connection Test</h3>
                <%
                try {
                    com.mobile.util.DatabaseUtil.getConnection();
                    out.println("<div class='alert alert-success'>✅ Database connection successful!</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>❌ Database connection failed: " + e.getMessage() + "</div>");
                }
                %>
                
                <h3>Product Count Test</h3>
                <%
                try {
                    com.mobile.bo.ProductBO productBO = new com.mobile.bo.ProductBO();
                    java.util.List<com.mobile.model.Product> products = productBO.getAllProducts();
                    out.println("<div class='alert alert-info'>📊 Total products in database: " + products.size() + "</div>");
                    
                    if (products.size() > 0) {
                        out.println("<h4>First 3 products:</h4>");
                        out.println("<ul class='list-group'>");
                        for (int i = 0; i < Math.min(3, products.size()); i++) {
                            com.mobile.model.Product p = products.get(i);
                            out.println("<li class='list-group-item'>");
                            out.println("ID: " + p.getId() + " | Name: " + p.getName() + " | Price: " + p.getPrice());
                            out.println("</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println("<div class='alert alert-warning'>⚠️ No products found in database!</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>❌ Error getting products: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
                %>
            </div>
            
            <div class="col-md-6">
                <h3>Session Info</h3>
                <p><strong>User:</strong> ${sessionScope.user != null ? sessionScope.user.fullName : 'Not logged in'}</p>
                <p><strong>User ID:</strong> ${sessionScope.user != null ? sessionScope.user.id : 'N/A'}</p>
                <p><strong>Role:</strong> ${sessionScope.user != null ? sessionScope.user.role : 'N/A'}</p>
                
                <h3>Request Info</h3>
                <p><strong>Context Path:</strong> ${pageContext.request.contextPath}</p>
                <p><strong>Request URI:</strong> ${pageContext.request.requestURI}</p>
                <p><strong>Query String:</strong> ${pageContext.request.queryString}</p>
                
                <h3>Test Links</h3>
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/product/" class="btn btn-primary">Test Product List</a>
                    <a href="${pageContext.request.contextPath}/product/view?id=1" class="btn btn-info">Test Product Detail</a>
                    <a href="${pageContext.request.contextPath}/product/category?category=iPhone" class="btn btn-success">Test Category Filter</a>
                    <a href="${pageContext.request.contextPath}/test.jsp" class="btn btn-warning">Test Page</a>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <h3>Database Schema Check</h3>
                <%
                try {
                    java.sql.Connection conn = com.mobile.util.DatabaseUtil.getConnection();
                    java.sql.DatabaseMetaData metaData = conn.getMetaData();
                    java.sql.ResultSet tables = metaData.getTables(null, null, "products", null);
                    
                    if (tables.next()) {
                        out.println("<div class='alert alert-success'>✅ Products table exists</div>");
                        
                        // Check table structure
                        java.sql.ResultSet columns = metaData.getColumns(null, null, "products", null);
                        out.println("<h4>Table columns:</h4>");
                        out.println("<ul class='list-group'>");
                        while (columns.next()) {
                            String columnName = columns.getString("COLUMN_NAME");
                            String columnType = columns.getString("TYPE_NAME");
                            out.println("<li class='list-group-item'>" + columnName + " (" + columnType + ")</li>");
                        }
                        out.println("</ul>");
                        
                        // Check data count
                        java.sql.Statement stmt = conn.createStatement();
                        java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM products");
                        if (rs.next()) {
                            int count = rs.getInt("count");
                            out.println("<div class='alert alert-info'>📊 Products table has " + count + " records</div>");
                        }
                        
                        rs.close();
                        stmt.close();
                    } else {
                        out.println("<div class='alert alert-danger'>❌ Products table does not exist!</div>");
                    }
                    
                    conn.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>❌ Error checking database schema: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
                %>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 