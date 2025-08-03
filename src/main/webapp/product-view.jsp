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
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/product-list.jsp">Sản phẩm</a>
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
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/admin/users">Quản lý người dùng</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/admin/products">Quản lý sản phẩm</a></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <c:if test="${not empty product}">
            <div class="row">
                <!-- Product Image -->
                <div class="col-md-6">
                    <div class="product-image-container">
                        <img src="${product.image}" alt="${product.name}" class="img-fluid rounded shadow">
                    </div>
                </div>
                
                <!-- Product Details -->
                <div class="col-md-6">
                    <h1 class="mb-3">${product.name}</h1>
                    <div class="mb-3">
                        <span class="badge bg-primary me-2">${product.brand}</span>
                        <span class="badge bg-secondary">${product.category}</span>
                    </div>
                    
                    <div class="price-section mb-4">
                        <h2 class="text-danger fw-bold">
                    <fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ
                </h2>
                        <small class="text-muted">Còn lại: ${product.stock} sản phẩm</small>
                    </div>
                    
                    <div class="description mb-4">
                        <h5>Mô tả sản phẩm:</h5>
                        <p class="text-muted">${product.description}</p>
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
                                        <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    
                    <c:if test="${empty sessionScope.user}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Vui lòng <a href="${pageContext.request.contextPath}/login.jsp">đăng nhập</a> để mua hàng
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- Product Specifications -->
            <div class="row mt-5">
                <div class="col-12">
                    <h3>Thông số kỹ thuật</h3>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <th>Thương hiệu</th>
                                    <td>${product.brand}</td>
                                </tr>
                                <tr>
                                    <th>Danh mục</th>
                                    <td>${product.category}</td>
                                </tr>
                                <tr>
                                    <th>Giá</th>
                                    <td><fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ</td>
                                </tr>
                                <tr>
                                    <th>Tình trạng</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.stock > 0}">
                                                <span class="badge bg-success">Còn hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Hết hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty product}">
            <div class="text-center py-5">
                <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                <h3>Không tìm thấy sản phẩm</h3>
                <p class="text-muted">Sản phẩm bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/product-list.jsp" class="btn btn-primary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách sản phẩm
                </a>
            </div>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-mobile-alt me-2"></i>Mobile Shop</h5>
                    <p class="mb-0">Website bán điện thoại di động uy tín, chất lượng</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">&copy; 2024 Mobile Shop. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 