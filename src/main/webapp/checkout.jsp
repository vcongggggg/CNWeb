<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Mobile Shop</title>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/list">Đơn hàng của tôi</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/my-products">Sản phẩm của tôi</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/sell-product.jsp">Đăng bán</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products.jsp">Quản lý sản phẩm</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users.jsp">Quản lý người dùng</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4">
                    <i class="fas fa-credit-card me-2"></i>Thanh toán
                </h2>
                
                <c:if test="${empty cartProducts || cartProducts.isEmpty()}">
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Giỏ hàng trống</h4>
                        <p class="text-muted">Không có sản phẩm nào để thanh toán.</p>
                        <a href="${pageContext.request.contextPath}/product-list.jsp" class="btn btn-primary">Mua sắm ngay</a>
                    </div>
                </c:if>
                
                <c:if test="${not empty cartProducts && !cartProducts.isEmpty()}">
                                         <form action="${pageContext.request.contextPath}/order/place-order" method="post">
                        <div class="row">
                            <!-- Order Summary -->
                            <div class="col-lg-8">
                                <div class="card mb-4">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Thông tin đơn hàng</h5>
                                    </div>
                                    <div class="card-body">
                                        <c:forEach var="item" items="${cartProducts}">
                                            <div class="row mb-3 border-bottom pb-3">
                                                <div class="col-md-2">
                                                    <img src="${item.image}" alt="${item.name}" class="img-fluid rounded">
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="mb-1">${item.name}</h6>
                                                    <p class="text-muted mb-0">${item.brand}</p>
                                                    <small class="text-muted">Số lượng: ${item.stock}</small>
                                                </div>
                                                <div class="col-md-4 text-end">
                                                    <span class="fw-bold">
                                                        <fmt:formatNumber value="${item.price * item.stock}" type="currency" currencySymbol="VNĐ"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <!-- Shipping Information -->
                                <div class="card mb-4">
                                    <div class="card-header bg-info text-white">
                                        <h5 class="mb-0"><i class="fas fa-shipping-fast me-2"></i>Thông tin giao hàng</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="fullName" class="form-label">Họ và tên *</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                                       value="${sessionScope.user.fullName}" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="phone" class="form-label">Số điện thoại *</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" 
                                                       value="${sessionScope.user.phone}" required>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="shippingAddress" class="form-label">Địa chỉ giao hàng *</label>
                                            <textarea class="form-control" id="shippingAddress" name="shippingAddress" 
                                                      rows="3" required>${sessionScope.user.address}</textarea>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="city" class="form-label">Thành phố *</label>
                                                <input type="text" class="form-control" id="city" name="city" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="district" class="form-label">Quận/Huyện *</label>
                                                <input type="text" class="form-control" id="district" name="district" required>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Payment Method -->
                                <div class="card">
                                    <div class="card-header bg-success text-white">
                                        <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Phương thức thanh toán</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   id="cod" value="COD" checked>
                                            <label class="form-check-label" for="cod">
                                                <i class="fas fa-money-bill-wave me-2"></i>Thanh toán khi nhận hàng (COD)
                                            </label>
                                        </div>
                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   id="bank" value="Bank Transfer">
                                            <label class="form-check-label" for="bank">
                                                <i class="fas fa-university me-2"></i>Chuyển khoản ngân hàng
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   id="momo" value="MoMo">
                                            <label class="form-check-label" for="momo">
                                                <i class="fas fa-mobile-alt me-2"></i>Ví MoMo
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Summary -->
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-header bg-warning text-dark">
                                        <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Tổng đơn hàng</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tạm tính:</span>
                                            <span>
                                                <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="VNĐ"/>
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Phí vận chuyển:</span>
                                            <span>Miễn phí</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between mb-3">
                                            <strong>Tổng cộng:</strong>
                                            <strong class="text-danger">
                                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="VNĐ"/>
                                            </strong>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-success w-100 mb-2">
                                            <i class="fas fa-check me-2"></i>Đặt hàng
                                        </button>
                                        
                                                                                 <a href="${pageContext.request.contextPath}/order/cart" class="btn btn-outline-secondary w-100">
                                            <i class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-5">
        <div class="container">
            <p>&copy; 2024 Mobile Shop. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 