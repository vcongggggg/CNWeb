<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý người dùng - Mobile Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        </head>

        <body>
            <!-- Include Admin Navbar -->
            <jsp:include page="admin-navbar.jsp" />

            <!-- Main Content -->
            <div class="container my-5">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-users me-2"></i>Quản lý người dùng</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="fas fa-plus me-2"></i>Thêm người dùng
                    </button>
                </div>

                <!-- Search and Filter -->
                <form method="get" action="${pageContext.request.contextPath}/admin/users">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="d-flex">
                                <input class="form-control me-2" type="text" name="search"
                                    placeholder="Tìm kiếm người dùng..." value="${param.search}">
                                <button class="btn btn-outline-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <select class="form-select" name="role" onchange="this.form.submit()">
                                <option value="">Tất cả vai trò</option>
                                <option value="admin" ${param.role=='admin' ? 'selected' : '' }>Admin</option>
                                <option value="customer" ${param.role=='customer' ? 'selected' : '' }>Khách hàng
                                </option>
                            </select>
                        </div>
                    </div>
                </form>

                <!-- Users Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Vai trò</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <span class="badge ${user.role == 'admin' ? 'bg-danger' : 'bg-primary'}">
                                            ${user.role == 'admin' ? 'Admin' : 'Khách hàng'}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" onclick="editUser('${user.id}')">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger"
                                            onclick="deleteUser('${user.id}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
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
                                <a class="page-link"
                                    href="?page=${currentPage - 1}&search=${param.search}&role=${param.role}">Trước</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link"
                                        href="?page=${i}&search=${param.search}&role=${param.role}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link"
                                    href="?page=${currentPage + 1}&search=${param.search}&role=${param.role}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>

            <!-- Add User Modal -->
            <div class="modal fade" id="addUserModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm người dùng mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/add-user" method="post">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username *</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password *</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Họ tên *</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone">
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <textarea class="form-control" id="address" name="address" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="role" class="form-label">Vai trò *</label>
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="customer">Khách hàng</option>
                                        <option value="admin">Admin</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Edit User Modal -->
            <div class="modal fade" id="editUserModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa người dùng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/update-user" method="post">
                            <input type="hidden" id="editUserId" name="id">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="editUsername" class="form-label">Username *</label>
                                    <input type="text" class="form-control" id="editUsername" name="username" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editFullName" class="form-label">Họ tên *</label>
                                    <input type="text" class="form-control" id="editFullName" name="fullName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editEmail" class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="editEmail" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editPhone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="editPhone" name="phone">
                                </div>
                                <div class="mb-3">
                                    <label for="editAddress" class="form-label">Địa chỉ</label>
                                    <textarea class="form-control" id="editAddress" name="address" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editRole" class="form-label">Vai trò *</label>
                                    <select class="form-select" id="editRole" name="role" required>
                                        <option value="customer">Khách hàng</option>
                                        <option value="admin">Admin</option>
                                    </select>
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
                function editUser(userId) {
                    // Load user data and show edit modal
                    fetch('${pageContext.request.contextPath}/admin/get-user?id=' + userId)
                        .then(response => response.json())
                        .then(user => {
                            document.getElementById('editUserId').value = user.id;
                            document.getElementById('editUsername').value = user.username;
                            document.getElementById('editFullName').value = user.fullName;
                            document.getElementById('editEmail').value = user.email;
                            document.getElementById('editPhone').value = user.phone || '';
                            document.getElementById('editAddress').value = user.address || '';
                            document.getElementById('editRole').value = user.role;

                            new bootstrap.Modal(document.getElementById('editUserModal')).show();
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi tải thông tin người dùng');
                        });
                }

                function deleteUser(userId) {
                    if (confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
                        fetch('${pageContext.request.contextPath}/admin/delete-user?id=' + userId, { method: 'POST' })
                            .then(response => {
                                if (response.ok) {
                                    location.reload();
                                } else {
                                    alert('Có lỗi xảy ra khi xóa người dùng');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('Có lỗi xảy ra khi xóa người dùng');
                            });
                    }
                }
            </script>
        </body>

        </html>