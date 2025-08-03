<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Shop - Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-mobile-alt"></i> Mobile Shop
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/product/">Sản phẩm</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            Danh mục
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=iPhone">iPhone</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Samsung">Samsung</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Xiaomi">Xiaomi</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Oppo">Oppo</a></li>
                        </ul>
                    </li>
                    <c:if test="${sessionScope.user != null}">
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
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/product/search" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm sản phẩm...">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> ${sessionScope.user.fullName}
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/login">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/register">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section bg-primary text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="display-4 fw-bold">Chào mừng đến với Mobile Shop</h1>
                    <p class="lead">Khám phá bộ sưu tập điện thoại di động chất lượng cao với giá cả hợp lý</p>
                    <a href="${pageContext.request.contextPath}/product/" class="btn btn-light btn-lg">
                        Xem sản phẩm <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <div class="col-md-6 text-center">
                    <i class="fas fa-mobile-alt" style="font-size: 200px; opacity: 0.3;"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container my-5">
        <div class="row">
            <div class="col-md-4 text-center mb-4">
                <div class="feature-card p-4">
                    <i class="fas fa-shipping-fast fa-3x text-primary mb-3"></i>
                    <h4>Giao hàng nhanh</h4>
                    <p>Giao hàng toàn quốc trong 24-48 giờ</p>
                </div>
            </div>
            <div class="col-md-4 text-center mb-4">
                <div class="feature-card p-4">
                    <i class="fas fa-shield-alt fa-3x text-primary mb-3"></i>
                    <h4>Bảo hành chính hãng</h4>
                    <p>Bảo hành 12-24 tháng theo tiêu chuẩn nhà sản xuất</p>
                </div>
            </div>
            <div class="col-md-4 text-center mb-4">
                <div class="feature-card p-4">
                    <i class="fas fa-headset fa-3x text-primary mb-3"></i>
                    <h4>Hỗ trợ 24/7</h4>
                    <p>Đội ngũ tư vấn chuyên nghiệp, hỗ trợ mọi lúc</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Mobile Shop</h5>
                    <p>Website bán điện thoại di động uy tín, chất lượng</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5>Liên hệ</h5>
                    <p>
                        <i class="fas fa-phone"></i> 0123 456 789<br>
                        <i class="fas fa-envelope"></i> info@mobileshop.com<br>
                        <i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận 1, TP.HCM
                    </p>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p>&copy; 2024 Mobile Shop. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 