<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Mobile Shop</title>
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
                                    <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/seller/orders">Đơn hàng bán</a></li>
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-shopping-cart me-2"></i>Đơn hàng của tôi
                    </h2>
                    <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-primary">
                        <i class="fas fa-box me-2"></i>Sản phẩm của tôi
                    </a>
                </div>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${empty orderDetails}">
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Chưa có đơn hàng nào</h4>
                        <p class="text-muted">Chưa có ai đặt mua sản phẩm của bạn.</p>
                    </div>
                </c:if>
                
                <c:if test="${not empty orderDetails}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Khách hàng</th>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày đặt</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                                                        <tbody>
                                <c:forEach var="detail" items="${orderDetails}">
                                    <c:set var="order" value="${detail.order}" />
                                    <c:set var="customer" value="${detail.customer}" />
                                    <c:set var="items" value="${detail.items}" />
                                    <tr>
                                        <td>
                                            <strong>#${order.id}</strong>
                                        </td>
                                        <td>
                                            <div>
                                                <strong>${customer.fullName}</strong><br>
                                                <small class="text-muted">${customer.email}</small><br>
                                                <small class="text-muted">Địa chỉ: ${order.shippingAddress}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <c:forEach var="item" items="${items}">
                                                <div class="mb-1">
                                                    <strong>${item.productName}</strong><br>
                                                    <small class="text-muted">${item.quantity} x <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VNĐ"/></small>
                                                </div>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <c:forEach var="item" items="${items}">
                                                <span class="badge bg-info">${item.quantity}</span>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <strong class="text-danger">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/>
                                            </strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <span class="badge bg-warning">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'confirmed'}">
                                                    <span class="badge bg-info">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${order.status == 'shipped'}">
                                                    <span class="badge bg-primary">Đã gửi hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'delivered'}">
                                                    <span class="badge bg-success">Đã giao hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <c:if test="${order.status == 'pending'}">
                                                <div class="btn-group" role="group">
                                                    <form method="post" action="${pageContext.request.contextPath}/seller/approve-order" style="display: inline;">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Chấp nhận đơn hàng này?')">
                                                            <i class="fas fa-check"></i> Chấp nhận
                                                        </button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/seller/reject-order" style="display: inline;">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Từ chối đơn hàng này?')">
                                                            <i class="fas fa-times"></i> Từ chối
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:if>
                                            <c:if test="${order.status == 'confirmed'}">
                                                <span class="text-success">Đã chấp nhận</span>
                                            </c:if>
                                            <c:if test="${order.status == 'cancelled'}">
                                                <span class="text-danger">Đã từ chối</span>
                                            </c:if>
                                            <c:if test="${order.status != 'pending' && order.status != 'confirmed' && order.status != 'cancelled'}">
                                                <span class="text-muted">Đã xử lý</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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