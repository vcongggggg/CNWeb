<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-cog me-1"></i>Quản lý
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/pending-products">Duyệt sản phẩm</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product-stats">Thống kê sản phẩm</a></li>
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin/order-stats">Thống kê đơn hàng</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category-stats">Thống kê danh mục</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-shopping-cart me-2"></i>Thống kê đơn hàng</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary">
                            <i class="fas fa-list me-2"></i>Xem đơn hàng
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-shopping-cart fa-3x text-primary mb-3"></i>
                                <h3 class="text-primary">${totalOrders}</h3>
                                <p class="text-muted">Tổng đơn hàng</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-clock fa-3x text-warning mb-3"></i>
                                <h3 class="text-warning">${pendingOrders}</h3>
                                <p class="text-muted">Đơn hàng chờ xử lý</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-money-bill-wave fa-3x text-success mb-3"></i>
                                <h3 class="text-success">
                                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="VNĐ"/>
                                </h3>
                                <p class="text-muted">Tổng doanh thu</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-chart-line me-2"></i>Thống kê theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty monthlyStats.monthly_data}">
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Tháng/Năm</th>
                                                    <th>Số đơn hàng</th>
                                                    <th>Doanh thu</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="month" items="${monthlyStats.monthly_data}">
                                                    <tr>
                                                        <td>${month.month}/${month.year}</td>
                                                        <td>${month.total_orders}</td>
                                                        <td><fmt:formatNumber value="${month.total_revenue}" type="currency" currencySymbol="VNĐ"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                                <c:if test="${empty monthlyStats.monthly_data}">
                                    <div class="text-center text-muted">
                                        <i class="fas fa-chart-line fa-3x mb-3"></i>
                                        <p>Chưa có dữ liệu thống kê theo tháng</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-chart-pie me-2"></i>Phân bố trạng thái</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="text-center">
                                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                                <i class="fas fa-check"></i>
                                            </div>
                                            <p class="mt-2 mb-0">Đã hoàn thành</p>
                                            <small class="text-muted">${completedOrders}</small>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-center">
                                            <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <p class="mt-2 mb-0">Đang xử lý</p>
                                            <small class="text-muted">${pendingOrders}</small>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="text-center">
                                            <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                                <i class="fas fa-shipping-fast"></i>
                                            </div>
                                            <p class="mt-2 mb-0">Đã gửi hàng</p>
                                            <small class="text-muted">${shippedOrders}</small>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-center">
                                            <div class="bg-danger text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                                <i class="fas fa-times"></i>
                                            </div>
                                            <p class="mt-2 mb-0">Đã hủy</p>
                                            <small class="text-muted">${cancelledOrders}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-table me-2"></i>Top sản phẩm bán chạy</h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center text-muted">
                                    <i class="fas fa-chart-bar fa-3x mb-3"></i>
                                    <p>Danh sách sản phẩm bán chạy</p>
                                    <small>Chức năng này sẽ được phát triển thêm</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 