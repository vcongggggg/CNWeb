<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - Mobile Shop</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/order/list">Đơn hàng</a>
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
                    <i class="fas fa-shopping-bag me-2"></i>Lịch sử đơn hàng
                </h2>
                
                <c:if test="${empty orders}">
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Chưa có đơn hàng nào</h4>
                        <p class="text-muted">Hãy mua sắm để có đơn hàng đầu tiên!</p>
                        <a href="${pageContext.request.contextPath}/product-list.jsp" class="btn btn-primary">Mua sắm ngay</a>
                    </div>
                </c:if>
                
                <c:if test="${not empty orders}">
                    <div class="row">
                        <c:forEach var="order" items="${orders}">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <div class="card-header bg-primary text-white">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">Đơn hàng #${order.id}</h6>
                                            <span class="badge bg-light text-dark">
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <strong>Tổng tiền:</strong>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/>
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <strong>Trạng thái:</strong>
                                            <span class="badge ${order.status == 'pending' ? 'bg-warning' : 
                                                             order.status == 'processing' ? 'bg-info' : 
                                                             order.status == 'shipped' ? 'bg-primary' : 
                                                             order.status == 'delivered' ? 'bg-success' : 'bg-secondary'}">
                                                ${order.status == 'pending' ? 'Chờ xử lý' : 
                                                  order.status == 'processing' ? 'Đang xử lý' : 
                                                  order.status == 'shipped' ? 'Đang giao' : 
                                                  order.status == 'delivered' ? 'Đã giao' : order.status}
                                            </span>
                                        </div>
                                        <div class="mb-3">
                                            <strong>Phương thức thanh toán:</strong>
                                            <span class="text-muted">${order.paymentMethod}</span>
                                        </div>
                                        <div class="mb-3">
                                            <strong>Địa chỉ giao hàng:</strong>
                                            <p class="text-muted small mb-0">${order.shippingAddress}</p>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <a href="${pageContext.request.contextPath}/order/view?id=${order.id}" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
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