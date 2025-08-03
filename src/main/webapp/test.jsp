<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Page - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Test Page - Mobile Shop</h1>
        
        <div class="row">
            <div class="col-md-6">
                <h3>Session Info</h3>
                <p><strong>User:</strong> ${sessionScope.user != null ? sessionScope.user.fullName : 'Not logged in'}</p>
                <p><strong>User ID:</strong> ${sessionScope.user != null ? sessionScope.user.id : 'N/A'}</p>
                <p><strong>Role:</strong> ${sessionScope.user != null ? sessionScope.user.role : 'N/A'}</p>
                
                <h3>Cart Info</h3>
                <p><strong>Cart:</strong> ${sessionScope.cart != null ? sessionScope.cart : 'Empty'}</p>
                <p><strong>Cart Size:</strong> ${sessionScope.cart != null ? sessionScope.cart.size() : 0}</p>
            </div>
            
            <div class="col-md-6">
                <h3>Test Links</h3>
                <ul class="list-group">
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-sm">Home</a>
                        <span class="ms-2">Trang chủ</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/product/" class="btn btn-primary btn-sm">Products</a>
                        <span class="ms-2">Danh sách sản phẩm</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/product/view?id=1" class="btn btn-primary btn-sm">Product Detail</a>
                        <span class="ms-2">Chi tiết sản phẩm ID=1</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/order/cart" class="btn btn-primary btn-sm">Cart</a>
                        <span class="ms-2">Giỏ hàng</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary btn-sm">Orders</a>
                        <span class="ms-2">Đơn hàng</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary btn-sm">Login</a>
                        <span class="ms-2">Đăng nhập</span>
                    </li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary btn-sm">Register</a>
                        <span class="ms-2">Đăng ký</span>
                    </li>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-warning btn-sm">Admin Products</a>
                            <span class="ms-2">Quản lý sản phẩm (Admin)</span>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-warning btn-sm">Admin Users</a>
                            <span class="ms-2">Quản lý người dùng (Admin)</span>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <h3>Test Functions</h3>
                <div class="card">
                    <div class="card-body">
                        <h5>Test Add to Cart</h5>
                        <form action="${pageContext.request.contextPath}/order/add-to-cart" method="post" class="d-inline">
                            <input type="hidden" name="productId" value="1">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn btn-success">Add Product ID=1 to Cart</button>
                        </form>
                        
                        <h5 class="mt-3">Test Remove from Cart</h5>
                        <form action="${pageContext.request.contextPath}/order/remove-from-cart" method="post" class="d-inline">
                            <input type="hidden" name="productId" value="1">
                            <button type="submit" class="btn btn-danger">Remove Product ID=1 from Cart</button>
                        </form>
                        
                        <h5 class="mt-3">Test Update Cart</h5>
                        <form action="${pageContext.request.contextPath}/order/update-cart" method="post" class="d-inline">
                            <input type="hidden" name="productId" value="1">
                            <input type="number" name="quantity" value="2" min="1" class="form-control d-inline" style="width: 80px;">
                            <button type="submit" class="btn btn-info">Update Quantity</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 