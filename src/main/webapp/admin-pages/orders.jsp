<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý đơn hàng - Mobile Shop</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <!-- Include Admin Navbar -->
                <jsp:include page="admin-navbar.jsp" />

                <!-- Main Content -->
                <div class="container my-5">
                    <div
                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2"><i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng</h1>
                    </div>

                    <!-- Filter Section -->
                    <form method="get" action="${pageContext.request.contextPath}/admin/orders">
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <select class="form-select" name="status" onchange="this.form.submit()">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="pending" ${param.status=='pending' ? 'selected' : '' }>Chờ xử lý
                                    </option>
                                    <option value="processing" ${param.status=='processing' ? 'selected' : '' }>Đang xử
                                        lý</option>
                                    <option value="shipped" ${param.status=='shipped' ? 'selected' : '' }>Đã gửi hàng
                                    </option>
                                    <option value="delivered" ${param.status=='delivered' ? 'selected' : '' }>Đã giao
                                        hàng</option>
                                    <option value="cancelled" ${param.status=='cancelled' ? 'selected' : '' }>Đã hủy
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" name="date" value="${param.date}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" class="form-control" name="search" placeholder="Tìm kiếm đơn hàng..."
                                    value="${param.search}">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Lọc
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Orders Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày đặt</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>
                                            <strong>#${order.id}</strong>
                                        </td>
                                        <td>
                                            <strong class="text-danger">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                                    currencySymbol="VNĐ" />
                                            </strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <span class="badge bg-warning">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'processing'}">
                                                    <span class="badge bg-info">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'shipped'}">
                                                    <span class="badge bg-primary">Đã gửi hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'delivered'}">
                                                    <span class="badge bg-success">Đã giao hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="${pageContext.request.contextPath}/order/view?id=${order.id}"
                                                    class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-success"
                                                    onclick="updateStatus('${order.id}', 'processing')">
                                                    <i class="fas fa-play"></i>
                                                </button>
                                                <button type="button" class="btn btn-sm btn-outline-info"
                                                    onclick="updateStatus('${order.id}', 'shipped')">
                                                    <i class="fas fa-shipping-fast"></i>
                                                </button>
                                                <button type="button" class="btn btn-sm btn-outline-warning"
                                                    onclick="updateStatus('${order.id}', 'delivered')">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                    onclick="updateStatus('${order.id}', 'cancelled')">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Trước</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function updateStatus(orderId, status) {
                        if (confirm('Bạn có chắc muốn cập nhật trạng thái đơn hàng này?')) {
                            // Implement status update logic here
                            console.log('Updating order', orderId, 'to status:', status);
                        }
                    }
                </script>
            </body>

            </html>