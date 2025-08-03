<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê theo danh mục - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-mobile-alt"></i> Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart"></i> Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active text-white" href="${pageContext.request.contextPath}/stats">
                                <i class="fas fa-chart-bar"></i> Thống kê
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> Quản lý người dùng
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Thống kê theo danh mục</h1>
                    <a href="${pageContext.request.contextPath}/stats" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Category Statistics Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-chart-pie"></i> Thống kê sản phẩm theo danh mục
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Danh mục</th>
                                        <th>Tổng sản phẩm</th>
                                        <th>Giá trung bình</th>
                                        <th>Tổng tồn kho</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${categoryStats.category_stats}">
                                        <tr>
                                            <td>
                                                <strong>${category.category}</strong>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary">${category.total_products}</span>
                                            </td>
                                            <td>
                                                <span class="text-success fw-bold">
                                                    ${String.format("%,.0f", category.avg_price)} VNĐ
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${category.total_stock}</span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/product/category?category=${category.category}" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i> Xem sản phẩm
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Summary Cards -->
                <div class="row mt-4">
                    <c:set var="totalProducts" value="0" />
                    <c:set var="totalStock" value="0" />
                    <c:set var="avgPrice" value="0.0" />
                    <c:set var="categoryCount" value="0" />
                    
                    <c:forEach var="category" items="${categoryStats.category_stats}">
                        <c:set var="totalProducts" value="${totalProducts + category.total_products}" />
                        <c:set var="totalStock" value="${totalStock + category.total_stock}" />
                        <c:set var="categoryCount" value="${categoryCount + 1}" />
                    </c:forEach>
                    
                    <c:if test="${categoryCount > 0}">
                        <c:set var="avgPrice" value="${totalProducts > 0 ? (totalProducts * 10000000) / totalProducts : 0}" />
                    </c:if>

                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Tổng danh mục</h6>
                                        <h3 class="mb-0">${categoryCount}</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-tags fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Tổng sản phẩm</h6>
                                        <h3 class="mb-0">${totalProducts}</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-mobile-alt fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Tổng tồn kho</h6>
                                        <h3 class="mb-0">${totalStock}</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-boxes fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Giá TB/sản phẩm</h6>
                                        <h3 class="mb-0">${String.format("%,.0f", avgPrice)}</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-dollar-sign fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 