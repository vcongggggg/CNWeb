<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- User Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
          <i class="fas fa-mobile-alt me-2"></i>Mobile Shop
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="userNavbar">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a class="nav-link ${pageContext.request.servletPath.contains('index') ? 'active' : ''}"
                href="${pageContext.request.contextPath}/">
                <i class="fas fa-home me-1"></i>Trang chủ
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${pageContext.request.servletPath.contains('product-list') || pageContext.request.servletPath.contains('product-detail') || pageContext.request.servletPath.contains('product-search') || pageContext.request.servletPath.contains('product-category') ? 'active' : ''}"
                href="${pageContext.request.contextPath}/product/">
                <i class="fas fa-mobile-alt me-1"></i>Sản phẩm
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" role="button"
                data-bs-toggle="dropdown">
                <i class="fas fa-th-large me-1"></i>Danh mục
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=iPhone">
                    <i class="fas fa-mobile-alt me-2"></i>iPhone
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Samsung">
                    <i class="fas fa-mobile-alt me-2"></i>Samsung
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Xiaomi">
                    <i class="fas fa-mobile-alt me-2"></i>Xiaomi
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/product/category?category=Oppo">
                    <i class="fas fa-mobile-alt me-2"></i>Oppo
                  </a>
                </li>
              </ul>
            </li>
            <c:if test="${not empty sessionScope.user}">
              <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('cart') ? 'active' : ''}"
                  href="${pageContext.request.contextPath}/order/cart">
                  <i class="fas fa-shopping-cart me-1"></i>Giỏ hàng
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.contains('order-list') || pageContext.request.servletPath.contains('order-detail') ? 'active' : ''}"
                  href="${pageContext.request.contextPath}/order/list">
                  <i class="fas fa-list me-1"></i>Đơn hàng
                </a>
              </li>
            </c:if>
          </ul>

          <!-- Search Form -->
          <form class="d-flex me-3" action="${pageContext.request.contextPath}/product/search" method="get">
            <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm sản phẩm...">
            <button class="btn btn-outline-light" type="submit">
              <i class="fas fa-search"></i>
            </button>
          </form>

          <ul class="navbar-nav">
            <c:choose>
              <c:when test="${not empty sessionScope.user}">
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                    data-bs-toggle="dropdown">
                    <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/order/list">
                        <i class="fas fa-list me-2"></i>Đơn hàng của tôi
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/product/my-products">
                        <i class="fas fa-box me-2"></i>Sản phẩm của tôi
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/sell-product.jsp">
                        <i class="fas fa-plus me-2"></i>Đăng bán
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                        <i class="fas fa-user-circle me-2"></i>Hồ sơ
                      </a>
                    </li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                      <li>
                        <hr class="dropdown-divider">
                      </li>
                      <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                          <i class="fas fa-tachometer-alt me-2"></i>Quản trị
                        </a>
                      </li>
                    </c:if>
                    <li>
                      <hr class="dropdown-divider">
                    </li>
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                      </a>
                    </li>
                  </ul>
                </li>
              </c:when>
              <c:otherwise>
                <li class="nav-item">
                  <a class="nav-link" href="${pageContext.request.contextPath}/user/login">
                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="${pageContext.request.contextPath}/user/register">
                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                  </a>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
      </div>
    </nav>