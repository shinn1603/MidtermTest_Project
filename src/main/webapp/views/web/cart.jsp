<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng - Web Đề 03</title>
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
        .cart-table th {
            background-color: #fafbfd;
            color: #475569;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e2e8f0;
            padding: 14px 18px;
        }
        .cart-table td {
            vertical-align: middle;
            padding: 18px;
            border-bottom: 1px solid #f1f5f9;
        }
        .cart-item-img {
            width: 84px;
            height: 54px;
            object-fit: cover;
            border-radius: 8px;
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
        }
        .cart-summary-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.04);
        }
        .qty-input-group {
            display: inline-flex;
            align-items: center;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            overflow: hidden;
            background: #ffffff;
            box-shadow: 0 1px 2px rgba(15, 23, 42, 0.05);
        }
        .qty-btn {
            border: none;
            background: #f8fafc;
            color: #334155;
            width: 34px;
            height: 36px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }
        .qty-btn:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
        .qty-input {
            width: 50px;
            height: 36px;
            border: none;
            text-align: center;
            font-weight: 700;
            font-size: 14px;
            outline: none;
            color: #0f172a;
        }
        .empty-cart-card {
            background: #ffffff;
            border: 1px dashed #cbd5e1;
            border-radius: 18px;
            padding: 56px 24px;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <nav class="breadcrumb-custom mb-3" aria-label="breadcrumb">
        <ol class="breadcrumb mb-0" style="font-size: 13px;">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Giỏ hàng (${totalQuantity})</li>
        </ol>
    </nav>

    <div class="page-header-box d-flex align-items-center justify-content-between flex-wrap gap-3">
        <div>
            <h3 class="page-title mb-1 d-flex align-items-center gap-2">
                <i class="bi bi-bag text-primary"></i>
                <span>Giỏ Hàng Của Bạn</span>
            </h3>
            <p class="page-subtitle mb-0">Quản lý và kiểm tra các sản phẩm đã chọn trước khi thanh toán.</p>
        </div>
        <c:if test="${not empty cartItems}">
            <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-sm btn-outline-danger d-flex align-items-center gap-1" onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ sản phẩm trong giỏ hàng?');" style="border-radius: 8px;">
                <i class="bi bi-trash3"></i>
                <span>Xóa toàn bộ giỏ</span>
            </a>
        </c:if>
    </div>

    <!-- Thông báo Flash message -->
    <c:if test="${not empty cartMsg}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm d-flex align-items-center gap-2" role="alert" style="border-radius: 10px;">
            <i class="bi bi-check-circle-fill text-success fs-5"></i>
            <div>${cartMsg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty cartWarning}">
        <div class="alert alert-warning alert-dismissible fade show border-0 shadow-sm d-flex align-items-center gap-2" role="alert" style="border-radius: 10px;">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-5"></i>
            <div>${cartWarning}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-cart-card shadow-sm">
                <i class="bi bi-cart-x text-secondary" style="font-size: 3.5rem;"></i>
                <h4 class="fw-bold text-dark mt-3 mb-1">Giỏ hàng của bạn đang trống</h4>
                <p class="text-muted mb-4" style="font-size: 14px;">Hãy khám phá các video khóa học để thêm vào giỏ hàng ngay nhé.</p>
                <a href="${pageContext.request.contextPath}/home#products" class="btn btn-primary px-4 py-2 fw-semibold" style="border-radius: 8px;">
                    <i class="bi bi-arrow-left me-1"></i> Khám phá sản phẩm ngay
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">
                <!-- Danh sách sản phẩm trong giỏ -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-3">
                        <div class="table-responsive">
                            <table class="table cart-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">Đơn giá</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-end">Thành tiền</th>
                                        <th class="text-center">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" class="me-3 flex-shrink-0">
                                                        <c:choose>
                                                            <c:when test="${not empty item.video.poster && item.video.poster.contains('/')}">
                                                                <img src="${pageContext.request.contextPath}/uploads/${item.video.poster}" alt="${item.video.title}" class="cart-item-img shadow-sm">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://picsum.photos/seed/${item.video.videoId}/400/225" alt="${item.video.title}" class="cart-item-img shadow-sm">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" class="fw-semibold text-dark text-decoration-none d-block mb-1" style="font-size: 14px; line-height: 1.3;">
                                                            ${item.video.title}
                                                        </a>
                                                        <div class="d-flex align-items-center gap-1 flex-wrap">
                                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle" style="font-size: 11px;">
                                                                <i class="bi bi-aspect-ratio me-1"></i>${item.size}
                                                            </span>
                                                            <small class="badge bg-light text-secondary border">Mã: ${item.video.videoId}</small>
                                                            <small class="text-muted ms-1"><i class="bi bi-box me-1"></i>Kho: ${item.video.stock}</small>
                                                        </div>
                                                        <c:if test="${not empty item.note}">
                                                            <small class="text-muted d-block mt-1 fst-italic" style="font-size: 12px;">
                                                                <i class="bi bi-chat-left-text me-1"></i>Yêu cầu: ${item.note}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </td>

                                            <td class="text-center fw-medium text-dark" style="font-size: 14px;">
                                                ${item.formattedPrice}
                                            </td>

                                            <td class="text-center">
                                                <div class="d-flex flex-column align-items-center">
                                                    <div class="qty-input-group">
                                                        <!-- Giảm số lượng -->
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display:inline;">
                                                            <input type="hidden" name="cartKey" value="${item.cartKey}">
                                                            <input type="hidden" name="action" value="minus">
                                                            <button type="submit" class="qty-btn" title="Giảm số lượng"><i class="bi bi-dash"></i></button>
                                                        </form>

                                                        <!-- Input số lượng -->
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display:inline;">
                                                            <input type="hidden" name="cartKey" value="${item.cartKey}">
                                                            <input type="hidden" name="action" value="set">
                                                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.video.stock}" class="qty-input" onchange="this.form.submit()">
                                                        </form>

                                                        <!-- Tăng số lượng -->
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display:inline;">
                                                            <input type="hidden" name="cartKey" value="${item.cartKey}">
                                                            <input type="hidden" name="action" value="plus">
                                                            <button type="submit" class="qty-btn" title="Tăng số lượng" ${item.quantity >= item.video.stock ? 'disabled' : ''}><i class="bi bi-plus"></i></button>
                                                        </form>
                                                    </div>
                                                    <small class="text-muted mt-1" style="font-size: 11px;">Giới hạn: 1 - ${item.video.stock}</small>
                                                </div>
                                            </td>

                                            <td class="text-end fw-bold text-primary" style="font-size: 15px;">
                                                ${item.formattedSubTotal}
                                            </td>

                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/cart/delete?cartKey=${item.cartKey}" class="btn btn-sm btn-outline-danger border-0 p-2" title="Xóa khỏi giỏ" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/home#products" class="btn btn-outline-secondary btn-sm px-3 py-2 fw-medium" style="border-radius: 8px;">
                        <i class="bi bi-arrow-left me-1"></i> Tiếp tục chọn thêm sản phẩm
                    </a>
                </div>

                <!-- Tóm tắt thanh toán -->
                <div class="col-lg-4">
                    <div class="cart-summary-card shadow-sm sticky-top" style="top: 80px;">
                        <h5 class="fw-bold text-dark border-bottom pb-3 mb-3 d-flex align-items-center gap-2">
                            <i class="bi bi-receipt text-primary"></i>
                            <span>Tóm Tắt Đơn Hàng</span>
                        </h5>

                        <div class="d-flex justify-content-between mb-2 text-muted" style="font-size: 14px;">
                            <span>Tổng số lượng:</span>
                            <span class="fw-semibold text-dark">${totalQuantity} sản phẩm</span>
                        </div>

                        <div class="d-flex justify-content-between mb-2 text-muted" style="font-size: 14px;">
                            <span>Tạm tính:</span>
                            <span class="fw-semibold text-dark">${formattedTotalAmount}</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3 text-muted" style="font-size: 14px;">
                            <span>Phí vận chuyển:</span>
                            <span class="text-success fw-semibold"><i class="bi bi-check2 me-1"></i>Miễn phí</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3 text-muted" style="font-size: 14px;">
                            <span>Phương thức:</span>
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1">
                                <i class="bi bi-cash-stack me-1"></i>COD
                            </span>
                        </div>

                        <hr class="my-3">

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fw-bold text-dark fs-5">Tổng tiền:</span>
                            <span class="fw-bold text-danger fs-4">${formattedTotalAmount}</span>
                        </div>

                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary py-2 fw-semibold d-flex align-items-center justify-content-center gap-2" style="border-radius: 8px; font-size: 15px;">
                                <span>Tiến hành thanh toán COD</span>
                                <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
