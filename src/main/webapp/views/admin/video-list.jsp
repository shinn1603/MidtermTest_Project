<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Dữ Liệu Video</title>
    <style>
        .admin-page-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .admin-page-subtitle {
            font-size: 0.875rem;
            color: #64748b;
            margin-bottom: 0;
        }
        .btn-add-video {
            background-color: #2563eb;
            border-color: #2563eb;
            color: #ffffff;
            font-weight: 600;
            font-size: 14px;
            padding: 8px 18px;
            border-radius: 8px;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        .btn-add-video:hover {
            background-color: #1d4ed8;
            border-color: #1d4ed8;
            color: #ffffff;
        }
        .filter-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 16px 20px;
            margin-bottom: 20px;
        }
        .table-custom {
            margin-bottom: 0;
        }
        .table-custom thead th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 16px;
            border: none;
        }
        .table-custom tbody td {
            padding: 14px 16px;
            vertical-align: middle;
            border-color: #f1f5f9;
            font-size: 14px;
            color: #1e293b;
        }
        .table-custom tbody tr:hover {
            background-color: #f8fafc;
        }
        .badge-status-active {
            background-color: #ecfdf5;
            color: #059669;
            border: 1px solid #a7f3d0;
            font-weight: 600;
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 9999px;
        }
        .badge-status-inactive {
            background-color: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
            font-weight: 600;
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 9999px;
        }
        .badge-category {
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
            color: #334155;
            padding: 3px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-file-video {
            background-color: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            font-size: 11px;
            font-weight: 600;
            padding: 2px 6px;
            border-radius: 4px;
        }
        .btn-action {
            font-size: 12px;
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.15s;
            cursor: pointer;
            border: 1px solid transparent;
            background: transparent;
        }
        .btn-action-view {
            border: 1px solid #cbd5e1;
            color: #475569;
            background: #ffffff;
        }
        .btn-action-view:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        .btn-action-edit {
            border: 1px solid #bfdbfe;
            color: #2563eb;
            background: #eff6ff;
        }
        .btn-action-edit:hover {
            background: #2563eb;
            color: #ffffff;
        }
        .btn-action-delete {
            border: 1px solid #fecaca;
            color: #dc2626;
            background: #fef2f2;
        }
        .btn-action-delete:hover {
            background: #dc2626;
            color: #ffffff;
        }
        .pagination .page-link {
            color: #0f172a;
            border-color: #e2e8f0;
            font-size: 13px;
            font-weight: 500;
            padding: 6px 12px;
        }
        .pagination .page-item.active .page-link {
            background-color: #0f172a;
            border-color: #0f172a;
            color: #ffffff;
        }
        .pagination .page-link:hover {
            background-color: #f1f5f9;
            color: #0f172a;
        }
    </style>
</head>
<body>
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h1 class="admin-page-title">Quản Lý Dữ Liệu Video</h1>
            <p class="admin-page-subtitle">Quản trị danh sách, tìm kiếm và tải lên video</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn-add-video shadow-sm">
                <span>+</span> Thêm Video Mới
            </a>
        </div>
    </div>

    <div class="filter-card shadow-sm">
        <form action="${pageContext.request.contextPath}/admin/videos" method="get" class="row g-3 align-items-center">
            <div class="col-md-5">
                <input type="text" 
                       class="form-control" 
                       name="search" 
                       value="${search}" 
                       placeholder="Tìm kiếm video theo tiêu đề..."
                       style="border-radius: 8px;">
            </div>
            <div class="col-md-4">
                <select class="form-select" name="categoryId" style="border-radius: 8px;">
                    <option value="">-- Tất cả danh mục --</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.categoryId}" ${selectedCategoryId == c.categoryId ? 'selected' : ''}>
                            ${c.categoryname}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 d-flex gap-2">
                <button type="submit" class="btn btn-dark w-100 fw-semibold" style="background-color: #0f172a; border-radius: 8px;">
                    Lọc Dữ Liệu
                </button>
                <c:if test="${not empty search or not empty selectedCategoryId}">
                    <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-outline-secondary" style="border-radius: 8px;" title="Xóa bộ lọc">
                        &times;
                    </a>
                </c:if>
            </div>
        </form>
    </div>

    <c:if test="${not empty msgSuccess}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm py-2 px-3 mb-3" style="background-color: #ecfdf5; color: #065f46; border-left: 4px solid #059669 !important;" role="alert">
            <small class="fw-semibold">${msgSuccess}</small>
            <button type="button" class="btn-close btn-close-sm" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty msgError}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm py-2 px-3 mb-3" style="background-color: #fef2f2; color: #991b1b; border-left: 4px solid #dc2626 !important;" role="alert">
            <small class="fw-semibold">${msgError}</small>
            <button type="button" class="btn-close btn-close-sm" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card border-0 shadow-sm" style="border-radius: 12px; border: 1px solid #e2e8f0; overflow: hidden;">
        <div class="card-header bg-white py-3 px-4 border-bottom" style="border-color: #e2e8f0;">
            <div class="row align-items-center">
                <div class="col">
                    <span class="text-secondary small">
                        Tổng số video: <strong class="text-dark">${totalVideos}</strong> &bull; Hiển thị 6 video / trang
                        <c:if test="${not empty search}">
                            &bull; Từ khóa: <span class="badge bg-secondary-subtle text-secondary">${search}</span>
                        </c:if>
                    </span>
                </div>
                <div class="col-auto">
                    <span class="badge" style="background-color: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; font-weight: 500;">
                        Trang ${currentPage} / ${totalPages}
                    </span>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-custom align-middle">
                <thead>
                    <tr>
                        <th scope="col" style="width: 110px;">Mã Video</th>
                        <th scope="col" style="width: 90px;">Poster</th>
                        <th scope="col">Tiêu Đề & Mô Tả</th>
                        <th scope="col" style="width: 150px;">Danh Mục</th>
                        <th scope="col" class="text-center" style="width: 100px;">Lượt Xem</th>
                        <th scope="col" class="text-center" style="width: 120px;">Trạng Thái</th>
                        <th scope="col" class="text-center" style="width: 170px;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${videos}">
                        <tr>
                            <td>
                                <span class="fw-bold font-monospace" style="color: #0f172a;">${v.videoId}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty v.poster && v.poster.contains('/')}">
                                        <img src="${pageContext.request.contextPath}/uploads/${v.poster}" 
                                             alt="${v.title}" 
                                             class="rounded shadow-sm" 
                                             style="width: 70px; height: 44px; object-fit: cover; border: 1px solid #e2e8f0;">
                                    </c:when>
                                    <c:when test="${not empty v.poster}">
                                        <img src="https://picsum.photos/seed/${v.videoId}/100/60" 
                                             alt="${v.title}" 
                                             class="rounded shadow-sm" 
                                             style="width: 70px; height: 44px; object-fit: cover; border: 1px solid #e2e8f0;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded text-muted text-center" 
                                             style="width: 70px; height: 44px; line-height: 44px; font-size: 10px; background: #f1f5f9; border: 1px solid #e2e8f0;">
                                            No Poster
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="fw-semibold text-dark mb-1" style="max-width: 380px;">
                                    ${v.title}
                                    <c:if test="${not empty v.videoUrl}">
                                        <span class="badge-file-video ms-1" title="Có tệp video MP4 phát trực tiếp">&blacktriangleright; MP4</span>
                                    </c:if>
                                </div>
                                <div class="text-muted text-truncate" style="max-width: 380px; font-size: 12px;">
                                    ${v.description}
                                </div>
                            </td>
                            <td>
                                <span class="badge-category">${v.category != null ? v.category.categoryname : 'Chưa phân loại'}</span>
                            </td>
                            <td class="text-center fw-semibold text-secondary">
                                ${v.views}
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${v.active}">
                                        <span class="badge-status-active">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status-inactive">Tạm ẩn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <div class="d-inline-flex gap-1">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" 
                                       class="btn-action btn-action-view" 
                                       title="Xem ngoài giao diện người dùng">Xem</a>
                                    <a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.videoId}" 
                                       class="btn-action btn-action-edit" 
                                       title="Sửa video">Sửa</a>
                                    <button type="button" 
                                            class="btn-action btn-action-delete btn-open-delete-modal" 
                                            data-video-id="${v.videoId}" 
                                            data-video-title="${v.title}" 
                                            title="Xóa video">Xóa</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty videos}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                Không tìm thấy video nào phù hợp với điều kiện tìm kiếm.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="card-footer bg-white border-top py-2 px-3 d-flex flex-wrap justify-content-between align-items-center gap-2" style="border-color: #e2e8f0;">
            <div class="d-flex flex-wrap align-items-center gap-2" style="font-size: 0.8125rem;">
                <span class="text-secondary small me-1">Thống kê:</span>
                <span class="badge bg-light text-dark border px-2 py-1 fw-normal" title="Tổng số video">
                    Videos: <strong class="text-dark">${kpiTotalVideos}</strong>
                </span>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 fw-normal" title="Tổng lượt xem">
                    Lượt xem: <strong class="text-primary">${kpiTotalViews}</strong>
                </span>
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1 fw-normal" title="Tổng lượt thích">
                    Thích: <strong class="text-danger">${kpiTotalLikes}</strong>
                </span>
                <span class="badge bg-info-subtle text-info-emphasis border border-info-subtle px-2 py-1 fw-normal" title="Tổng lượt chia sẻ">
                    Chia sẻ: <strong class="text-info-emphasis">${kpiTotalShares}</strong>
                </span>
            </div>

            <c:if test="${totalPages > 1}">
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=1&search=${search}&categoryId=${selectedCategoryId}">&laquo;</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${i}&search=${search}&categoryId=${selectedCategoryId}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${totalPages}&search=${search}&categoryId=${selectedCategoryId}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow" style="border-radius: 12px; overflow: hidden;">
                <div class="modal-header bg-danger text-white py-3">
                    <h5 class="modal-title fw-bold" id="deleteModalLabel">Xác Nhận Xóa Video</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4 text-center">
                    <div class="mb-3 text-danger" style="font-size: 3rem; line-height: 1;">&excl;</div>
                    <p class="mb-1 text-dark fs-6">
                        Bạn có chắc chắn muốn xóa video <strong id="deleteVideoTitleText"></strong>?
                    </p>
                    <small class="text-muted d-block">
                        Mã video: <code id="deleteVideoIdText" class="fw-bold"></code> &bull; Hành động này không thể hoàn tác.
                    </small>
                </div>
                <div class="modal-footer bg-light py-2 px-3 border-top d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-outline-secondary px-3" data-bs-dismiss="modal" style="border-radius: 8px;">
                        Hủy Bỏ
                    </button>
                    <a id="btnConfirmDeleteAction" href="#" class="btn btn-danger px-4 fw-semibold" style="border-radius: 8px;">
                        Xác Nhận Xóa
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const deleteButtons = document.querySelectorAll('.btn-open-delete-modal');
            const deleteModalEl = document.getElementById('deleteModal');
            const deleteModal = new bootstrap.Modal(deleteModalEl);

            const titleText = document.getElementById('deleteVideoTitleText');
            const idText = document.getElementById('deleteVideoIdText');
            const confirmBtn = document.getElementById('btnConfirmDeleteAction');

            deleteButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    const videoId = this.getAttribute('data-video-id');
                    const videoTitle = this.getAttribute('data-video-title');

                    titleText.textContent = '"' + videoTitle + '"';
                    idText.textContent = videoId;
                    confirmBtn.href = '${pageContext.request.contextPath}/admin/video/delete?id=' + encodeURIComponent(videoId);

                    deleteModal.show();
                });
            });
        });
    </script>
</body>
</html>
