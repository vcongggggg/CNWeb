<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Kết quả tìm kiếm - Mobile Shop</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <!-- Include Smart Navigation -->
                <jsp:include page="common-navbar.jsp" />

                <!-- Main Content -->
                <div class="container mt-4">
                    <!-- Search Form -->
                    <div class="row mb-4">
                        <div class="col-md-8 mx-auto">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="fas fa-search me-2"></i>Tìm kiếm sản phẩm</h5>
                                    <form action="${pageContext.request.contextPath}/product/search" method="get"
                                        class="d-flex">
                                        <input type="text" name="keyword" value="${keyword}" class="form-control me-2"
                                            placeholder="Nhập từ khóa tìm kiếm..." required>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    ${error}
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Search Results -->
                    <c:if test="${searchPerformed}">
                        <div class="row mb-4">
                            <div class="col-12">
                                <h2><i class="fas fa-search me-2"></i>Kết quả tìm kiếm</h2>
                                <p class="text-muted">
                                    Tìm kiếm: "<strong>${keyword}</strong>" -
                                    <c:choose>
                                        <c:when test="${empty products}">
                                            Không tìm thấy sản phẩm nào
                                        </c:when>
                                        <c:otherwise>
                                            Tìm thấy ${products.size()} sản phẩm
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>

                        <!-- No Results -->
                        <c:if test="${empty products}">
                            <div class="text-center py-5">
                                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Không tìm thấy sản phẩm</h4>
                                <p class="text-muted">Không có sản phẩm nào phù hợp với từ khóa
                                    "<strong>${keyword}</strong>"</p>
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/product-list.jsp"
                                        class="btn btn-primary me-2">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách sản phẩm
                                    </a>
                                    <a href="${pageContext.request.contextPath}/product/search"
                                        class="btn btn-outline-secondary">
                                        <i class="fas fa-search me-2"></i>Tìm kiếm khác
                                    </a>
                                </div>
                            </div>
                        </c:if>

                        <!-- Results Grid -->
                        <c:if test="${not empty products}">
                            <div class="row">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-4 col-lg-3 mb-4">
                                        <div class="card h-100 product-card">
                                            <div class="card-img-top-container"
                                                style="height: 200px; overflow: hidden;">
                                                <img src="${product.image}" alt="${product.name}" class="card-img-top"
                                                    style="width: 100%; height: 100%; object-fit: cover;"
                                                    onerror="this.src='https://via.placeholder.com/300x300?text=No+Image'">
                                            </div>
                                            <div class="card-body d-flex flex-column">
                                                <h6 class="card-title">${product.name}</h6>
                                                <p class="card-text text-muted small">${product.brand}</p>
                                                <div class="mt-auto">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="fw-bold text-primary">
                                                            <fmt:formatNumber value="${product.price}"
                                                                pattern="#,###" /> VNĐ
                                                        </span>
                                                        <span
                                                            class="badge bg-${product.stock > 0 ? 'success' : 'danger'}">
                                                            ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}
                                                        </span>
                                                    </div>
                                                    <div class="d-grid gap-2">
                                                        <a href="${pageContext.request.contextPath}/product/view?id=${product.id}"
                                                            class="btn btn-outline-primary btn-sm">
                                                            <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                        </a>
                                                        <c:if
                                                            test="${not empty sessionScope.user && product.stock > 0}">
                                                            <form
                                                                action="${pageContext.request.contextPath}/order/add-to-cart"
                                                                method="post">
                                                                <input type="hidden" name="productId"
                                                                    value="${product.id}">
                                                                <input type="hidden" name="quantity" value="1">
                                                                <button type="submit"
                                                                    class="btn btn-success btn-sm w-100">
                                                                    <i class="fas fa-shopping-cart me-1"></i>Thêm vào
                                                                    giỏ
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Back to Products -->
                            <div class="row mt-4">
                                <div class="col-12 text-center">
                                    <a href="${pageContext.request.contextPath}/product-list.jsp"
                                        class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách sản phẩm
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </c:if>

                    <!-- Quick Search Suggestions -->
                    <c:if test="${not searchPerformed}">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Tìm kiếm nhanh</h5>
                                        <div class="row">
                                            <div class="col-md-3 mb-2">
                                                <a href="${pageContext.request.contextPath}/product/search?keyword=iPhone"
                                                    class="btn btn-outline-primary btn-sm w-100">
                                                    <i class="fab fa-apple me-1"></i>iPhone
                                                </a>
                                            </div>
                                            <div class="col-md-3 mb-2">
                                                <a href="${pageContext.request.contextPath}/product/search?keyword=Samsung"
                                                    class="btn btn-outline-primary btn-sm w-100">
                                                    <i class="fas fa-mobile-alt me-1"></i>Samsung
                                                </a>
                                            </div>
                                            <div class="col-md-3 mb-2">
                                                <a href="${pageContext.request.contextPath}/product/search?keyword=Xiaomi"
                                                    class="btn btn-outline-primary btn-sm w-100">
                                                    <i class="fas fa-mobile-alt me-1"></i>Xiaomi
                                                </a>
                                            </div>
                                            <div class="col-md-3 mb-2">
                                                <a href="${pageContext.request.contextPath}/product/search?keyword=Oppo"
                                                    class="btn btn-outline-primary btn-sm w-100">
                                                    <i class="fas fa-mobile-alt me-1"></i>Oppo
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
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