<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công - Web Đề 03</title>
    <style>
        .success-box {
            max-width: 640px;
            margin: 30px auto;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 40px 32px;
            text-align: center;
            box-shadow: 0 10px 30px -5px rgba(15, 23, 42, 0.06);
        }
        .order-info-table {
            text-align: left;
            margin: 28px 0;
            background-color: #fafbfd;
            border-radius: 14px;
            padding: 20px 24px;
            border: 1px solid #e2e8f0;
        }
        .order-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            font-size: 14px;
            border-bottom: 1px dashed #e2e8f0;
        }
        .order-info-row:last-child {
            border-bottom: none;
        }
        .order-info-label {
            color: #64748b;
            font-weight: 500;
        }
        .order-info-value {
            color: #0f172a;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="success-box">
        <div class="mb-3">
            <i class="bi bi-check-circle-fill text-success" style="font-size: 3.5rem;"></i>
        </div>
        <h3 class="fw-bold text-dark mb-2" style="font-size: 1.6rem; letter-spacing: -0.02em;">Đặt Hàng Thành Công!</h3>
        <p class="text-muted mb-4" style="font-size: 14px;">
            Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được ghi nhận vào hệ thống với phương thức <strong>COD</strong>.
        </p>

        <c:choose>
            <c:when test="${not empty order}">
                <div class="order-info-table">
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-hash me-1"></i> Mã đơn hàng:</span>
                        <span class="order-info-value text-primary font-monospace fs-6">#ORD-${order.orderId}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-person me-1"></i> Người nhận hàng:</span>
                        <span class="order-info-value">${order.receiverName}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-telephone me-1"></i> Số điện thoại:</span>
                        <span class="order-info-value">${order.receiverPhone}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-geo-alt me-1"></i> Địa chỉ giao:</span>
                        <span class="order-info-value text-end" style="max-width: 60%;">${order.receiverAddress}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-credit-card me-1"></i> Phương thức:</span>
                        <span class="order-info-value"><span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1">COD (Thanh toán khi nhận hàng)</span></span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label"><i class="bi bi-shield-check me-1"></i> Trạng thái đơn:</span>
                        <span class="order-info-value"><span class="badge ${order.statusBadgeClass} px-3 py-1">${order.status}</span></span>
                    </div>
                    <div class="order-info-row pt-3">
                        <span class="order-info-label fs-6 fw-bold text-dark">Tổng tiền COD:</span>
                        <span class="order-info-value fs-4 fw-bold text-danger">${order.formattedTotalAmount}</span>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info py-2" style="border-radius: 8px;">Đơn hàng của bạn đã hoàn tất xử lý thành công.</div>
            </c:otherwise>
        </c:choose>

        <div class="d-flex justify-content-center gap-3 mt-4">
            <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-primary px-4 py-2 fw-semibold d-flex align-items-center gap-2" style="border-radius: 8px;">
                <i class="bi bi-receipt"></i>
                <span>Xem lịch sử đơn hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 fw-semibold d-flex align-items-center gap-2" style="border-radius: 8px;">
                <i class="bi bi-house"></i>
                <span>Về Trang Chủ</span>
            </a>
        </div>
    </div>
</body>
</html>
