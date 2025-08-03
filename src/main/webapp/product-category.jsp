<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category} - Mobile Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/product/">Sản phẩm</a>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/admin/users">Quản lý người dùng</a></li>
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

    <!-- Main Content -->
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-filter"></i> Bộ lọc</h5>
                    </div>
                    <div class="card-body">
                        <h6>Danh mục</h6>
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/product/category?category=iPhone" class="list-group-item list-group-item-action ${category == 'iPhone' ? 'active' : ''}">
                                <i class="fab fa-apple"></i> iPhone
                            </a>
                            <a href="${pageContext.request.contextPath}/product/category?category=Samsung" class="list-group-item list-group-item-action ${category == 'Samsung' ? 'active' : ''}">
                                <i class="fas fa-mobile-alt"></i> Samsung
                            </a>
                            <a href="${pageContext.request.contextPath}/product/category?category=Xiaomi" class="list-group-item list-group-item-action ${category == 'Xiaomi' ? 'active' : ''}">
                                <i class="fas fa-mobile-alt"></i> Xiaomi
                            </a>
                            <a href="${pageContext.request.contextPath}/product/category?category=Oppo" class="list-group-item list-group-item-action ${category == 'Oppo' ? 'active' : ''}">
                                <i class="fas fa-mobile-alt"></i> Oppo
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Product List -->
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-mobile-alt me-2"></i>${category}</h2>
                    <span class="text-muted">${products.size()} sản phẩm</span>
                </div>
                
                <c:if test="${empty products || products.isEmpty()}">
                    <div class="text-center py-5">
                        <i class="fas fa-box fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Không có sản phẩm nào</h4>
                        <p class="text-muted">Vui lòng thử lại sau hoặc liên hệ với chúng tôi</p>
                        <a href="${pageContext.request.contextPath}/product/" class="btn btn-primary">Xem tất cả sản phẩm</a>
                    </div>
                </c:if>
                
                <c:if test="${not empty products && !products.isEmpty()}">
                    <div class="row">
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-4 mb-4">
                                <div class="card h-100">
                                    <img src="${product.image}" class="card-img-top" alt="${product.name}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text text-muted">${product.brand}</p>
                                        <p class="card-text">${product.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ"/>
                                            </span>
                                            <span class="badge bg-success">Còn ${product.stock}</span>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/product/view?id=${product.id}" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                                            </a>
                                            <c:if test="${not empty sessionScope.user}">
                                                <form action="${pageContext.request.contextPath}/order/add-to-cart" method="post" class="d-grid">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-success btn-sm">
                                                        <i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
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
            <div class="row">
                <div class="col-md-4">
                    <h5>Mobile Shop</h5>
                    <p>Website bán điện thoại di động uy tín, chất lượng</p>
                </div>
                <div class="col-md-4">
                    <h5>Liên hệ</h5>
                    <p><i class="fas fa-phone me-2"></i>0123 456 789</p>
                    <p><i class="fas fa-envelope me-2"></i>info@mobileshop.com</p>
                    <p><i class="fas fa-map-marker-alt me-2"></i>123 Đường ABC, Quận 1, TP.HCM</p>
                </div>
                <div class="col-md-4">
                    <h5>Theo dõi</h5>
                    <div class="social-links">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook fa-2x"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-2x"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-2x"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <p>&copy; 2024 Mobile Shop. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 