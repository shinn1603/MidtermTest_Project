<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${video.title} - Chi Tiết Video</title>
    <style>
        .breadcrumb-custom {
            font-size: 13.5px;
            margin-bottom: 20px;
        }
        .breadcrumb-custom a {
            color: #64748b;
            text-decoration: none;
            transition: color 0.15s;
        }
        .breadcrumb-custom a:hover {
            color: #2563eb;
        }
        .detail-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 4px 20px -5px rgba(15, 23, 42, 0.05);
        }
        .media-container {
            border-radius: 14px;
            overflow: hidden;
            background-color: #0f172a;
            box-shadow: 0 8px 24px -4px rgba(15, 23, 42, 0.2);
            min-height: 260px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .media-container img {
            width: 100%;
            height: auto;
            max-height: 380px;
            object-fit: cover;
            display: block;
        }
        .media-container video {
            width: 100%;
            max-height: 380px;
            display: block;
        }
        .detail-title {
            font-size: 1.7rem;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.3;
            letter-spacing: -0.02em;
            margin-bottom: 18px;
        }
        .detail-row {
            display: flex;
            align-items: center;
            padding: 11px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }
        .detail-label {
            font-weight: 600;
            color: #64748b;
            width: 130px;
            flex-shrink: 0;
        }
        .detail-value {
            font-weight: 500;
            color: #0f172a;
        }
        .category-tag {
            background-color: #eff6ff;
            border: 1px solid #bfdbfe;
            color: #1d4ed8;
            padding: 3px 12px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .price-highlight-box {
            background: linear-gradient(135deg, #fff1f2 0%, #ffe4e6 100%);
            border: 1px solid #fecdd3;
            border-radius: 12px;
            padding: 14px 18px;
            display: flex;
            align-items: baseline;
            gap: 12px;
            margin: 16px 0;
        }
        .price-val {
            font-size: 26px;
            font-weight: 800;
            color: #e11d48;
            letter-spacing: -0.02em;
        }
        .buy-action-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px;
        }
        .qty-stepper {
            display: inline-flex;
            align-items: center;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            overflow: hidden;
            background: #ffffff;
            box-shadow: 0 1px 2px rgba(15, 23, 42, 0.04);
        }
        .qty-stepper-btn {
            border: none;
            background: #f8fafc;
            color: #334155;
            width: 38px;
            height: 38px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.15s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-stepper-btn:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
        .qty-stepper-input {
            width: 54px;
            height: 38px;
            border: none;
            text-align: center;
            font-weight: 700;
            font-size: 15px;
            outline: none;
            color: #0f172a;
        }
        .btn-add-cart-lg {
            background-color: #2563eb;
            color: #ffffff;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 10px;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            cursor: pointer;
        }
        .btn-add-cart-lg:hover {
            background-color: #1d4ed8;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        }
        .btn-buy-now-lg {
            background-color: #e11d48;
            color: #ffffff;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 10px;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            cursor: pointer;
        }
        .btn-buy-now-lg:hover {
            background-color: #be123c;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(225, 29, 72, 0.25);
        }
        .stats-badge-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
        .stat-btn {
            font-size: 13.5px;
            font-weight: 600;
            padding: 9px 18px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            transition: all 0.2s;
            border: 1px solid transparent;
            background: transparent;
        }
        .stat-btn:active {
            transform: scale(0.96);
        }
        .btn-interactive-share {
            background-color: #f1f5f9;
            color: #334155;
            border-color: #cbd5e1;
        }
        .btn-interactive-share:hover {
            background-color: #e2e8f0;
            color: #0f172a;
        }
        .btn-interactive-like {
            background-color: #fef2f2;
            color: #dc2626;
            border-color: #fecaca;
        }
        .btn-interactive-like:hover {
            background-color: #fee2e2;
            color: #b91c1c;
        }
        .btn-interactive-like.liked {
            background-color: #dc2626;
            color: #ffffff;
            border-color: #dc2626;
        }
        .description-section {
            margin-top: 32px;
            padding-top: 26px;
            border-top: 1px solid #e2e8f0;
        }
        .description-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .description-content {
            color: #475569;
            line-height: 1.75;
            font-size: 14.5px;
        }
    </style>
</head>
<body>
    <nav class="breadcrumb-custom" aria-label="breadcrumb">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="bi bi-house me-1"></i>Trang Chủ</a></li>
            <c:if test="${video.category != null}">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">${video.category.categoryname}</a></li>
            </c:if>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">${video.title}</li>
        </ol>
    </nav>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm px-3 d-inline-flex align-items-center gap-1" style="border-radius: 8px; border-color: #cbd5e1; color: #475569;">
            <i class="bi bi-arrow-left"></i>
            <span>Quay lại Trang Chủ</span>
        </a>
    </div>

    <div class="detail-card">
        <div class="row g-4">
            <div class="col-lg-5">
                <div class="media-container">
                    <c:choose>
                        <c:when test="${not empty video.videoUrl}">
                            <video controls poster="https://picsum.photos/seed/${video.videoId}/600/400">
                                <source src="${pageContext.request.contextPath}/uploads/${video.videoUrl}" type="video/mp4">
                                Trình duyệt của bạn không hỗ trợ phát video này.
                            </video>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${not empty video.poster && video.poster.contains('/')}">
                                    <img src="${pageContext.request.contextPath}/uploads/${video.poster}" alt="${video.title}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://picsum.photos/seed/${video.videoId}/600/400" alt="${video.title}">
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${not empty video.videoUrl}">
                    <div class="text-center mt-3">
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
                            <i class="bi bi-broadcast me-1"></i> Video sẵn sàng phát trực tiếp
                        </span>
                    </div>
                </c:if>
            </div>

            <div class="col-lg-7">
                <h1 class="detail-title">${video.title}</h1>

                <div class="detail-row">
                    <span class="detail-label">Mã video:</span>
                    <span class="detail-value font-monospace fw-bold text-primary">#${video.videoId}</span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Danh mục:</span>
                    <span class="category-tag">
                        <i class="bi bi-folder2"></i>
                        <span>${video.category != null ? video.category.categoryname : 'N/A'}</span>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Lượt xem:</span>
                    <span class="detail-value d-flex align-items-center gap-1">
                        <i class="bi bi-eye text-secondary"></i>
                        <span>${video.views} lượt xem</span>
                    </span>
                </div>

                <div class="price-highlight-box">
                    <div>
                        <div class="text-muted small fw-semibold">Đơn giá niêm yết:</div>
                        <div class="price-val">${video.formattedPrice}</div>
                    </div>
                    <div class="ms-auto text-end">
                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle">
                            <i class="bi bi-shield-check me-1"></i>Hàng chính hãng
                        </span>
                    </div>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Tình trạng kho:</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${video.stock > 0}">
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                    <i class="bi bi-check2-circle me-1"></i>Còn ${video.stock} sản phẩm có sẵn
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1">
                                    <i class="bi bi-x-circle me-1"></i>Tạm hết hàng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <!-- Form Thêm Giỏ Hàng / Mua Ngay với Tùy Chỉnh Thông Số -->
                <c:if test="${video.stock > 0}">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="buy-action-box">
                        <input type="hidden" name="videoId" value="${video.videoId}">

                        <!-- 1. Tùy chỉnh Size / Phiên bản -->
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark small mb-2 d-flex align-items-center gap-1">
                                <i class="bi bi-aspect-ratio text-primary"></i>
                                <span>Chọn Size / Độ phân giải:</span>
                            </label>
                            <div class="row g-2">
                                <div class="col-6 col-sm-3">
                                    <input type="radio" class="btn-check" name="size" id="detailSizeS" value="Size S (720p HD)">
                                    <label class="btn btn-outline-secondary w-100 text-start py-2 px-2" for="detailSizeS" style="border-radius: 10px; font-size: 13px;">
                                        <div class="fw-bold">Size S</div>
                                        <small class="text-muted" style="font-size: 11px;">720p HD</small>
                                    </label>
                                </div>
                                <div class="col-6 col-sm-3">
                                    <input type="radio" class="btn-check" name="size" id="detailSizeM" value="Size M (1080p FHD)" checked>
                                    <label class="btn btn-outline-primary w-100 text-start py-2 px-2" for="detailSizeM" style="border-radius: 10px; font-size: 13px;">
                                        <div class="fw-bold">Size M <span class="badge bg-primary text-white" style="font-size: 9px;">Chuẩn</span></div>
                                        <small class="text-muted" style="font-size: 11px;">1080p FHD</small>
                                    </label>
                                </div>
                                <div class="col-6 col-sm-3">
                                    <input type="radio" class="btn-check" name="size" id="detailSizeL" value="Size L (2K QHD)">
                                    <label class="btn btn-outline-secondary w-100 text-start py-2 px-2" for="detailSizeL" style="border-radius: 10px; font-size: 13px;">
                                        <div class="fw-bold">Size L</div>
                                        <small class="text-muted" style="font-size: 11px;">2K QHD</small>
                                    </label>
                                </div>
                                <div class="col-6 col-sm-3">
                                    <input type="radio" class="btn-check" name="size" id="detailSizeXL" value="Size XL (4K UHD)">
                                    <label class="btn btn-outline-secondary w-100 text-start py-2 px-2" for="detailSizeXL" style="border-radius: 10px; font-size: 13px;">
                                        <div class="fw-bold">Size XL</div>
                                        <small class="text-muted" style="font-size: 11px;">4K UHD</small>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- 2. Tùy chỉnh Số lượng & Tạm tính -->
                        <div class="d-flex align-items-center justify-content-between mb-3 p-2 bg-white rounded-3 border flex-wrap gap-2">
                            <div class="d-flex align-items-center">
                                <label for="detailQuantity" class="fw-semibold text-dark mb-0 me-3" style="font-size: 14px;">Số lượng:</label>
                                <div class="qty-stepper">
                                    <button class="qty-stepper-btn" type="button" id="detailQtyMinus" title="Giảm 1">
                                        <i class="bi bi-dash-lg"></i>
                                    </button>
                                    <input type="number" id="detailQuantity" name="quantity" class="qty-stepper-input" value="1" min="1" max="${video.stock}">
                                    <button class="qty-stepper-btn" type="button" id="detailQtyPlus" title="Tăng 1">
                                        <i class="bi bi-plus-lg"></i>
                                    </button>
                                </div>
                                <small class="text-muted ms-2">(Tối đa ${video.stock})</small>
                            </div>
                            <div class="text-end">
                                <small class="text-muted d-block">Tạm tính:</small>
                                <span class="fs-6 fw-bold text-danger" id="detailSubtotal">${video.formattedPrice}</span>
                            </div>
                        </div>

                        <!-- 3. Ghi chú yêu cầu tùy chỉnh -->
                        <div class="mb-3">
                            <label for="detailNote" class="form-label fw-semibold text-secondary small mb-1">
                                <i class="bi bi-chat-left-text me-1"></i> Ghi chú đơn / Yêu cầu tùy chỉnh (tùy chọn):
                            </label>
                            <input type="text" class="form-control form-control-sm" id="detailNote" name="note" placeholder="Ví dụ: Gửi kèm link tải phụ đề tiếng Anh, đóng gói quà, v.v.">
                        </div>

                        <div class="d-flex gap-3 flex-wrap">
                            <button type="submit" name="redirect" value="cart" class="btn-add-cart-lg">
                                <i class="bi bi-cart-plus fs-5"></i>
                                <span>Thêm vào giỏ hàng</span>
                            </button>
                            <button type="submit" name="redirect" value="checkout" class="btn-buy-now-lg" onclick="this.form.action='${pageContext.request.contextPath}/cart/add';">
                                <i class="bi bi-lightning-charge-fill fs-5"></i>
                                <span>Mua ngay (COD)</span>
                            </button>
                        </div>
                    </form>
                </c:if>

                <div class="stats-badge-group">
                    <button type="button" id="btnShare" class="stat-btn btn-interactive-share shadow-sm" title="Bấm để sao chép liên kết chia sẻ video">
                        <i class="bi bi-share"></i>
                        <span id="shareCountText">Share (${video.shareCount})</span>
                    </button>
                    <button type="button" id="btnLike" class="stat-btn btn-interactive-like shadow-sm" title="Bấm để thích video">
                        <i class="bi bi-heart"></i>
                        <span id="likeCountText">Like (${video.likeCount})</span>
                    </button>
                </div>
            </div>
        </div>

        <div class="description-section">
            <h5 class="description-title">
                <i class="bi bi-file-text text-primary"></i>
                <span>Mô tả video chi tiết:</span>
            </h5>
            <div class="description-content">
                <p class="mb-0">
                    ${not empty video.description ? video.description : 'Hiện chưa có nội dung mô tả chi tiết cho video này.'}
                </p>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
        <div id="liveToast" class="toast align-items-center text-bg-dark border-0 shadow" role="alert" aria-live="assertive" aria-atomic="true" style="border-radius: 12px;">
            <div class="d-flex">
                <div class="toast-body d-flex align-items-center gap-2" id="toastMessage">
                    <i class="bi bi-info-circle-fill text-primary"></i>
                    <span>Thông báo</span>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>

    <script>
        function showNotification(msg) {
            const toastEl = document.getElementById('liveToast');
            document.getElementById('toastMessage').innerHTML = '<i class="bi bi-check-circle-fill text-success me-2"></i>' + msg;
            const toast = new bootstrap.Toast(toastEl, { delay: 2500 });
            toast.show();
        }

        // Xử lý Share
        document.getElementById('btnShare').addEventListener('click', function() {
            const videoId = '${video.videoId}';
            
            if (navigator.clipboard) {
                navigator.clipboard.writeText(window.location.href);
            }

            fetch('${pageContext.request.contextPath}/video/share?id=' + encodeURIComponent(videoId), {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('shareCountText').innerText = 'Share (' + data.shareCount + ')';
                    showNotification('Đã sao chép liên kết video vào bộ nhớ tạm!');
                }
            })
            .catch(() => {
                showNotification('Đã sao chép liên kết video!');
            });
        });

        // Xử lý Like
        document.getElementById('btnLike').addEventListener('click', function() {
            const videoId = '${video.videoId}';
            const btn = this;

            fetch('${pageContext.request.contextPath}/video/like?id=' + encodeURIComponent(videoId), {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.requireLogin) {
                    showNotification('Vui lòng đăng nhập để lưu vào danh sách yêu thích!');
                } else if (data.success) {
                    document.getElementById('likeCountText').innerText = 'Like (' + data.likeCount + ')';
                    if (data.liked) {
                        btn.classList.add('liked');
                        btn.querySelector('i').className = 'bi bi-heart-fill';
                        showNotification('Đã thêm video vào danh sách yêu thích!');
                    }
                }
            })
            .catch(() => {
                showNotification('Có lỗi xảy ra khi thực hiện thao tác.');
            });
        });

        // Xử lý stepper số lượng và cập nhật tạm tính
        const detailQty = document.getElementById('detailQuantity');
        const detailSubtotal = document.getElementById('detailSubtotal');
        const unitPrice = ${video.price};
        const maxStock = ${video.stock};

        function updateDetailSubtotal() {
            if (!detailQty) return;
            let q = parseInt(detailQty.value) || 1;
            if (q < 1) q = 1;
            if (q > maxStock) q = maxStock;
            detailQty.value = q;
            let sub = q * unitPrice;
            if (detailSubtotal) {
                detailSubtotal.innerText = new Intl.NumberFormat('vi-VN').format(sub) + ' đ';
            }
        }

        const btnMinus = document.getElementById('detailQtyMinus');
        const btnPlus = document.getElementById('detailQtyPlus');
        if (btnMinus) {
            btnMinus.addEventListener('click', function() {
                let q = parseInt(detailQty.value) || 1;
                if (q > 1) {
                    detailQty.value = q - 1;
                    updateDetailSubtotal();
                }
            });
        }
        if (btnPlus) {
            btnPlus.addEventListener('click', function() {
                let q = parseInt(detailQty.value) || 1;
                if (q < maxStock) {
                    detailQty.value = q + 1;
                    updateDetailSubtotal();
                }
            });
        }
        if (detailQty) {
            detailQty.addEventListener('input', updateDetailSubtotal);
        }
    </script>
</body>
</html>
