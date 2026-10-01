<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> - Web Đề 03</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #0f172a;
            --primary-accent: #2563eb;
            --bg-light: #f8fafc;
            --border-color: #e2e8f0;
            --text-dark: #1e293b;
            --text-muted: #64748b;
        }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
        }
        .main-navbar {
            background-color: var(--primary-navy);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
            color: #ffffff !important;
        }
        .nav-link {
            font-weight: 500;
            font-size: 14px;
            color: #cbd5e1 !important;
            transition: color 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            color: #ffffff !important;
        }
        .admin-nav-badge {
            background: rgba(37, 99, 235, 0.2);
            color: #60a5fa !important;
            border: 1px solid rgba(96, 165, 250, 0.4);
            border-radius: 6px;
            padding: 4px 10px;
        }
        .btn-theme-primary {
            background-color: var(--primary-accent);
            border-color: var(--primary-accent);
            color: #ffffff;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .btn-theme-primary:hover {
            background-color: #1d4ed8;
            border-color: #1d4ed8;
            color: #ffffff;
        }
        .btn-theme-outline {
            border: 1px solid var(--border-color);
            background: #ffffff;
            color: var(--text-dark);
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .btn-theme-outline:hover {
            background-color: #f1f5f9;
            color: var(--primary-navy);
        }
        .footer-theme {
            background-color: var(--primary-navy);
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            color: #94a3b8;
            padding: 24px 0;
            font-size: 14px;
            margin-top: 40px;
        }
        .footer-theme strong {
            color: #f1f5f9;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <nav class="navbar navbar-expand-lg main-navbar sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">ĐỀ 03 - WEB</a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home#products">Sản phẩm</a>
                    </li>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link admin-nav-badge" href="${pageContext.request.contextPath}/admin/videos">Trang quản trị</a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-theme-primary btn-sm px-3" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <span class="nav-link text-light">Xin chào, <strong>${sessionScope.user.fullname}</strong></span>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-theme-outline btn-sm px-3" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container py-4">
        <sitemesh:write property="body"/>
    </main>

    <footer class="footer-theme text-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4 mb-2 mb-md-0">
                    Họ và tên: <strong>Nguyễn Phước Thọ</strong>
                </div>
                <div class="col-md-4 mb-2 mb-md-0">
                    MSSV: <strong>24110343</strong>
                </div>
                <div class="col-md-4">
                    Mã đề: <strong>Đề số 03</strong>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
