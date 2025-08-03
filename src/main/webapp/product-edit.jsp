<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa sản phẩm - Mobile Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
      </head>

      <body>
        <jsp:include page="user-navbar.jsp" />

        <div class="container mt-5">
          <div class="row justify-content-center">
            <div class="col-md-8">
              <div class="card">
                <div class="card-header">
                  <h4><i class="fas fa-edit me-2"></i>Chỉnh sửa sản phẩm</h4>
                </div>
                <div class="card-body">
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

                  <form action="${pageContext.request.contextPath}/product/update" method="post"
                    enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${product.id}">
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="name" class="form-label">Tên sản phẩm *</label>
                        <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="brand" class="form-label">Thương hiệu *</label>
                        <select class="form-select" id="brand" name="brand" required>
                          <option value="">Chọn thương hiệu</option>
                          <option value="iPhone" ${product.brand=='iPhone' ? 'selected' : '' }>iPhone</option>
                          <option value="Samsung" ${product.brand=='Samsung' ? 'selected' : '' }>Samsung</option>
                          <option value="Xiaomi" ${product.brand=='Xiaomi' ? 'selected' : '' }>Xiaomi</option>
                          <option value="Oppo" ${product.brand=='Oppo' ? 'selected' : '' }>Oppo</option>
                          <option value="Vivo" ${product.brand=='Vivo' ? 'selected' : '' }>Vivo</option>
                          <option value="Huawei" ${product.brand=='Huawei' ? 'selected' : '' }>Huawei</option>
                          <option value="Nokia" ${product.brand=='Nokia' ? 'selected' : '' }>Nokia</option>
                          <option value="OnePlus" ${product.brand=='OnePlus' ? 'selected' : '' }>OnePlus</option>
                          <option value="Google" ${product.brand=='Google' ? 'selected' : '' }>Google</option>
                          <option value="Khác" ${product.brand=='Khác' ? 'selected' : '' }>Khác</option>
                        </select>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="price" class="form-label">Giá bán (VNĐ) *</label>
                        <input type="number" class="form-control" id="price" name="price" value="${product.price}"
                          min="0" step="1000" required>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="stock" class="form-label">Số lượng *</label>
                        <input type="number" class="form-control" id="stock" name="stock" value="${product.stock}"
                          min="1" required>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="condition" class="form-label">Tình trạng *</label>
                        <select class="form-select" id="condition" name="condition" required>
                          <option value="">Chọn tình trạng</option>
                          <option value="Mới" ${product.condition=='Mới' ? 'selected' : '' }>Mới</option>
                          <option value="Đã sử dụng" ${product.condition=='Đã sử dụng' ? 'selected' : '' }>Đã sử dụng
                          </option>
                          <option value="Cũ" ${product.condition=='Cũ' ? 'selected' : '' }>Cũ</option>
                        </select>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="warranty" class="form-label">Bảo hành</label>
                        <input type="text" class="form-control" id="warranty" name="warranty"
                          value="${product.warranty}" placeholder="VD: 12 tháng, 6 tháng...">
                      </div>
                    </div>

                    <div class="mb-3">
                      <label for="description" class="form-label">Mô tả sản phẩm *</label>
                      <textarea class="form-control" id="description" name="description" rows="4"
                        placeholder="Mô tả chi tiết về sản phẩm, tính năng, tình trạng..."
                        required>${product.description}</textarea>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="image" class="form-label">Hình ảnh mới</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                        <div class="form-text">Chọn file hình ảnh mới (JPG, PNG, GIF)</div>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="imageUrl" class="form-label">Hoặc URL hình ảnh mới</label>
                        <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                          placeholder="https://example.com/image.jpg">
                      </div>
                    </div>

                    <div class="mb-3">
                      <label class="form-label">Hình ảnh hiện tại</label>
                      <div>
                        <c:choose>
                          <c:when test="${not empty product.image}">
                            <img src="${product.image}" alt="${product.name}" class="img-thumbnail"
                              style="max-width: 200px;">
                          </c:when>
                          <c:otherwise>
                            <div class="placeholder-image">
                              <i class="fas fa-mobile-alt fa-3x text-muted"></i>
                            </div>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="location" class="form-label">Địa điểm bán</label>
                        <input type="text" class="form-control" id="location" name="location"
                          value="${product.location}" placeholder="VD: Hà Nội, TP.HCM...">
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="contactInfo" class="form-label">Thông tin liên hệ</label>
                        <textarea class="form-control" id="contactInfo" name="contactInfo" rows="2"
                          placeholder="Số điện thoại, email hoặc thông tin liên hệ khác">${product.contactInfo}</textarea>
                      </div>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                      <a href="${pageContext.request.contextPath}/product/my-products"
                        class="btn btn-secondary me-md-2">
                        <i class="fas fa-arrow-left"></i> Quay lại
                      </a>
                      <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Cập nhật sản phẩm
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
      </body>

      </html>