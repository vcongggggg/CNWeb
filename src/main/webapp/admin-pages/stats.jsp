<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Mobile Shop</title>
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
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin/stats">Thống kê tổng quan</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product-stats">Thống kê sản phẩm</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/order-stats">Thống kê đơn hàng</a></li>
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
                    <h1 class="h2">Thống kê tổng quan</h1>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Tổng sản phẩm</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalProducts}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-mobile-alt fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Tổng đơn hàng</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalOrders}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Đơn hàng chờ xử lý</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingOrders}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Tổng doanh thu</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            ${String.format("%,.0f", totalRevenue)} VNĐ
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thống kê chi tiết</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <a href="${pageContext.request.contextPath}/stats/products" class="list-group-item list-group-item-action">
                                        <i class="fas fa-chart-pie"></i> Thống kê sản phẩm
                                    </a>
                                    <a href="${pageContext.request.contextPath}/stats/orders" class="list-group-item list-group-item-action">
                                        <i class="fas fa-chart-line"></i> Thống kê đơn hàng
                                    </a>
                                    <a href="${pageContext.request.contextPath}/stats/category" class="list-group-item list-group-item-action">
                                        <i class="fas fa-chart-bar"></i> Thống kê theo danh mục
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Hành động nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Thêm sản phẩm mới
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-success">
                                        <i class="fas fa-eye"></i> Xem đơn hàng mới
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-info">
                                        <i class="fas fa-users"></i> Quản lý người dùng
                                    </a>
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