<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Duyệt sản phẩm - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <!-- Include Admin Navbar -->
                <jsp:include page="admin-navbar.jsp" />

                <!-- Main Content -->
                <div class="container mt-4">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2><i class="fas fa-clock me-2"></i>Sản phẩm chờ duyệt</h2>
                                <a href="${pageContext.request.contextPath}/admin/products"
                                    class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </a>
                            </div>

                            <c:if test="${not empty message}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${empty pendingProducts}">
                                <div class="text-center py-5">
                                    <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                    <h4 class="text-success">Không có sản phẩm nào chờ duyệt</h4>
                                    <p class="text-muted">Tất cả sản phẩm đã được duyệt hoặc không có sản phẩm mới.</p>
                                </div>
                            </c:if>

                            <c:if test="${not empty pendingProducts}">
                                <div class="row">
                                    <c:forEach var="product" items="${pendingProducts}">
                                        <div class="col-md-6 col-lg-4 mb-4">
                                            <div class="card h-100">
                                                <div class="card-img-top-container"
                                                    style="height: 200px; overflow: hidden;">
                                                    <img src="${product.image}" alt="${product.name}"
                                                        class="card-img-top"
                                                        style="width: 100%; height: 100%; object-fit: cover;">
                                                </div>
                                                <div class="card-body d-flex flex-column">
                                                    <h6 class="card-title">${product.name}</h6>
                                                    <p class="card-text text-muted small">${product.brand}</p>
                                                    <p class="card-text small">${product.description}</p>

                                                    <div class="mt-auto">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-2">
                                                            <span class="fw-bold text-primary">
                                                                <fmt:formatNumber value="${product.price}"
                                                                    pattern="#,###" /> VNĐ
                                                            </span>
                                                            <span class="badge bg-warning">Chờ duyệt</span>
                                                        </div>

                                                        <div class="mb-2">
                                                            <small class="text-muted">
                                                                <strong>Người bán:</strong> ${product.contactInfo}<br>
                                                                <strong>Địa điểm:</strong> ${product.location}<br>
                                                                <strong>Tình trạng:</strong> ${product.condition}<br>
                                                                <strong>Bảo hành:</strong> ${product.warranty}
                                                            </small>
                                                        </div>

                                                        <div class="d-grid gap-2">
                                                            <div class="btn-group" role="group">
                                                                <button class="btn btn-success btn-sm"
                                                                    onclick="approveProduct('${product.id}')">
                                                                    <i class="fas fa-check me-1"></i>Duyệt
                                                                </button>
                                                                <button class="btn btn-danger btn-sm"
                                                                    onclick="rejectProduct('${product.id}')">
                                                                    <i class="fas fa-times me-1"></i>Từ chối
                                                                </button>
                                                            </div>
                                                        </div>
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
                <footer class="bg-dark text-light mt-5">
                    <div class="container py-4">
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Mobile Shop</h5>
                                <p>Website bán điện thoại di động uy tín, chất lượng</p>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <h5>Liên hệ</h5>
                                <p>Email: info@mobileshop.com<br>Phone: 0123 456 789</p>
                            </div>
                        </div>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function approveProduct(productId) {
                        if (confirm('Bạn có chắc chắn muốn duyệt sản phẩm này?')) {
                            var form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/approve-product';

                            var productIdInput = document.createElement('input');
                            productIdInput.type = 'hidden';
                            productIdInput.name = 'productId';
                            productIdInput.value = productId;

                            var actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'approve';

                            form.appendChild(productIdInput);
                            form.appendChild(actionInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    }

                    function rejectProduct(productId) {
                        if (confirm('Bạn có chắc chắn muốn từ chối sản phẩm này?')) {
                            var form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/approve-product';

                            var productIdInput = document.createElement('input');
                            productIdInput.type = 'hidden';
                            productIdInput.name = 'productId';
                            productIdInput.value = productId;

                            var actionInput = document.createElement('input');
                            actionInput.type = 'hidden';
                            actionInput.name = 'action';
                            actionInput.value = 'reject';

                            form.appendChild(productIdInput);
                            form.appendChild(actionInput);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    }
                </script>
            </body>

            </html>