<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Smart Navigation - Choose between Admin and User navbar -->
    <c:choose>
      <c:when test="${not empty sessionScope.user and sessionScope.user.role == 'admin'}">
        <!-- Include Admin Navbar for admin users -->
        <jsp:include page="admin-pages/admin-navbar.jsp" />
      </c:when>
      <c:otherwise>
        <!-- Include User Navbar for regular users or guests -->
        <jsp:include page="user-navbar.jsp" />
      </c:otherwise>
    </c:choose>