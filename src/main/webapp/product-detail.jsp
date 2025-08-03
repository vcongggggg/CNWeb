<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-mobile-alt me-2"></i>Mobile Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/product/">Sản phẩm</a>
                    </li>
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/order/cart">
                                <i class="fas fa-shopping-cart"></i> Giỏ hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/order/list">Đơn hàng</a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/stats">Thống kê</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <c:if test="${not empty product}">
            <div class="row">
                <!-- Product Image -->
                <div class="col-md-6">
                    <div class="card">
                        <img src="${product.image}" class="card-img-top" alt="${product.name}" style="max-height: 400px; object-fit: contain;">
                    </div>
                </div>
                
                <!-- Product Details -->
                <div class="col-md-6">
                    <h2 class="mb-3">${product.name}</h2>
                    <div class="mb-3">
                        <span class="badge bg-primary">${product.brand}</span>
                        <span class="badge bg-secondary">${product.category}</span>
                    </div>
                    
                    <div class="mb-3">
                        <h3 class="text-danger">
                            <fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ
                        </h3>
                    </div>
                    
                    <div class="mb-3">
                        <h5>Mô tả:</h5>
                        <p>${product.description}</p>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong>Tình trạng:</strong> ${product.condition}
                        </div>
                        <div class="col-6">
                            <strong>Bảo hành:</strong> ${product.warranty}
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong>Địa điểm:</strong> ${product.location}
                        </div>
                        <div class="col-6">
                            <strong>Còn lại:</strong> ${product.stock} sản phẩm
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <strong>Liên hệ:</strong> ${product.contactInfo}
                    </div>
                    
                    <c:if test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/order/add-to-cart" method="post" class="mb-3">
                            <input type="hidden" name="productId" value="${product.id}">
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="quantity" class="form-label">Số lượng:</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1" max="${product.stock}">
                                </div>
                                <div class="col-md-8">
                                    <button type="submit" class="btn btn-primary btn-lg w-100 mt-4">
                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/product/" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty product}">
            <div class="alert alert-warning">
                <h4>Không tìm thấy sản phẩm</h4>
                <p>Sản phẩm bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/product/" class="btn btn-primary">Quay lại danh sách sản phẩm</a>
            </div>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light mt-5">
        <div class="container py-4">
            <div class="row">
                <div class="col-md-6">
                    <h5>Mobile Shop</h5>
                    <p>Website bán điện thoại di động uy tín, chất lượng</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5>Liên hệ</h5>
                    <p>Email: info@mobileshop.com<br>Phone: 0123 456 789</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple form validation
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form[action*="add-to-cart"]');
            
            if (form) {
                form.addEventListener('submit', function(e) {
                    const productId = this.querySelector('input[name="productId"]').value;
                    const quantity = this.querySelector('input[name="quantity"]').value;
                    
                    if (!productId || !quantity) {
                        e.preventDefault();
                        alert('Vui lòng nhập đầy đủ thông tin!');
                        return false;
                    }
                    
                    if (quantity <= 0) {
                        e.preventDefault();
                        alert('Số lượng phải lớn hơn 0!');
                        return false;
                    }
                    
                    // Allow normal form submission
                    console.log('Submitting form with Product ID:', productId, 'Quantity:', quantity);
                });
            }
        });
    </script>
</body>
</html> 