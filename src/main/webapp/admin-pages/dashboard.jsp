<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mobile Shop</title>
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
                           <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                       </li>
                       <li class="nav-item dropdown">
                           <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                               <i class="fas fa-cog me-1"></i>Quản lý
                           </a>
                           <ul class="dropdown-menu">
                               <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/pending-products">Duyệt sản phẩm</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a></li>
                               <li><hr class="dropdown-divider"></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product-stats">Thống kê sản phẩm</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/order-stats">Thống kê đơn hàng</a></li>
                               <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category-stats">Thống kê danh mục</a></li>
                           </ul>
                       </li>
                   </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1><i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard</h1>
                <p class="text-muted">Quản lý hệ thống Mobile Shop</p>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4 class="card-title">${totalProducts}</h4>
                                <p class="card-text">Tổng sản phẩm</p>
                            </div>
                            <div class="align-self-center">
                                <i class="fas fa-box fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4 class="card-title">${pendingProducts}</h4>
                                <p class="card-text">Sản phẩm chờ duyệt</p>
                            </div>
                            <div class="align-self-center">
                                <i class="fas fa-clock fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                         <div class="col-md-3 mb-3">
                 <div class="card bg-success text-white">
                     <div class="card-body">
                         <div class="d-flex justify-content-between">
                             <div>
                                 <h4 class="card-title">${totalUsers}</h4>
                                 <p class="card-text">Tổng người dùng</p>
                             </div>
                             <div class="align-self-center">
                                 <i class="fas fa-users fa-2x"></i>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="col-md-3 mb-3">
                 <div class="card bg-info text-white">
                     <div class="card-body">
                         <div class="d-flex justify-content-between">
                             <div>
                                 <h4 class="card-title">${totalOrders}</h4>
                                 <p class="card-text">Tổng đơn hàng</p>
                             </div>
                             <div class="align-self-center">
                                 <i class="fas fa-shopping-cart fa-2x"></i>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
            
        </div>

        

                 <!-- Quick Actions -->
         <div class="row mb-4">
             <div class="col-12">
                 <div class="card">
                     <div class="card-header">
                         <h5 class="card-title mb-0"><i class="fas fa-bolt me-2"></i>Thao tác nhanh</h5>
                     </div>
                     <div class="card-body">
                         <div class="row">
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/pending-products" class="btn btn-warning w-100">
                                     <i class="fas fa-clock me-2"></i>Duyệt sản phẩm
                                 </a>
                             </div>
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary w-100">
                                     <i class="fas fa-box me-2"></i>Quản lý sản phẩm
                                 </a>
                             </div>
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-success w-100">
                                     <i class="fas fa-users me-2"></i>Quản lý người dùng
                                 </a>
                             </div>
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-info w-100">
                                     <i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng
                                 </a>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>

        <!-- Statistics Links -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0"><i class="fas fa-chart-bar me-2"></i>Thống kê chi tiết</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mb-2">
                                <a href="${pageContext.request.contextPath}/admin/stats" class="btn btn-outline-primary w-100">
                                    <i class="fas fa-chart-pie me-2"></i>Thống kê tổng quan
                                </a>
                            </div>
                                                         <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/product-stats" class="btn btn-outline-success w-100">
                                     <i class="fas fa-chart-line me-2"></i>Thống kê sản phẩm
                                 </a>
                             </div>
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/order-stats" class="btn btn-outline-info w-100">
                                     <i class="fas fa-chart-area me-2"></i>Thống kê đơn hàng
                                 </a>
                             </div>
                             <div class="col-md-3 mb-2">
                                 <a href="${pageContext.request.contextPath}/admin/category-stats" class="btn btn-outline-warning w-100">
                                     <i class="fas fa-chart-bar me-2"></i>Thống kê danh mục
                                 </a>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0"><i class="fas fa-clock me-2"></i>Hoạt động gần đây</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">Sản phẩm mới chờ duyệt</h6>
                                    <small class="text-muted">${pendingProducts} sản phẩm cần xem xét</small>
                                </div>
                                <span class="badge bg-warning rounded-pill">${pendingProducts}</span>
                            </div>
                            
                                                         <div class="list-group-item d-flex justify-content-between align-items-center">
                                 <div>
                                     <h6 class="mb-1">Đơn hàng mới</h6>
                                     <small class="text-muted">${totalOrders} đơn hàng trong hệ thống</small>
                                 </div>
                                 <span class="badge bg-info rounded-pill">${totalOrders}</span>
                             </div>
                             <div class="list-group-item d-flex justify-content-between align-items-center">
                                 <div>
                                     <h6 class="mb-1">Người dùng đăng ký</h6>
                                     <small class="text-muted">${totalUsers} người dùng trong hệ thống</small>
                                 </div>
                                 <span class="badge bg-success rounded-pill">${totalUsers}</span>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0"><i class="fas fa-tasks me-2"></i>Công việc cần làm</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <c:if test="${pendingProducts > 0}">
                                <div class="list-group-item">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-1">Duyệt sản phẩm mới</h6>
                                        <small class="text-danger">Ưu tiên cao</small>
                                    </div>
                                    <p class="mb-1">Có ${pendingProducts} sản phẩm đang chờ duyệt</p>
                                    <a href="${pageContext.request.contextPath}/admin/pending-products" class="btn btn-sm btn-warning">
                                        Xem ngay
                                    </a>
                                </div>
                            </c:if>
                            
                                                         <div class="list-group-item">
                                 <div class="d-flex w-100 justify-content-between">
                                     <h6 class="mb-1">Kiểm tra đơn hàng</h6>
                                     <small class="text-warning">Cần chú ý</small>
                                 </div>
                                 <p class="mb-1">Theo dõi tình trạng đơn hàng</p>
                                 <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-info">
                                     Xem đơn hàng
                                 </a>
                             </div>
                             <div class="list-group-item">
                                 <div class="d-flex w-100 justify-content-between">
                                     <h6 class="mb-1">Quản lý người dùng</h6>
                                     <small class="text-info">Định kỳ</small>
                                 </div>
                                 <p class="mb-1">Kiểm tra và quản lý tài khoản người dùng</p>
                                 <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-success">
                                     Quản lý
                                 </a>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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