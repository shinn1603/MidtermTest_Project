<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Video Theo Danh Mục</title>
    <style>
        /* Category Section */
        .category-block {
            margin-bottom: 44px;
        }
        .category-heading-wrap {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 14px;
            margin-bottom: 22px;
            border-bottom: 2px solid #e2e8f0;
        }
        .category-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: -0.01em;
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0;
        }
        .category-title-accent {
            width: 4px;
            height: 22px;
            background-color: #2563eb;
            border-radius: 2px;
            display: inline-block;
        }
        .category-badge-count {
            font-size: 0.8rem;
            font-weight: 600;
            background-color: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            padding: 2px 10px;
            border-radius: 9999px;
        }

        /* Video Card */
        .video-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }
        .video-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 28px -6px rgba(15, 23, 42, 0.1);
            border-color: #cbd5e1;
        }
        .poster-container {
            width: 100%;
            height: 195px;
            background-color: #0f172a;
            overflow: hidden;
            position: relative;
        }
        .poster-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.35s ease;
        }
        .video-card:hover .poster-container img {
            transform: scale(1.05);
        }
        .poster-badge-category {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(15, 23, 42, 0.75);
            backdrop-filter: blur(8px);
            color: #ffffff;
            font-size: 11px;
            font-weight: 600;
            padding: 3px 9px;
            border-radius: 6px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            z-index: 2;
        }
        .poster-play-overlay {
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(15, 23, 42, 0.35);
            opacity: 0;
            transition: opacity 0.25s ease;
            z-index: 1;
        }
        .video-card:hover .poster-play-overlay {
            opacity: 1;
        }
        .play-circle-btn {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: rgba(37, 99, 235, 0.9);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.3);
            transition: transform 0.2s;
        }
        .video-card:hover .play-circle-btn {
            transform: scale(1.08);
        }

        /* Card Body */
        .video-card-body {
            padding: 16px 18px 18px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .video-title {
            font-weight: 700;
            font-size: 15px;
            color: #0f172a;
            text-decoration: none;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 42px;
            line-height: 1.4;
            margin-bottom: 12px;
            transition: color 0.15s;
        }
        .video-title:hover {
            color: #2563eb;
        }
        .meta-tags-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 12px;
        }
        .meta-pill {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            color: #475569;
            padding: 2px 7px;
            border-radius: 6px;
            font-weight: 500;
        }
        .stock-pill-ok {
            background-color: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #059669;
            padding: 2px 7px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
        }
        .stock-pill-low {
            background-color: #fffbeb;
            border: 1px solid #fde68a;
            color: #d97706;
            padding: 2px 7px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
        }

        /* Price & Action Row */
        .price-action-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 12px;
            margin-top: auto;
            border-top: 1px solid #f1f5f9;
        }
        .product-price {
            font-size: 16px;
            font-weight: 800;
            color: #dc2626;
            letter-spacing: -0.01em;
        }
        .btn-add-cart {
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.2s ease;
        }
        .btn-add-cart:hover {
            background-color: #1d4ed8;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.25);
        }
        .btn-add-cart:active {
            transform: translateY(0);
        }

        /* Card Footer */
        .video-card-footer {
            padding-top: 10px;
            margin-top: 10px;
            border-top: 1px dashed #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
        }
        .stat-indicator {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            color: #64748b;
            font-weight: 500;
        }

        /* Pagination */
        .pagination .page-link {
            color: #0f172a;
            border-color: #e2e8f0;
            font-size: 13px;
            font-weight: 600;
            padding: 7px 14px;
            border-radius: 8px;
            margin: 0 2px;
            transition: all 0.15s ease;
        }
        .pagination .page-item.active .page-link {
            background-color: #0f172a;
            border-color: #0f172a;
            color: #ffffff;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.15);
        }
        .pagination .page-link:hover {
            background-color: #f1f5f9;
            color: #2563eb;
            border-color: #cbd5e1;
        }

        /* Customize Modal Options */
        .size-option-label {
            display: block;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            padding: 10px 14px;
            cursor: pointer;
            transition: all 0.15s ease;
            background-color: #ffffff;
        }
        .btn-check:checked + .size-option-label {
            border-color: #2563eb;
            background-color: #eff6ff;
            color: #1d4ed8;
            font-weight: 700;
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
        }
        .stepper-box {
            display: inline-flex;
            align-items: center;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            overflow: hidden;
            background: #ffffff;
        }
        .stepper-btn {
            border: none;
            background: #f8fafc;
            color: #334155;
            width: 36px;
            height: 36px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .stepper-btn:hover {
            background: #e2e8f0;
        }
        .stepper-input {
            width: 50px;
            height: 36px;
            border: none;
            text-align: center;
            font-weight: 700;
            font-size: 14px;
            outline: none;
        }
    </style>
</head>
<body>

    <!-- Products Section (Đã bỏ hero-banner) -->
    <div id="products" class="pt-2">
        <c:forEach var="item" items="${categoryModels}">
            <div class="category-block">
                <div class="category-heading-wrap">
                    <h2 class="category-title">
                        <span class="category-title-accent"></span>
                        <span>${item.category.categoryname}</span>
                        <span class="category-badge-count ms-1">${item.totalVideos} video</span>
                    </h2>
                </div>

                <div class="row g-4">
                    <c:forEach var="v" items="${item.videos}">
                        <div class="col-md-4 col-sm-6">
                            <div class="video-card">
                                <div class="poster-container">
                                    <span class="poster-badge-category">
                                        <i class="bi bi-folder2 me-1"></i>${item.category.categoryname}
                                    </span>
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="d-block w-100 h-100 position-relative">
                                        <c:choose>
                                            <c:when test="${not empty v.poster && v.poster.contains('/')}">
                                                <img src="${pageContext.request.contextPath}/uploads/${v.poster}" alt="${v.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://picsum.photos/seed/${v.videoId}/400/225" alt="${v.title}">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="poster-play-overlay">
                                            <div class="play-circle-btn">
                                                <i class="bi bi-play-fill ms-1"></i>
                                            </div>
                                        </div>
                                    </a>
                                </div>

                                <div class="video-card-body">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title" title="${v.title}">
                                        ${v.title}
                                    </a>
                                    
                                    <div class="meta-tags-row">
                                        <span class="meta-pill font-monospace">#${v.videoId}</span>
                                        <c:choose>
                                            <c:when test="${v.stock > 5}">
                                                <span class="stock-pill-ok">
                                                    <i class="bi bi-box-seam me-1"></i>Còn ${v.stock}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-pill-low">
                                                    <i class="bi bi-exclamation-triangle me-1"></i>Chỉ còn ${v.stock}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="price-action-row">
                                        <div>
                                            <div class="text-muted" style="font-size: 11px; font-weight: 500;">Giá bán:</div>
                                            <div class="product-price">${v.formattedPrice}</div>
                                        </div>
                                        <!-- Nút mở Modal tùy chỉnh thông số (Size, Số lượng, Ghi chú) -->
                                        <button type="button" 
                                                class="btn-add-cart btn-open-customize"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#customizeCartModal"
                                                data-id="${v.videoId}"
                                                data-title="${v.title}"
                                                data-price="${v.price}"
                                                data-formattedprice="${v.formattedPrice}"
                                                data-stock="${v.stock}"
                                                data-category="${item.category.categoryname}"
                                                data-poster="<c:choose><c:when test='${not empty v.poster && v.poster.contains(\"/\") }'>${pageContext.request.contextPath}/uploads/${v.poster}</c:when><c:otherwise>https://picsum.photos/seed/${v.videoId}/400/225</c:otherwise></c:choose>">
                                            <i class="bi bi-sliders me-1"></i>
                                            <span>Thêm giỏ</span>
                                        </button>
                                    </div>

                                    <div class="video-card-footer">
                                        <span class="stat-indicator" title="Lượt xem">
                                            <i class="bi bi-eye text-secondary"></i>
                                            <span>${v.views} xem</span>
                                        </span>
                                        <div class="d-flex align-items-center gap-3">
                                            <span class="stat-indicator" title="Lượt chia sẻ">
                                                <i class="bi bi-share text-secondary"></i>
                                                <span>${v.shareCount}</span>
                                            </span>
                                            <span class="stat-indicator" title="Lượt yêu thích">
                                                <i class="bi bi-heart text-danger"></i>
                                                <span>${v.likeCount}</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty item.videos}">
                        <div class="col-12">
                            <div class="text-center py-5 text-muted bg-white rounded-4 border" style="border-color: #e2e8f0;">
                                <i class="bi bi-inbox fs-2 text-secondary d-block mb-2"></i>
                                <span>Chưa có video nào trong danh mục này.</span>
                            </div>
                        </div>
                    </c:if>
                </div>

                <c:if test="${item.totalPages > 1}">
                    <div class="d-flex justify-content-center mt-4">
                        <nav aria-label="Phân trang ${item.category.categoryname}">
                            <ul class="pagination pagination-sm mb-0">
                                <li class="page-item ${item.currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=1" title="Trang đầu">
                                        <i class="bi bi-chevron-double-left"></i>
                                    </a>
                                </li>
                                <c:forEach var="p" begin="1" end="${item.totalPages}">
                                    <li class="page-item ${item.currentPage == p ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=${p}">${p}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${item.currentPage == item.totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=${item.totalPages}" title="Trang cuối">
                                        <i class="bi bi-chevron-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>

    <!-- MODAL TÙY CHỈNH THÔNG SỐ (SIZE, SỐ LƯỢNG, GHI CHÚ) TRƯỚC KHI THÊM VÀO GIỎ -->
    <div class="modal fade" id="customizeCartModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold text-dark d-flex align-items-center gap-2" id="modalLabel">
                        <i class="bi bi-sliders text-primary"></i>
                        <span>Tùy Chỉnh Thông Số Đặt Mua</span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>

                <form id="modalAddToCartForm" action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="videoId" id="modalVideoId" value="">
                    <input type="hidden" name="redirect" id="modalRedirect" value="cart">

                    <div class="modal-body pt-3">
                        <!-- Tóm tắt sản phẩm -->
                        <div class="d-flex gap-3 align-items-center p-3 bg-light rounded-3 mb-3 border">
                            <img id="modalPoster" src="" alt="Poster" style="width: 72px; height: 50px; object-fit: cover; border-radius: 8px;">
                            <div class="flex-grow-1 overflow-hidden">
                                <h6 class="fw-bold text-dark text-truncate mb-1" id="modalTitle">Tên video</h6>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="text-danger fw-bold fs-6" id="modalFormattedPrice">0 đ</span>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle font-monospace" id="modalStockBadge">Còn 0</span>
                                </div>
                            </div>
                        </div>

                        <!-- 1. Tùy chỉnh Size / Phiên bản -->
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark small mb-2 d-flex align-items-center gap-1">
                                <i class="bi bi-aspect-ratio text-primary"></i>
                                <span>Chọn Size / Độ phân giải:</span>
                            </label>
                            <div class="row g-2">
                                <div class="col-6">
                                    <input type="radio" class="btn-check" name="size" id="sizeS" value="Size S (720p HD)">
                                    <label class="size-option-label" for="sizeS">
                                        <div class="fw-bold">Size S</div>
                                        <div class="small text-muted">720p HD Tiêu chuẩn</div>
                                    </label>
                                </div>
                                <div class="col-6">
                                    <input type="radio" class="btn-check" name="size" id="sizeM" value="Size M (1080p FHD)" checked>
                                    <label class="size-option-label" for="sizeM">
                                        <div class="fw-bold">Size M <span class="badge bg-primary text-white" style="font-size: 9px;">Chuẩn</span></div>
                                        <div class="small text-muted">1080p Full HD</div>
                                    </label>
                                </div>
                                <div class="col-6">
                                    <input type="radio" class="btn-check" name="size" id="sizeL" value="Size L (2K QHD)">
                                    <label class="size-option-label" for="sizeL">
                                        <div class="fw-bold">Size L</div>
                                        <div class="small text-muted">2K QHD Sắc nét</div>
                                    </label>
                                </div>
                                <div class="col-6">
                                    <input type="radio" class="btn-check" name="size" id="sizeXL" value="Size XL (4K UHD)">
                                    <label class="size-option-label" for="sizeXL">
                                        <div class="fw-bold">Size XL</div>
                                        <div class="small text-muted">4K UHD Cao cấp</div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- 2. Tùy chỉnh Số lượng -->
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark small mb-2 d-flex align-items-center gap-1">
                                <i class="bi bi-123 text-primary"></i>
                                <span>Chọn số lượng đặt mua:</span>
                            </label>
                            <div class="d-flex align-items-center justify-content-between p-2 bg-light rounded-3 border">
                                <div class="stepper-box">
                                    <button type="button" class="stepper-btn" id="modalQtyMinus">
                                        <i class="bi bi-dash-lg"></i>
                                    </button>
                                    <input type="number" id="modalQuantity" name="quantity" class="stepper-input" value="1" min="1" max="50">
                                    <button type="button" class="stepper-btn" id="modalQtyPlus">
                                        <i class="bi bi-plus-lg"></i>
                                    </button>
                                </div>
                                <div class="text-end">
                                    <span class="small text-muted">Tạm tính:</span>
                                    <div class="fw-bold text-danger fs-6" id="modalSubtotal">0 đ</div>
                                </div>
                            </div>
                            <small class="text-muted mt-1 d-block" id="modalStockHelp">Số lượng tối đa phụ thuộc vào tồn kho của sản phẩm.</small>
                        </div>

                        <!-- 3. Ghi chú yêu cầu tùy chỉnh (Tùy chọn) -->
                        <div class="mb-2">
                            <label for="modalNote" class="form-label fw-semibold text-secondary small mb-1">
                                <i class="bi bi-chat-left-text me-1"></i> Ghi chú đơn / Yêu cầu tùy chỉnh (tùy chọn):
                            </label>
                            <input type="text" class="form-control form-control-sm" id="modalNote" name="note" placeholder="Ví dụ: Gửi link qua mail, đóng gói quà tặng, v.v.">
                        </div>
                    </div>

                    <div class="modal-footer border-top-0 pt-0 d-flex gap-2">
                        <button type="button" class="btn btn-light fw-medium px-3" data-bs-dismiss="modal" style="border-radius: 8px;">Đóng</button>
                        <button type="submit" class="btn btn-outline-primary fw-semibold px-3 d-inline-flex align-items-center gap-1" style="border-radius: 8px;" onclick="document.getElementById('modalRedirect').value='cart';">
                            <i class="bi bi-cart-plus"></i>
                            <span>Thêm vào giỏ</span>
                        </button>
                        <button type="submit" class="btn btn-danger fw-semibold px-3 d-inline-flex align-items-center gap-1" style="border-radius: 8px;" onclick="document.getElementById('modalRedirect').value='checkout';">
                            <i class="bi bi-lightning-charge-fill"></i>
                            <span>Mua ngay</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Script điều khiển Modal Tùy chỉnh thông số -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            let currentPrice = 0;
            let currentMaxStock = 50;

            const modalVideoId = document.getElementById('modalVideoId');
            const modalTitle = document.getElementById('modalTitle');
            const modalPoster = document.getElementById('modalPoster');
            const modalFormattedPrice = document.getElementById('modalFormattedPrice');
            const modalStockBadge = document.getElementById('modalStockBadge');
            const modalQuantity = document.getElementById('modalQuantity');
            const modalSubtotal = document.getElementById('modalSubtotal');
            const modalStockHelp = document.getElementById('modalStockHelp');
            const modalNote = document.getElementById('modalNote');

            function updateSubtotal() {
                let qty = parseInt(modalQuantity.value) || 1;
                if (qty < 1) qty = 1;
                if (qty > currentMaxStock) qty = currentMaxStock;
                modalQuantity.value = qty;

                let subtotal = qty * currentPrice;
                modalSubtotal.innerText = new Intl.NumberFormat('vi-VN').format(subtotal) + ' đ';
            }

            document.querySelectorAll('.btn-open-customize').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.getAttribute('data-id');
                    const title = this.getAttribute('data-title');
                    const price = parseFloat(this.getAttribute('data-price')) || 0;
                    const formattedPrice = this.getAttribute('data-formattedprice');
                    const stock = parseInt(this.getAttribute('data-stock')) || 50;
                    const poster = this.getAttribute('data-poster');

                    currentPrice = price;
                    currentMaxStock = stock > 0 ? stock : 50;

                    modalVideoId.value = id;
                    modalTitle.innerText = title;
                    modalPoster.src = poster;
                    modalFormattedPrice.innerText = formattedPrice;
                    modalStockBadge.innerText = 'Còn ' + currentMaxStock + ' có sẵn';
                    modalStockHelp.innerText = 'Số lượng tối đa cho phép: ' + currentMaxStock + ' sản phẩm.';
                    modalQuantity.value = 1;
                    modalQuantity.max = currentMaxStock;
                    modalNote.value = '';

                    // Reset radio size về M
                    document.getElementById('sizeM').checked = true;

                    updateSubtotal();
                });
            });

            document.getElementById('modalQtyMinus').addEventListener('click', function() {
                let qty = parseInt(modalQuantity.value) || 1;
                if (qty > 1) {
                    modalQuantity.value = qty - 1;
                    updateSubtotal();
                }
            });

            document.getElementById('modalQtyPlus').addEventListener('click', function() {
                let qty = parseInt(modalQuantity.value) || 1;
                if (qty < currentMaxStock) {
                    modalQuantity.value = qty + 1;
                    updateSubtotal();
                }
            });

            modalQuantity.addEventListener('input', updateSubtotal);
        });
    </script>
</body>
</html>
