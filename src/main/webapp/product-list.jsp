<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="com.mobile.bo.ProductBO" %>
                <%@ page import="com.mobile.model.Product" %>
                    <%@ page import="java.util.List" %>
                        <!DOCTYPE html>
                        <html lang="vi">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Sản phẩm - Mobile Shop</title>
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
                                rel="stylesheet">
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                rel="stylesheet">
                            <link href="css/style.css" rel="stylesheet">
                        </head>

                        <body>
                            <!-- Include Smart Navigation -->
                            <jsp:include page="common-navbar.jsp" />

                            <!-- Load Products -->
                            <% ProductBO productBO=new ProductBO(); List<Product> products = productBO.getAllProducts();
                                request.setAttribute("products", products);
                                %>

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
                                                        <a href="${pageContext.request.contextPath}/product/category?category=iPhone"
                                                            class="list-group-item list-group-item-action">
                                                            <i class="fab fa-apple"></i> iPhone
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/product/category?category=Samsung"
                                                            class="list-group-item list-group-item-action">
                                                            <i class="fas fa-mobile-alt"></i> Samsung
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/product/category?category=Xiaomi"
                                                            class="list-group-item list-group-item-action">
                                                            <i class="fas fa-mobile-alt"></i> Xiaomi
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/product/category?category=Oppo"
                                                            class="list-group-item list-group-item-action">
                                                            <i class="fas fa-mobile-alt"></i> Oppo
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Product Grid -->
                                        <div class="col-md-9">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2><i class="fas fa-mobile-alt"></i> Tất cả sản phẩm</h2>
                                                <c:if
                                                    test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                                                    <a href="${pageContext.request.contextPath}/product/add"
                                                        class="btn btn-primary">
                                                        <i class="fas fa-plus"></i> Thêm sản phẩm
                                                    </a>
                                                </c:if>
                                            </div>

                                            <c:if test="${empty products}">
                                                <div class="text-center py-5">
                                                    <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                                    <h4 class="text-muted">Không có sản phẩm nào</h4>
                                                    <p class="text-muted">Vui lòng thử lại sau hoặc liên hệ với chúng
                                                        tôi</p>
                                                </div>
                                            </c:if>

                                            <div class="row">
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-md-4 col-lg-3 mb-4">
                                                        <div class="card h-100 product-card">
                                                            <div class="card-img-top-container">
                                                                <c:choose>
                                                                    <c:when test="${not empty product.image}">
                                                                        <img src="${product.image}" class="card-img-top"
                                                                            alt="${product.name}">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="placeholder-image">
                                                                            <i
                                                                                class="fas fa-mobile-alt fa-3x text-muted"></i>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="card-body d-flex flex-column">
                                                                <h6 class="card-title">${product.name}</h6>
                                                                <p class="card-text text-muted small">${product.brand}
                                                                </p>
                                                                <p class="card-text flex-grow-1">${product.description}
                                                                </p>
                                                                <div class="mt-auto">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mb-2">
                                                                        <span class="text-primary fw-bold">
                                                                            <fmt:formatNumber value="${product.price}"
                                                                                type="currency" currencySymbol="₫" />
                                                                        </span>
                                                                        <span
                                                                            class="badge bg-${product.stock > 0 ? 'success' : 'danger'}">
                                                                            ${product.stock > 0 ? 'Còn hàng' : 'Hết
                                                                            hàng'}
                                                                        </span>
                                                                    </div>
                                                                    <div class="d-grid gap-2">
                                                                        <a href="${pageContext.request.contextPath}/product/view?id=${product.id}"
                                                                            class="btn btn-outline-primary btn-sm">
                                                                            <i class="fas fa-eye"></i> Xem chi tiết
                                                                        </a>
                                                                        <c:if
                                                                            test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                                                                            <div class="btn-group btn-group-sm"
                                                                                role="group">
                                                                                <button type="button"
                                                                                    class="btn btn-outline-danger"
                                                                                    onclick="deleteProduct('${product.id}')">
                                                                                    <i class="fas fa-trash"></i>
                                                                                </button>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
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

                                <script
                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                                <script>
                                    function deleteProduct(productId) {
                                        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
                                            const form = document.createElement('form');
                                            form.method = 'POST';
                                            form.action = '${pageContext.request.contextPath}/product/delete';

                                            const input = document.createElement('input');
                                            input.type = 'hidden';
                                            input.name = 'id';
                                            input.value = productId;

                                            form.appendChild(input);
                                            document.body.appendChild(form);
                                            form.submit();

                                            // Clean up the form after submission
                                            setTimeout(() => {
                                                document.body.removeChild(form);
                                            }, 100);
                                        }
                                    }
                                </script>
                        </body>

                        </html>