<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đơn Hàng - Web Đề 03</title>
    <style>
        .page-header-box {
            margin-bottom: 24px;
        }
        .page-title {
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            color: #0f172a;
        }
        .page-subtitle {
            font-size: 14px;
            color: #64748b;
        }
        .status-tabs-container {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 8px;
            margin-bottom: 24px;
            display: flex;
            gap: 6px;
            overflow-x: auto;
            scrollbar-width: thin;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.04);
        }
        .status-tab-item {
            display: inline-flex;
            align-items: center;
            padding: 8px 14px;
            border-radius: 10px;
            color: #475569;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            white-space: nowrap;
            transition: all 0.2s ease;
        }
        .status-tab-item:hover {
            color: #0f172a;
            background-color: #f1f5f9;
        }
        .status-tab-item.active {
            background-color: #0f172a;
            color: #ffffff !important;
            box-shadow: 0 4px 10px rgba(15, 23, 42, 0.15);
        }
        .tab-badge {
            font-size: 11px;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 9999px;
            margin-left: 8px;
            background: #f1f5f9;
            color: #475569;
            transition: all 0.2s;
        }
        .status-tab-item.active .tab-badge {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
        .order-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.25s ease;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.04);
        }
        .order-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.08);
            transform: translateY(-2px);
        }
        .order-card-header {
            background-color: #fafbfd;
            border-bottom: 1px solid #f1f5f9;
            padding: 16px 22px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
        }
        .order-code-badge {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-weight: 700;
            font-size: 14px;
            color: #0f172a;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .order-card-body {
            padding: 18px 22px;
        }
        .order-item-row {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f8fafc;
        }
        .order-item-row:last-child {
            border-bottom: none;
        }
        .order-thumb-img {
            width: 76px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            background-color: #f1f5f9;
            margin-right: 16px;
            flex-shrink: 0;
            border: 1px solid #e2e8f0;
        }
        .order-card-footer {
            background: #fafbfd;
            border-top: 1px solid #f1f5f9;
            padding: 16px 22px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }
        .shipping-info-box {
            font-size: 13px;
            color: #475569;
            line-height: 1.6;
        }
        .status-badge-pill {
            font-size: 12px;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .empty-orders-card {
            background: #ffffff;
            border: 1px dashed #cbd5e1;
            border-radius: 18px;
            padding: 48px 24px;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <nav class="breadcrumb-custom mb-3" aria-label="breadcrumb">
        <ol class="breadcrumb mb-0" style="font-size: 13px;">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Lịch sử đơn hàng</li>
        </ol>
    </nav>

    <div class="page-header-box d-flex align-items-center justify-content-between flex-wrap gap-3">
        <div>
            <h3 class="page-title mb-1 d-flex align-items-center gap-2">
                <i class="bi bi-clock-history text-primary"></i>
                <span>Lịch Sử Đơn Hàng</span>
            </h3>
            <p class="page-subtitle mb-0">Theo dõi tiến độ và quản lý tất cả đơn hàng đã đặt của bạn.</p>
        </div>
        <a href="${pageContext.request.contextPath}/home#products" class="btn btn-outline-primary btn-sm px-3 py-2 fw-semibold" style="border-radius: 8px;">
            <i class="bi bi-bag-plus me-1"></i> Tiếp tục mua hàng
        </a>
    </div>

    <!-- Thanh 8 trạng thái lọc đơn hàng (Hiện đại, có icon vector) -->
    <div class="status-tabs-container">
        <a href="${pageContext.request.contextPath}/order-history?status=all"
           class="status-tab-item ${selectedStatus == 'all' ? 'active' : ''}">
            <i class="bi bi-grid-fill me-1"></i> Tất cả
            <span class="tab-badge">${statusCounts['all']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Đơn hàng mới', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Đơn hàng mới' ? 'active' : ''}">
            <i class="bi bi-asterisk me-1"></i> Đơn hàng mới
            <span class="tab-badge">${statusCounts['Đơn hàng mới']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Đã xác nhận', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Đã xác nhận' ? 'active' : ''}">
            <i class="bi bi-check-circle me-1"></i> Đã xác nhận
            <span class="tab-badge">${statusCounts['Đã xác nhận']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Chuẩn bị hàng', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Chuẩn bị hàng' ? 'active' : ''}">
            <i class="bi bi-box-seam me-1"></i> Chuẩn bị hàng
            <span class="tab-badge">${statusCounts['Chuẩn bị hàng']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Vận chuyển', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Vận chuyển' ? 'active' : ''}">
            <i class="bi bi-truck me-1"></i> Vận chuyển
            <span class="tab-badge">${statusCounts['Vận chuyển']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Giao hàng', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Giao hàng' ? 'active' : ''}">
            <i class="bi bi-send me-1"></i> Giao hàng
            <span class="tab-badge">${statusCounts['Giao hàng']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Đã giao', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Đã giao' ? 'active' : ''}">
            <i class="bi bi-check2-all me-1"></i> Đã giao
            <span class="tab-badge">${statusCounts['Đã giao']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Đơn hàng hủy', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Đơn hàng hủy' ? 'active' : ''}">
            <i class="bi bi-x-circle me-1"></i> Đơn hàng hủy
            <span class="tab-badge">${statusCounts['Đơn hàng hủy']}</span>
        </a>
        <a href="${pageContext.request.contextPath}/order-history?status=${java.net.URLEncoder.encode('Đơn hàng hoàn', 'UTF-8')}"
           class="status-tab-item ${selectedStatus == 'Đơn hàng hoàn' ? 'active' : ''}">
            <i class="bi bi-arrow-return-left me-1"></i> Đơn hàng hoàn
            <span class="tab-badge">${statusCounts['Đơn hàng hoàn']}</span>
        </a>
    </div>

    <!-- Danh sách đơn hàng -->
    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders-card shadow-sm">
                <i class="bi bi-inbox text-secondary" style="font-size: 3rem;"></i>
                <h5 class="fw-bold text-dark mt-3 mb-1">Chưa có đơn hàng nào</h5>
                <p class="text-muted mb-4" style="font-size: 14px;">Không tìm thấy đơn hàng nào ở trạng thái "${selectedStatus == 'all' ? 'Tất cả' : selectedStatus}".</p>
                <a href="${pageContext.request.contextPath}/home#products" class="btn btn-primary px-4 py-2 fw-semibold" style="border-radius: 8px;">
                    <i class="bi bi-cart-plus me-1"></i> Mua sắm ngay
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <c:forEach var="o" items="${orders}">
                <div class="order-card">
                    <!-- Header của từng đơn hàng -->
                    <div class="order-card-header">
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <span class="order-code-badge">#ORD-${o.orderId}</span>
                            <span class="text-muted" style="font-size: 13px;">
                                <i class="bi bi-calendar3 me-1"></i>
                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-light text-secondary border px-2 py-1" style="font-size: 12px;">
                                <i class="bi bi-cash-stack me-1"></i> Phương thức: ${o.paymentMethod}
                            </span>
                            <span class="status-badge-pill ${o.statusBadgeClass}">
                                <i class="bi bi-dot fs-6"></i> ${o.status}
                            </span>
                        </div>
                    </div>

                    <!-- Danh sách sản phẩm của đơn hàng -->
                    <div class="order-card-body">
                        <c:forEach var="d" items="${o.orderDetails}">
                            <div class="order-item-row">
                                <c:choose>
                                    <c:when test="${d.video != null && not empty d.video.poster && d.video.poster.contains('/')}">
                                        <img src="${pageContext.request.contextPath}/uploads/${d.video.poster}" alt="${d.video.title}" class="order-thumb-img shadow-sm">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://picsum.photos/seed/${d.video != null ? d.video.videoId : 'vid'}/200/150" alt="poster" class="order-thumb-img shadow-sm">
                                    </c:otherwise>
                                </c:choose>

                                <div class="flex-grow-1">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${d.video != null ? d.video.videoId : ''}" class="fw-semibold text-dark text-decoration-none d-block mb-1" style="font-size: 14px;">
                                        ${d.video != null ? d.video.title : 'Sản phẩm đã xóa'}
                                    </a>
                                    <div class="text-muted d-flex align-items-center gap-2 flex-wrap" style="font-size: 13px;">
                                        <c:if test="${not empty d.size}">
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle" style="font-size: 11px;">
                                                <i class="bi bi-aspect-ratio me-1"></i>${d.size}
                                            </span>
                                        </c:if>
                                        <span>Mã: <code class="text-secondary">${d.video != null ? d.video.videoId : 'N/A'}</code></span>
                                        <span>&bull;</span>
                                        <span>Số lượng: <strong class="text-dark">x${d.quantity}</strong></span>
                                    </div>
                                </div>

                                <div class="text-end">
                                    <div class="text-muted" style="font-size: 12px;">Đơn giá: ${d.formattedPrice}</div>
                                    <div class="fw-bold text-dark fs-6">${d.formattedSubTotal}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Footer của từng đơn hàng -->
                    <div class="order-card-footer">
                        <div class="shipping-info-box">
                            <div>
                                <i class="bi bi-person text-primary me-1"></i> Người nhận: <strong>${o.receiverName}</strong>
                                <span class="ms-2 text-muted">(<i class="bi bi-telephone me-1"></i>${o.receiverPhone})</span>
                            </div>
                            <div>
                                <i class="bi bi-geo-alt text-primary me-1"></i> Địa chỉ: ${o.receiverAddress}
                            </div>
                            <c:if test="${not empty o.notes}">
                                <div class="text-secondary">
                                    <i class="bi bi-chat-left-text text-primary me-1"></i> Ghi chú: <em>${o.notes}</em>
                                </div>
                            </c:if>
                        </div>
                        <div class="text-end">
                            <span class="text-muted small d-block mb-1">Tổng thanh toán COD:</span>
                            <div class="fw-bold text-danger fs-4">${o.formattedTotalAmount}</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</body>
</html>
