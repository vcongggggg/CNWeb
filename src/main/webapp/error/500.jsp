<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi máy chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container text-center mt-5">
        <h1 class="display-1">500</h1>
        <h2>Lỗi máy chủ</h2>
        <p class="lead">Đã xảy ra lỗi trong quá trình xử lý yêu cầu.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Về trang chủ</a>
    </div>
</body>
</html> 