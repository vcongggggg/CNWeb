<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Admin Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
          <i class="fas fa-mobile-alt me-2"></i>Mobile Shop
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a class="nav-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}"
                href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt me-1"></i>Dashboard
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                <i class="fas fa-cog me-1"></i>Quản lý
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('products') && !pageContext.request.servletPath.contains('pending') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-mobile-alt me-2"></i>Quản lý sản phẩm
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('pending-products') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/pending-products">
                    <i class="fas fa-clock me-2"></i>Duyệt sản phẩm
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('users') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users me-2"></i>Quản lý người dùng
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('orders') && !pageContext.request.servletPath.contains('order-stats') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng
                  </a>
                </li>
                <li>
                  <hr class="dropdown-divider">
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('product-stats') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/product-stats">
                    <i class="fas fa-chart-bar me-2"></i>Thống kê sản phẩm
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('order-stats') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/order-stats">
                    <i class="fas fa-chart-line me-2"></i>Thống kê đơn hàng
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('category-stats') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/category-stats">
                    <i class="fas fa-chart-pie me-2"></i>Thống kê danh mục
                  </a>
                </li>
                <li>
                  <a class="dropdown-item ${pageContext.request.servletPath.contains('stats') && !pageContext.request.servletPath.contains('product-stats') && !pageContext.request.servletPath.contains('order-stats') && !pageContext.request.servletPath.contains('category-stats') ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/stats">
                    <i class="fas fa-chart-area me-2"></i>Tổng quan thống kê
                  </a>
                </li>
              </ul>
            </li>
          </ul>
          <ul class="navbar-nav">
            <c:if test="${not empty sessionScope.user}">
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                  data-bs-toggle="dropdown">
                  <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                      <i class="fas fa-user-circle me-2"></i>Hồ sơ
                    </a>
                  </li>
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
            </c:if>
          </ul>
        </div>
      </div>
    </nav>