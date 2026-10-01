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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary-navy: #0f172a;
            --primary-accent: #2563eb;
            --bg-light: #f8fafc;
            --border-color: #e2e8f0;
            --text-dark: #0f172a;
            --text-muted: #64748b;
        }
        body {
            font-family: 'Plus Jakarta Sans', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            -webkit-font-smoothing: antialiased;
        }
        main {
            flex: 1;
        }
        .main-navbar {
            background-color: var(--primary-navy);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
        }
        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.02em;
            color: #ffffff !important;
            font-size: 1.15rem;
        }
        .nav-link {
            font-weight: 500;
            font-size: 14px;
            color: #cbd5e1 !important;
            transition: all 0.2s ease;
            padding: 8px 14px !important;
            border-radius: 8px;
        }
        .nav-link:hover {
            color: #ffffff !important;
            background-color: rgba(255, 255, 255, 0.06);
        }
        .nav-link.active {
            color: #ffffff !important;
            font-weight: 600;
        }
        .admin-nav-badge {
            background: rgba(37, 99, 235, 0.25) !important;
            color: #93c5fd !important;
            border: 1px solid rgba(147, 197, 253, 0.3);
            border-radius: 8px;
        }
        .cart-badge-pill {
            background: #ef4444;
            color: #ffffff;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 9999px;
            margin-left: 4px;
            vertical-align: middle;
        }
        .btn-theme-primary {
            background-color: var(--primary-accent);
            border-color: var(--primary-accent);
            color: #ffffff;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .btn-theme-primary:hover {
            background-color: #1d4ed8;
            border-color: #1d4ed8;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        }
        .btn-theme-outline {
            border: 1px solid rgba(255, 255, 255, 0.2);
            background: transparent;
            color: #f1f5f9;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .btn-theme-outline:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.35);
        }
        button, a, .btn, .page-link, .stat-btn, .qty-btn, .qty-stepper-btn {
            cursor: pointer;
        }
        :focus-visible {
            outline: 2px solid var(--primary-accent);
            outline-offset: 2px;
        }
        .footer-theme {
            background-color: var(--primary-navy);
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            color: #94a3b8;
            padding: 28px 0;
            font-size: 14px;
            margin-top: 48px;
        }
        .footer-theme strong {
            color: #f8fafc;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>

    <nav class="navbar navbar-expand-lg main-navbar sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-circle-fill text-primary fs-5"></i>
                <span>ĐỀ 03 - WEB</span>
            </a>
            <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <i class="bi bi-list fs-4"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house me-1"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home#products">
                            <i class="bi bi-grid me-1"></i> Sản phẩm
                        </a>
                    </li>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link admin-nav-badge" href="${pageContext.request.contextPath}/admin/videos">
                                <i class="bi bi-speedometer2 me-1"></i> Trang quản trị
                            </a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                    <li class="nav-item me-lg-2">
                        <a class="nav-link position-relative d-flex align-items-center" href="${pageContext.request.contextPath}/cart" title="Xem giỏ hàng">
                            <i class="bi bi-cart3 me-1 fs-6"></i>
                            <span>Giỏ hàng</span>
                            <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                                <span class="cart-badge-pill">${sessionScope.cartCount}</span>
                            </c:if>
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-theme-primary btn-sm px-3" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-lg-2">
                                <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/order-history">
                                    <i class="bi bi-receipt me-1"></i> Lịch sử đơn hàng
                                </a>
                            </li>
                            <li class="nav-item">
                                <span class="nav-link text-light d-flex align-items-center">
                                    <i class="bi bi-person-circle me-1 text-secondary"></i>
                                    <strong>${sessionScope.user.fullname}</strong>
                                </span>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-theme-outline btn-sm px-3" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                                </a>
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
