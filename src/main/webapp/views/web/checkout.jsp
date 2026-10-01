<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng COD - Web Đề 03</title>
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
        .checkout-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.04);
        }
        .order-review-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .order-review-item:last-child {
            border-bottom: none;
        }
        .order-review-img {
            width: 64px;
            height: 42px;
            object-fit: cover;
            border-radius: 8px;
            background-color: #f1f5f9;
            margin-right: 14px;
            flex-shrink: 0;
            border: 1px solid #e2e8f0;
        }
        .cod-option-box {
            border: 2px solid #2563eb;
            background-color: #f0f7ff;
            border-radius: 12px;
            padding: 18px 20px;
        }
        .form-label {
            font-weight: 600;
            font-size: 13.5px;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-control {
            border-radius: 8px;
            border-color: #cbd5e1;
            padding: 9px 12px;
            font-size: 14px;
        }
        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
    </style>
</head>
<body>
    <nav class="breadcrumb-custom mb-3" aria-label="breadcrumb">
        <ol class="breadcrumb mb-0" style="font-size: 13px;">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-muted text-decoration-none">Giỏ hàng</a></li>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Thanh toán COD</li>
        </ol>
    </nav>

    <div class="page-header-box">
        <h3 class="page-title mb-1 d-flex align-items-center gap-2">
            <i class="bi bi-shield-check text-primary"></i>
            <span>Thanh Toán Đơn Hàng (COD)</span>
        </h3>
        <p class="page-subtitle mb-0">Vui lòng kiểm tra và điền thông tin để chúng tôi giao hàng và thu tiền tận nơi.</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm d-flex align-items-center gap-2" role="alert" style="border-radius: 10px;">
            <i class="bi bi-exclamation-circle-fill text-danger fs-5"></i>
            <div>${error}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="row g-4">
            <!-- Thông tin giao hàng -->
            <div class="col-lg-7">
                <div class="checkout-card shadow-sm mb-4">
                    <h5 class="fw-bold text-dark border-bottom pb-3 mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-geo-alt text-primary"></i>
                        <span>Thông Tin Người Nhận Hàng</span>
                    </h5>

                    <div class="mb-3">
                        <label for="receiverName" class="form-label">
                            <i class="bi bi-person me-1 text-muted"></i> Họ và tên người nhận <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="receiverName" name="receiverName"
                               value="${not empty receiverName ? receiverName : user.fullname}" required
                               placeholder="Ví dụ: Nguyễn Văn A">
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="receiverPhone" class="form-label">
                                <i class="bi bi-telephone me-1 text-muted"></i> Số điện thoại liên hệ <span class="text-danger">*</span>
                            </label>
                            <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone"
                                   value="${not empty receiverPhone ? receiverPhone : user.phone}" required
                                   placeholder="Ví dụ: 0987654321">
                        </div>
                        <div class="col-md-6">
                            <label for="emailUser" class="form-label">
                                <i class="bi bi-envelope me-1 text-muted"></i> Email tài khoản
                            </label>
                            <input type="email" class="form-control bg-light" id="emailUser" value="${user.email}" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="receiverAddress" class="form-label">
                            <i class="bi bi-pin-map me-1 text-muted"></i> Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="receiverAddress" name="receiverAddress"
                               value="${receiverAddress}" required
                               placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố">
                    </div>

                    <div class="mb-2">
                        <label for="notes" class="form-label">
                            <i class="bi bi-chat-left-text me-1 text-muted"></i> Ghi chú giao hàng (Tùy chọn)
                        </label>
                        <textarea class="form-control" id="notes" name="notes" rows="2"
                                  placeholder="Ghi chú thêm về thời gian giao hàng, chỉ dẫn địa chỉ...">${notes}</textarea>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="checkout-card shadow-sm">
                    <h5 class="fw-bold text-dark border-bottom pb-3 mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-credit-card text-primary"></i>
                        <span>Phương Thức Thanh Toán</span>
                    </h5>
                    
                    <div class="cod-option-box mb-2">
                        <div class="form-check d-flex align-items-center mb-0">
                            <input class="form-check-input me-3" type="radio" name="paymentMethod" id="paymentCOD" value="COD" checked>
                            <label class="form-check-label w-100" for="paymentCOD">
                                <div class="d-flex justify-content-between align-items-center">
                                    <strong class="text-primary fs-6 d-flex align-items-center gap-2">
                                        <i class="bi bi-cash-stack"></i>
                                        <span>Thanh toán khi nhận hàng (COD)</span>
                                    </strong>
                                    <span class="badge bg-primary">Khuyên dùng</span>
                                </div>
                                <small class="text-muted d-block mt-1">
                                    Quý khách sẽ kiểm tra hàng và thanh toán trực tiếp số tiền <strong>${formattedTotalAmount}</strong> cho nhân viên giao hàng khi nhận sản phẩm.
                                </small>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tóm tắt đơn hàng bên phải -->
            <div class="col-lg-5">
                <div class="checkout-card shadow-sm sticky-top" style="top: 80px;">
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                        <h5 class="fw-bold text-dark mb-0 d-flex align-items-center gap-2">
                            <i class="bi bi-bag-check text-primary"></i>
                            <span>Đơn Hàng Của Bạn</span>
                        </h5>
                        <span class="badge bg-secondary-subtle text-secondary border px-2 py-1">${totalQuantity} sản phẩm</span>
                    </div>

                    <!-- Danh sách các món trong đơn -->
                    <div class="order-items-list mb-3" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="order-review-item">
                                <c:choose>
                                    <c:when test="${not empty item.video.poster && item.video.poster.contains('/')}">
                                        <img src="${pageContext.request.contextPath}/uploads/${item.video.poster}" alt="${item.video.title}" class="order-review-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://picsum.photos/seed/${item.video.videoId}/200/150" alt="${item.video.title}" class="order-review-img">
                                    </c:otherwise>
                                </c:choose>
                                <div class="flex-grow-1 me-2" style="font-size: 13px;">
                                    <div class="fw-semibold text-dark text-truncate" style="max-width: 190px;">${item.video.title}</div>
                                    <div class="d-flex align-items-center gap-1 mt-1 flex-wrap">
                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle" style="font-size: 10px;">${item.size}</span>
                                        <span class="text-muted">SL: x${item.quantity} &bull; ${item.formattedPrice}</span>
                                    </div>
                                    <c:if test="${not empty item.note}">
                                        <small class="text-muted d-block fst-italic" style="font-size: 11px;">Y/c: ${item.note}</small>
                                    </c:if>
                                </div>
                                <div class="fw-bold text-dark" style="font-size: 14px;">
                                    ${item.formattedSubTotal}
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-2 text-muted" style="font-size: 14px;">
                        <span>Tạm tính:</span>
                        <span class="fw-semibold text-dark">${formattedTotalAmount}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2 text-muted" style="font-size: 14px;">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success fw-semibold"><i class="bi bi-check2 me-1"></i>Miễn phí</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3 text-muted" style="font-size: 14px;">
                        <span>Hình thức thanh toán:</span>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle">COD</span>
                    </div>

                    <hr class="my-3">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold text-dark fs-5">Tổng thanh toán:</span>
                        <span class="fw-bold text-danger fs-4">${formattedTotalAmount}</span>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary py-2 fw-semibold fs-6 shadow-sm d-flex align-items-center justify-content-center gap-2" style="border-radius: 8px;">
                            <span>Xác Nhận Đặt Hàng COD</span>
                            <i class="bi bi-arrow-right"></i>
                        </button>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-sm py-2" style="border-radius: 8px;">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại chỉnh sửa giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
