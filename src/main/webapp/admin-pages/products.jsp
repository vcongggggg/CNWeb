<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Mobile Shop</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-cog me-1"></i>Quản lý
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                                                         <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/pending-products">Duyệt sản phẩm</a></li>
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a></li>
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-box me-2"></i>Quản lý sản phẩm</h2>
            <div>
                                    <a href="${pageContext.request.contextPath}/admin/pending-products" class="btn btn-warning me-2">
                    <i class="fas fa-clock me-2"></i>Duyệt sản phẩm
                </a>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                </button>
            </div>
        </div>

        <!-- Search and Filter -->
        <form method="get" action="${pageContext.request.contextPath}/admin/products">
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="d-flex">
                        <input class="form-control me-2" type="text" name="search" placeholder="Tìm kiếm sản phẩm..." value="${param.search}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="brand" onchange="this.form.submit()">
                        <option value="">Tất cả thương hiệu</option>
                        <option value="Apple" ${param.brand == 'Apple' ? 'selected' : ''}>Apple</option>
                        <option value="Samsung" ${param.brand == 'Samsung' ? 'selected' : ''}>Samsung</option>
                        <option value="Xiaomi" ${param.brand == 'Xiaomi' ? 'selected' : ''}>Xiaomi</option>
                        <option value="OPPO" ${param.brand == 'OPPO' ? 'selected' : ''}>OPPO</option>
                        <option value="Vivo" ${param.brand == 'Vivo' ? 'selected' : ''}>Vivo</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="status" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <option value="in_stock" ${param.status == 'in_stock' ? 'selected' : ''}>Còn hàng</option>
                        <option value="out_of_stock" ${param.status == 'out_of_stock' ? 'selected' : ''}>Hết hàng</option>
                    </select>
                </div>
            </div>
        </form>

        <!-- Products Table -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Thương hiệu</th>
                        <th>Danh mục</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>
                                <img src="${product.image}" alt="${product.name}" class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;">
                            </td>
                            <td>
                                <strong>${product.name}</strong>
                                <br><small class="text-muted">${product.description}</small>
                            </td>
                            <td>
                                <span class="badge bg-info">${product.brand}</span>
                            </td>
                            <td>
                                <span class="badge bg-secondary">${product.category}</span>
                            </td>
                            <td>
                                <strong class="text-danger">
                            <fmt:formatNumber value="${product.price}" pattern="#,###" /> VNĐ
                        </strong>
                            </td>
                            <td>${product.stock}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <span class="badge bg-success">Còn hàng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary" onclick="editProduct(${product.id})">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(${product.id})">
                                    <i class="fas fa-trash"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/product/view?id=${product.id}" class="btn btn-sm btn-outline-info">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&category=${param.category}&brand=${param.brand}&status=${param.status}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&search=${param.search}&category=${param.category}&brand=${param.brand}&status=${param.status}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&category=${param.category}&brand=${param.brand}&status=${param.status}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="../product/admin/add" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên sản phẩm *</label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="brand" class="form-label">Thương hiệu *</label>
                                    <select class="form-select" id="brand" name="brand" required>
                                        <option value="">Chọn thương hiệu</option>
                                        <option value="Apple">Apple</option>
                                        <option value="Samsung">Samsung</option>
                                        <option value="Xiaomi">Xiaomi</option>
                                        <option value="OPPO">OPPO</option>
                                        <option value="Vivo">Vivo</option>
                                        <option value="Huawei">Huawei</option>
                                        <option value="OnePlus">OnePlus</option>
                                        <option value="Google">Google</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="category" class="form-label">Danh mục *</label>
                                    <select class="form-select" id="category" name="category" required>
                                        <option value="">Chọn danh mục</option>
                                        <option value="smartphone">Smartphone</option>
                                        <option value="tablet">Tablet</option>
                                        <option value="laptop">Laptop</option>
                                        <option value="accessory">Phụ kiện</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label">Giá *</label>
                                    <input type="number" class="form-control" id="price" name="price" required min="0">
                                </div>
                                <div class="mb-3">
                                    <label for="stock" class="form-label">Tồn kho *</label>
                                    <input type="number" class="form-control" id="stock" name="stock" required min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="image" class="form-label">Hình ảnh</label>
                                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label for="imageUrl" class="form-label">Hoặc URL hình ảnh</label>
                                    <input type="url" class="form-control" id="imageUrl" name="imageUrl" placeholder="https://example.com/image.jpg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div class="modal fade" id="editProductModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="../product/admin/update" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="editProductId" name="id">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editName" class="form-label">Tên sản phẩm *</label>
                                    <input type="text" class="form-control" id="editName" name="name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editBrand" class="form-label">Thương hiệu *</label>
                                    <select class="form-select" id="editBrand" name="brand" required>
                                        <option value="Apple">Apple</option>
                                        <option value="Samsung">Samsung</option>
                                        <option value="Xiaomi">Xiaomi</option>
                                        <option value="OPPO">OPPO</option>
                                        <option value="Vivo">Vivo</option>
                                        <option value="Huawei">Huawei</option>
                                        <option value="OnePlus">OnePlus</option>
                                        <option value="Google">Google</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="editCategory" class="form-label">Danh mục *</label>
                                    <select class="form-select" id="editCategory" name="category" required>
                                        <option value="smartphone">Smartphone</option>
                                        <option value="tablet">Tablet</option>
                                        <option value="laptop">Laptop</option>
                                        <option value="accessory">Phụ kiện</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="editPrice" class="form-label">Giá *</label>
                                    <input type="number" class="form-control" id="editPrice" name="price" required min="0">
                                </div>
                                <div class="mb-3">
                                    <label for="editStock" class="form-label">Tồn kho *</label>
                                    <input type="number" class="form-control" id="editStock" name="stock" required min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editDescription" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="editDescription" name="description" rows="4"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editImage" class="form-label">Hình ảnh mới</label>
                                    <input type="file" class="form-control" id="editImage" name="image" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label for="editImageUrl" class="form-label">Hoặc URL hình ảnh mới</label>
                                    <input type="url" class="form-control" id="editImageUrl" name="imageUrl">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Hình ảnh hiện tại</label>
                                    <img id="currentImage" src="" alt="Current image" class="img-thumbnail" style="max-width: 200px;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editProduct(productId) {
            // Load product data and show edit modal
            fetch(`../product/admin/get?id=${productId}`)
                .then(response => response.json())
                .then(product => {
                    document.getElementById('editProductId').value = product.id;
                    document.getElementById('editName').value = product.name;
                    document.getElementById('editBrand').value = product.brand;
                    document.getElementById('editCategory').value = product.category;
                    document.getElementById('editPrice').value = product.price;
                    document.getElementById('editStock').value = product.stock;
                    document.getElementById('editDescription').value = product.description || '';
                    document.getElementById('editImageUrl').value = product.image || '';
                    document.getElementById('currentImage').src = product.image || '';
                    
                    new bootstrap.Modal(document.getElementById('editProductModal')).show();
                });
        }

        function deleteProduct(productId) {
            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
                fetch(`../product/admin/delete?id=${productId}`, {method: 'POST'})
                    .then(response => {
                        if (response.ok) {
                            location.reload();
                        } else {
                            alert('Có lỗi xảy ra khi xóa sản phẩm');
                        }
                    });
            }
        }
    </script>
</body>
</html> 