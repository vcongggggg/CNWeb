<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng nhập - Mobile Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="css/style.css" rel="stylesheet">
        </head>

        <body class="bg-light">
            <!-- Include Smart Navigation -->
            <jsp:include page="common-navbar.jsp" />

            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-4">
                        <div class="card shadow">
                            <div class="card-body p-5">
                                <div class="text-center mb-4">
                                    <i class="fas fa-user-circle fa-3x text-primary"></i>
                                    <h3 class="mt-3">Đăng nhập</h3>
                                    <p class="text-muted">Vui lòng đăng nhập để tiếp tục</p>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="fas fa-exclamation-triangle"></i> ${error}
                                    </div>
                                </c:if>

                                <c:if test="${not empty message}">
                                    <div class="alert alert-success" role="alert">
                                        <i class="fas fa-check-circle"></i> ${message}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/user/login" method="post">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Tên đăng nhập</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-user"></i>
                                            </span>
                                            <input type="text" class="form-control" id="username" name="username"
                                                required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Mật khẩu</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-lock"></i>
                                            </span>
                                            <input type="password" class="form-control" id="password" name="password"
                                                required>
                                        </div>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                        </button>
                                    </div>
                                </form>

                                <hr class="my-4">

                                <div class="text-center">
                                    <p class="mb-0">Chưa có tài khoản?
                                        <a href="${pageContext.request.contextPath}/user/register"
                                            class="text-decoration-none">
                                            Đăng ký ngay
                                        </a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>