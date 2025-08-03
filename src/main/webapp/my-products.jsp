<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Sản phẩm của tôi - Mobile Shop</title>
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
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/product-list.jsp">Sản
                                        phẩm</a>
                                </li>
                                <c:if test="${not empty sessionScope.user}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/order/cart">
                                            <i class="fas fa-shopping-cart"></i> Giỏ hàng
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/order/list">Đơn
                                            hàng</a>
                                    </li>
                                </c:if>
                            </ul>
                            <ul class="navbar-nav">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown">
                                                <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/order/list">Đơn hàng
                                                        của tôi</a></li>
                                                <li><a class="dropdown-item active"
                                                        href="${pageContext.request.contextPath}/seller/products">Sản
                                                        phẩm của tôi</a></li>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/sell-product.jsp">Đăng
                                                        bán</a></li>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a>
                                                </li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/user/logout">Đăng
                                                        xuất</a></li>
                                            </ul>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Đăng
                                                nhập</a>
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
                                    <i class="fas fa-box me-2"></i>Sản phẩm của tôi
                                </h2>
                                <div>
                                    <a href="${pageContext.request.contextPath}/seller/orders"
                                        class="btn btn-info me-2">
                                        <i class="fas fa-shopping-cart me-2"></i>Đơn hàng bán
                                    </a>
                                    <a href="${pageContext.request.contextPath}/sell-product.jsp"
                                        class="btn btn-success">
                                        <i class="fas fa-plus me-2"></i>Đăng bán mới
                                    </a>
                                </div>
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

                            <c:if test="${empty myProducts}">
                                <div class="text-center py-5">
                                    <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                    <h4 class="text-muted">Chưa có sản phẩm nào</h4>
                                    <p class="text-muted">Bạn chưa đăng bán sản phẩm nào. Hãy bắt đầu đăng bán ngay!</p>
                                    <a href="${pageContext.request.contextPath}/sell-product.jsp"
                                        class="btn btn-primary">Đăng bán sản phẩm</a>
                                </div>
                            </c:if>

                            <c:if test="${not empty myProducts}">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2>
                                                <i class="fas fa-box me-2"></i>Sản phẩm của tôi
                                            </h2>
                                            <a href="${pageContext.request.contextPath}/sell-product.jsp"
                                                class="btn btn-success">
                                                <i class="fas fa-plus me-2"></i>Đăng bán mới
                                            </a>
                                        </div>

                                        <c:if test="${not empty message}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                <i class="fas fa-check-circle me-2"></i>${message}
                                                <button type="button" class="btn-close"
                                                    data-bs-dismiss="alert"></button>
                                            </div>
                                        </c:if>

                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                                <button type="button" class="btn-close"
                                                    data-bs-dismiss="alert"></button>
                                            </div>
                                        </c:if>

                                        <c:if test="${empty myProducts}">
                                            <div class="text-center py-5">
                                                <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                                <h4 class="text-muted">Chưa có sản phẩm nào</h4>
                                                <p class="text-muted">Bạn chưa đăng bán sản phẩm nào. Hãy bắt đầu đăng
                                                    bán ngay!</p>
                                                <a href="${pageContext.request.contextPath}/sell-product.jsp"
                                                    class="btn btn-primary">Đăng bán sản phẩm</a>
                                            </div>
                                        </c:if>

                                        <c:if test="${not empty myProducts}">
                                            <div class="row">
                                                <c:forEach var="product" items="${myProducts}">
                                                    <div class="col-md-6 col-lg-4 mb-4">
                                                        <div class="card h-100 shadow-sm">
                                                            <div class="position-relative">
                                                                <img src="${product.image}" alt="${product.name}"
                                                                    class="card-img-top"
                                                                    style="height: 200px; object-fit: cover;">
                                                                <div class="position-absolute top-0 end-0 m-2">
                                                                    <span
                                                                        class="badge ${product.stock > 0 ? 'bg-success' : 'bg-danger'}">
                                                                        ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="card-body">
                                                                <h5 class="card-title">${product.name}</h5>
                                                                <p class="card-text text-muted">${product.brand} -
                                                                    ${product.category}</p>
                                                                <div class="mb-2">
                                                                    <strong class="text-danger">
                                                                        <fmt:formatNumber value="${product.price}"
                                                                            type="currency" currencySymbol="VNĐ" />
                                                                    </strong>
                                                                </div>
                                                                <p class="card-text small">${product.description}</p>
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center mb-2">
                                                                    <small class="text-muted">Còn:
                                                                        ${product.stock}</small>
                                                                    <small class="text-muted">
                                                                        <fmt:formatDate value="${product.createdDate}"
                                                                            pattern="dd/MM/yyyy" />
                                                                    </small>
                                                                </div>
                                                                <div class="text-center">
                                                                    <span class="badge 
                                                <c:choose>
                                                    <c:when test=" ${product.status=='pending' }">bg-warning</c:when>
                                                                        <c:when test="${product.status == 'approved'}">
                                                                            bg-success
                                                                        </c:when>
                                                                        <c:when test="${product.status == 'rejected'}">
                                                                            bg-danger
                                                                        </c:when>
                                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                                        </c:choose>">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${product.status == 'pending'}">
                                                                                Chờ duyệt
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${product.status == 'approved'}">
                                                                                Đã duyệt
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${product.status == 'rejected'}">
                                                                                Bị từ
                                                                                chối</c:when>
                                                                            <c:otherwise>${product.status}</c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="card-footer">
                                                                <div class="btn-group w-100" role="group">
                                                                    <a href="${pageContext.request.contextPath}/product/view?id=${product.id}"
                                                                        class="btn btn-outline-primary btn-sm">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/product/edit?id=${product.id}"
                                                                        class="btn btn-outline-warning btn-sm">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                    <button onclick="deleteProduct('${product.id}')"
                                                                        class="btn btn-outline-danger btn-sm">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- Statistics -->
                                            <div class="row mt-4">
                                                <div class="col-md-3">
                                                    <div class="card bg-primary text-white">
                                                        <div class="card-body text-center">
                                                            <h5>${totalProducts}</h5>
                                                            <small>Tổng sản phẩm</small>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="card bg-success text-white">
                                                        <div class="card-body text-center">
                                                            <h5>${activeProducts}</h5>
                                                            <small>Đang bán</small>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="card bg-warning text-dark">
                                                        <div class="card-body text-center">
                                                            <h5>${soldProducts}</h5>
                                                            <small>Đã bán</small>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="card bg-info text-white">
                                                        <div class="card-body text-center">
                                                            <h5>
                                                                <fmt:formatNumber value="${totalRevenue}"
                                                                    type="currency" currencySymbol="VNĐ" />
                                                            </h5>
                                                            <small>Doanh thu</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                        </div>

                        <!-- Delete Confirmation Modal -->
                        <div class="modal fade" id="deleteModal" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Xác nhận xóa</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Bạn có chắc chắn muốn xóa sản phẩm này?</p>
                                        <p class="text-muted">Hành động này không thể hoàn tác.</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Hủy</button>
                                        <form id="deleteForm" method="post" style="display: inline;">
                                            <button type="submit" class="btn btn-danger">Xóa</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="bg-dark text-white text-center py-4 mt-5">
                            <div class="container">
                                <p>&copy; 2024 Mobile Shop. Tất cả quyền được bảo lưu.</p>
                            </div>
                        </footer>

                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                            function deleteProduct(productId) {
                                if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
                                    const form = document.getElementById('deleteForm');
                                    form.action = 'product/delete';
                                    const input = document.createElement('input');
                                    input.type = 'hidden';
                                    input.name = 'id';
                                    input.value = productId;
                                    form.appendChild(input);
                                    form.submit();
                                }
                            }
                        </script>
            </body>

            </html>

            </html>