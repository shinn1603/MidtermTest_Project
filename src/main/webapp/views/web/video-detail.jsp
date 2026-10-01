<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${video.title} - Chi Tiết Video</title>
    <style>
        .breadcrumb-custom {
            font-size: 13px;
            margin-bottom: 16px;
        }
        .breadcrumb-custom a {
            color: #64748b;
            text-decoration: none;
        }
        .breadcrumb-custom a:hover {
            color: #2563eb;
        }
        .detail-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 28px;
        }
        .media-container {
            border-radius: 10px;
            overflow: hidden;
            background-color: #0f172a;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            min-height: 240px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .media-container img {
            width: 100%;
            height: auto;
            max-height: 320px;
            object-fit: cover;
            display: block;
        }
        .media-container video {
            width: 100%;
            max-height: 320px;
            display: block;
        }
        .detail-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.3;
            margin-bottom: 20px;
        }
        .detail-row {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }
        .detail-label {
            font-weight: 600;
            color: #64748b;
            width: 140px;
            flex-shrink: 0;
        }
        .detail-value {
            font-weight: 500;
            color: #0f172a;
        }
        .category-tag {
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
            color: #334155;
            padding: 3px 10px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
        }
        .stats-badge-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
        .stat-btn {
            font-size: 13px;
            font-weight: 600;
            padding: 8px 18px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
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
            margin-top: 28px;
            padding-top: 24px;
            border-top: 1px solid #e2e8f0;
        }
        .description-title {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
        }
        .description-content {
            color: #475569;
            line-height: 1.7;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <nav class="breadcrumb-custom" aria-label="breadcrumb">
        <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
            <c:if test="${video.category != null}">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">${video.category.categoryname}</a></li>
            </c:if>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">${video.title}</li>
        </ol>
    </nav>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm px-3" style="border-radius: 8px; border-color: #cbd5e1; color: #475569;">
            &larr; Quay lại Trang Chủ
        </a>
    </div>

    <div class="detail-card shadow-sm">
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
                    <div class="text-center mt-2">
                        <small class="badge bg-success-subtle text-success border border-success-subtle">
                            &bull; Video đã sẵn sàng phát trực tiếp
                        </small>
                    </div>
                </c:if>
            </div>

            <div class="col-lg-7">
                <h3 class="detail-title">${video.title}</h3>

                <div class="detail-row">
                    <span class="detail-label">Mã video:</span>
                    <span class="detail-value fw-bold text-primary font-monospace">${video.videoId}</span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Category name:</span>
                    <span class="category-tag">${video.category != null ? video.category.categoryname : 'N/A'}</span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">View:</span>
                    <span class="detail-value">${video.views}</span>
                </div>

                <div class="stats-badge-group">
                    <button type="button" id="btnShare" class="stat-btn btn-interactive-share shadow-sm" title="Bấm để sao chép liên kết chia sẻ video">
                        <span id="shareCountText">Share(${video.shareCount})</span>
                    </button>
                    <button type="button" id="btnLike" class="stat-btn btn-interactive-like shadow-sm" title="Bấm để thích video">
                        <span id="likeCountText">Like(${video.likeCount})</span>
                    </button>
                </div>
            </div>
        </div>

        <div class="description-section">
            <h5 class="description-title">Mô tả video:</h5>
            <div class="description-content">
                <p class="mb-0">
                    ${not empty video.description ? video.description : 'Hiện chưa có nội dung mô tả chi tiết cho video này.'}
                </p>
            </div>
        </div>
    </div>

    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
        <div id="liveToast" class="toast align-items-center text-bg-dark border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="toastMessage">
                    Thông báo
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>

    <script>
        function showNotification(msg) {
            const toastEl = document.getElementById('liveToast');
            document.getElementById('toastMessage').innerText = msg;
            const toast = new bootstrap.Toast(toastEl, { delay: 2500 });
            toast.show();
        }

        // Xử lý Share
        document.getElementById('btnShare').addEventListener('click', function() {
            const videoId = '${video.videoId}';
            
            // Sao chép link vào clipboard
            if (navigator.clipboard) {
                navigator.clipboard.writeText(window.location.href);
            }

            fetch('${pageContext.request.contextPath}/video/share?id=' + encodeURIComponent(videoId), {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('shareCountText').innerText = 'Share(' + data.shareCount + ')';
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
                    document.getElementById('likeCountText').innerText = 'Like(' + data.likeCount + ')';
                    if (data.liked) {
                        btn.classList.add('liked');
                        showNotification('Đã thêm video vào danh sách yêu thích!');
                    } else {
                        btn.classList.remove('liked');
                        showNotification('Đã bỏ yêu thích video!');
                    }
                }
            })
            .catch(() => {
                showNotification('Có lỗi xảy ra khi thực hiện thao tác.');
            });
        });
    </script>
</body>
</html>
