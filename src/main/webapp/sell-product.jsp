<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng bán sản phẩm - Mobile Shop</title>
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/product-list.jsp">Sản phẩm</a>
                    </li>
                    <c:if test="${not empty sessionScope.user}">
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
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/list">Đơn hàng của tôi</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/my-products">Sản phẩm của tôi</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/sell-product.jsp">Đăng bán</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
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
            <div class="col-lg-8 mx-auto">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-plus-circle me-2"></i>Đăng bán sản phẩm
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty sessionScope.user}">
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
                            
                            <form action="${pageContext.request.contextPath}/product/add" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="name" class="form-label">Tên sản phẩm *</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="brand" class="form-label">Thương hiệu *</label>
                                        <select class="form-select" id="brand" name="brand" required>
                                            <option value="">Chọn thương hiệu</option>
                                            <option value="iPhone">iPhone</option>
                                            <option value="Samsung">Samsung</option>
                                            <option value="Xiaomi">Xiaomi</option>
                                            <option value="Oppo">Oppo</option>
                                            <option value="Vivo">Vivo</option>
                                            <option value="Huawei">Huawei</option>
                                            <option value="Nokia">Nokia</option>
                                            <option value="OnePlus">OnePlus</option>
                                            <option value="Google">Google</option>
                                            <option value="Khác">Khác</option>
                                            <option value="Xiaomi">Xiaomi</option>
                                            <option value="Oppo">Oppo</option>
                                            <option value="Vivo">Vivo</option>
                                            <option value="Huawei">Huawei</option>
                                            <option value="OnePlus">OnePlus</option>
                                            <option value="Google">Google</option>
                                            <option value="Khác">Khác</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="price" class="form-label">Giá bán (VNĐ) *</label>
                                        <input type="number" class="form-control" id="price" name="price" min="0" step="1000" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="stock" class="form-label">Số lượng *</label>
                                        <input type="number" class="form-control" id="stock" name="stock" min="1" value="1" required>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="condition" class="form-label">Tình trạng *</label>
                                        <select class="form-select" id="condition" name="condition" required>
                                            <option value="">Chọn tình trạng</option>
                                            <option value="Mới">Mới</option>
                                            <option value="Đã sử dụng">Đã sử dụng</option>
                                            <option value="Cũ">Cũ</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="warranty" class="form-label">Bảo hành</label>
                                        <input type="text" class="form-control" id="warranty" name="warranty" 
                                               placeholder="VD: 12 tháng, 6 tháng...">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả sản phẩm *</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" 
                                              placeholder="Mô tả chi tiết về sản phẩm, tính năng, tình trạng..." required></textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="image" class="form-label">Hình ảnh sản phẩm</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                        <div class="form-text">Chọn file hình ảnh (JPG, PNG, GIF)</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="imageUrl" class="form-label">Hoặc URL hình ảnh</label>
                                        <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                               placeholder="https://example.com/image.jpg">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="location" class="form-label">Địa điểm bán</label>
                                        <input type="text" class="form-control" id="location" name="location" 
                                               placeholder="VD: Hà Nội, TP.HCM...">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="contactInfo" class="form-label">Thông tin liên hệ</label>
                                        <textarea class="form-control" id="contactInfo" name="contactInfo" rows="2" 
                                                  placeholder="Số điện thoại, email hoặc thông tin liên hệ khác"></textarea>
                                    </div>
                                </div>
                                

                                
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        Tôi đồng ý với <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">điều khoản đăng bán</a>
                                    </label>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                                            <a href="${pageContext.request.contextPath}/product-list.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-upload me-2"></i>Đăng bán
                                    </button>
                                </div>
                            </form>
                        </c:if>
                        
                        <c:if test="${empty sessionScope.user}">
                            <div class="text-center py-5">
                                <i class="fas fa-user-lock fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Vui lòng đăng nhập</h4>
                                <p class="text-muted">Bạn cần đăng nhập để đăng bán sản phẩm</p>
                                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Đăng nhập</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Terms Modal -->
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Điều khoản đăng bán</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Thông tin sản phẩm</h6>
                    <ul>
                        <li>Thông tin sản phẩm phải chính xác và đầy đủ</li>
                        <li>Hình ảnh phải là sản phẩm thực tế</li>
                        <li>Giá cả phải hợp lý và minh bạch</li>
                    </ul>
                    
                    <h6>2. Trách nhiệm người bán</h6>
                    <ul>
                        <li>Đảm bảo chất lượng sản phẩm như mô tả</li>
                        <li>Giao hàng đúng thời gian cam kết</li>
                        <li>Hỗ trợ khách hàng khi có vấn đề</li>
                    </ul>
                    
                    <h6>3. Cấm đăng bán</h6>
                    <ul>
                        <li>Sản phẩm giả, nhái, vi phạm bản quyền</li>
                        <li>Sản phẩm nguy hiểm, cấm lưu hành</li>
                        <li>Thông tin gian dối, lừa đảo</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 