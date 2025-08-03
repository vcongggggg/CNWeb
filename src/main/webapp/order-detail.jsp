<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
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
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
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
    <div class="container mt-4">
        <c:if test="${not empty order}">
            <div class="row">
                <div class="col-md-8">
                    <!-- Order Information -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4><i class="fas fa-shopping-bag"></i> Chi tiết đơn hàng #${order.id}</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                    <p><strong>Trạng thái:</strong> 
                                        <span class="badge 
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">bg-warning</c:when>
                                                <c:when test="${order.status == 'confirmed'}">bg-info</c:when>
                                                <c:when test="${order.status == 'shipped'}">bg-primary</c:when>
                                                <c:when test="${order.status == 'delivered'}">bg-success</c:when>
                                                <c:when test="${order.status == 'cancelled'}">bg-danger</c:when>
                                                <c:otherwise>bg-secondary</c:otherwise>
                                            </c:choose>">
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">Chờ xác nhận</c:when>
                                                <c:when test="${order.status == 'confirmed'}">Đã xác nhận</c:when>
                                                <c:when test="${order.status == 'shipped'}">Đang giao</c:when>
                                                <c:when test="${order.status == 'delivered'}">Đã giao</c:when>
                                                <c:when test="${order.status == 'cancelled'}">Đã hủy</c:when>
                                                <c:otherwise>${order.status}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </p>
                                    <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Tổng tiền:</strong> <span class="text-danger fw-bold"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" /> VNĐ</span></p>
                                    <p><strong>Địa chỉ giao hàng:</strong></p>
                                    <p class="text-muted">${order.shippingAddress}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-list"></i> Sản phẩm đã đặt</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty orderItems}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Giá</th>
                                                <th>Số lượng</th>
                                                <th>Tổng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${orderItems}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${item.productImage}" alt="${item.productName}" 
                                                                 style="width: 50px; height: 50px; object-fit: cover;" 
                                                                 class="me-3">
                                                            <div>
                                                                <h6 class="mb-0">${item.productName}</h6>
                                                                <small class="text-muted">ID: ${item.productId}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VNĐ</td>
                                                    <td>${item.quantity}</td>
                                                    <td><strong><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" /> VNĐ</strong></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty orderItems}">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i> Không có sản phẩm nào trong đơn hàng này.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <!-- Order Summary -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-calculator"></i> Tóm tắt đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tổng tiền hàng:</span>
                                <span><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" /> VNĐ</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Phí vận chuyển:</span>
                                <span>0 VNĐ</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <strong>Tổng cộng:</strong>
                                <strong class="text-danger"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" /> VNĐ</strong>
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="card mt-3">
                        <div class="card-header">
                            <h5><i class="fas fa-cogs"></i> Thao tác</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                                </a>
                                <c:if test="${order.status == 'pending'}">
                                    <button class="btn btn-danger" onclick="cancelOrder(${order.id})">
                                        <i class="fas fa-times"></i> Hủy đơn hàng
                                    </button>
                                </c:if>
                                <c:if test="${order.status == 'delivered'}">
                                    <button class="btn btn-success" onclick="rateOrder(${order.id})">
                                        <i class="fas fa-star"></i> Đánh giá
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty order}">
            <div class="alert alert-warning">
                <h4><i class="fas fa-exclamation-triangle"></i> Không tìm thấy đơn hàng</h4>
                <p>Đơn hàng bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách đơn hàng
                </a>
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
        function cancelOrder(orderId) {
            if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
                // Create form and submit
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/order/cancel-order';
                
                var orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'orderId';
                orderIdInput.value = orderId;
                
                form.appendChild(orderIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function rateOrder(orderId) {
            // Implement rating functionality
            alert('Chức năng đánh giá sẽ được implement sau');
        }
    </script>
</body>
</html> 