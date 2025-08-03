<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê sản phẩm - Admin</title>
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
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin/product-stats">Thống kê sản phẩm</a></li>
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
                    <h1 class="h2"><i class="fas fa-chart-pie me-2"></i>Thống kê sản phẩm</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">
                            <i class="fas fa-box me-2"></i>Quản lý sản phẩm
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-chart-bar me-2"></i>Thống kê theo danh mục</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty productStats.category_stats}">
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Danh mục</th>
                                                    <th>Số lượng</th>
                                                    <th>Giá trung bình</th>
                                                    <th>Tổng tồn kho</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="category" items="${productStats.category_stats}">
                                                    <tr>
                                                        <td>${category.category}</td>
                                                        <td>${category.total_products}</td>
                                                        <td><fmt:formatNumber value="${category.avg_price}" type="currency" currencySymbol="VNĐ"/></td>
                                                        <td>${category.total_stock}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                                <c:if test="${empty productStats.category_stats}">
                                    <div class="text-center text-muted">
                                        <i class="fas fa-chart-bar fa-3x mb-3"></i>
                                        <p>Chưa có dữ liệu thống kê</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-info-circle me-2"></i>Tổng quan</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="text-center">
                                            <h3 class="text-primary">${productStats.total_products}</h3>
                                            <p class="text-muted">Tổng sản phẩm</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-center">
                                            <h3 class="text-success">${productStats.total_categories}</h3>
                                            <p class="text-muted">Danh mục</p>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="text-center">
                                            <h3 class="text-warning">${productStats.total_stock}</h3>
                                            <p class="text-muted">Tổng tồn kho</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-center">
                                            <h3 class="text-info">
                                                <fmt:formatNumber value="${productStats.avg_price}" type="currency" currencySymbol="VNĐ"/>
                                            </h3>
                                            <p class="text-muted">Giá trung bình</p>
                                        </div>
                                    </div>
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