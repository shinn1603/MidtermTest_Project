<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${not empty video ? 'Cập Nhật Video' : 'Thêm Video Mới'}</title>
    <style>
        .preview-box {
            width: 100%;
            height: 180px;
            border-radius: 8px;
            background-color: #f8fafc;
            border: 2px dashed #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        .preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-9 col-md-11">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h1 class="h4 fw-bold text-dark mb-1">
                        ${not empty video ? 'Cập Nhật Thông Tin Video' : 'Thêm Video Mới'}
                    </h1>
                    <p class="text-muted small mb-0">Hỗ trợ nhập thông tin, xem trước hình poster và tải lên file video MP4</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-outline-secondary btn-sm px-3" style="border-radius: 8px;">
                    &larr; Quay lại danh sách
                </a>
            </div>

            <div class="card border-0 shadow-sm" style="border-radius: 12px; border: 1px solid #e2e8f0;">
                <div class="card-body p-4">
                    <c:if test="${not empty msgError}">
                        <div class="alert alert-danger py-2 small mb-4" role="alert">
                            ${msgError}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}${not empty video ? '/admin/video/edit' : '/admin/video/add'}" 
                          method="post" 
                          enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="videoId" class="form-label fw-semibold small text-secondary">
                                    Mã Video <span class="text-danger">*</span>
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="videoId" 
                                       name="videoId" 
                                       value="${not empty video ? video.videoId : (not empty suggestedVideoId ? suggestedVideoId : '')}" 
                                       ${not empty video ? 'readonly' : 'required'} 
                                       placeholder="VD: VID15, VID16..."
                                       style="border-radius: 8px;">
                                <c:if test="${not empty video}">
                                    <small class="text-muted" style="font-size: 11px;">Mã video cố định không thể sửa</small>
                                </c:if>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="categoryId" class="form-label fw-semibold small text-secondary">Danh Mục</label>
                                <select class="form-select" id="categoryId" name="categoryId" style="border-radius: 8px;">
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.categoryId}" ${video.category != null && video.category.categoryId == c.categoryId ? 'selected' : ''}>
                                            ${c.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="title" class="form-label fw-semibold small text-secondary">
                                Tiêu Đề Video <span class="text-danger">*</span>
                            </label>
                            <input type="text" 
                                   class="form-control" 
                                   id="title" 
                                   name="title" 
                                   value="${video.title}" 
                                   required 
                                   placeholder="Nhập tiêu đề video..."
                                   style="border-radius: 8px;">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-7">
                                <label class="form-label fw-semibold small text-secondary">Hình Poster</label>
                                
                                <div class="mb-2">
                                    <label for="posterFile" class="form-label small text-muted mb-1">Cách 1: Tải ảnh từ máy tính</label>
                                    <input type="file" 
                                           class="form-control form-control-sm" 
                                           id="posterFile" 
                                           name="posterFile" 
                                           accept="image/*"
                                           style="border-radius: 8px;">
                                </div>

                                <div>
                                    <label for="poster" class="form-label small text-muted mb-1">Cách 2: Hoặc nhập tên ảnh / URL ảnh</label>
                                    <input type="text" 
                                           class="form-control form-control-sm" 
                                           id="poster" 
                                           name="poster" 
                                           value="${video.poster}" 
                                           placeholder="VD: poster1.jpg hoặc https://..."
                                           style="border-radius: 8px;">
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold small text-secondary">Xem trước Poster</label>
                                <div class="preview-box" id="posterPreviewContainer">
                                    <c:choose>
                                        <c:when test="${not empty video.poster && video.poster.contains('/')}">
                                            <img id="posterPreviewImg" src="${pageContext.request.contextPath}/uploads/${video.poster}" alt="Preview">
                                        </c:when>
                                        <c:when test="${not empty video.poster}">
                                            <img id="posterPreviewImg" src="https://picsum.photos/seed/${video.videoId}/300/180" alt="Preview">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="posterPreviewImg" src="" alt="Preview" style="display: none;">
                                            <span id="previewPlaceholder" class="text-muted small">Chưa có ảnh poster</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-7">
                                <label for="videoFile" class="form-label fw-semibold small text-secondary">
                                    Tải File Video Lên Hệ Thống (.mp4, .webm)
                                </label>
                                <input type="file" 
                                       class="form-control form-control-sm" 
                                       id="videoFile" 
                                       name="videoFile" 
                                       accept="video/mp4,video/webm,video/*"
                                       style="border-radius: 8px;">
                                <small class="text-muted" style="font-size: 11px;">
                                    Tệp video tải lên sẽ được lưu trữ và có thể phát trực tiếp trên trang chi tiết video.
                                </small>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold small text-secondary">Trạng thái file Video</label>
                                <div class="p-2 rounded bg-light border" style="font-size: 12px;">
                                    <c:choose>
                                        <c:when test="${not empty video.videoUrl}">
                                            <span class="text-success fw-semibold">&check; Đã có video tải lên:</span><br>
                                            <span class="text-truncate d-block text-secondary font-monospace">${video.videoUrl}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có file video tải lên. Video sẽ hiển thị ảnh poster mẫu.</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="views" class="form-label fw-semibold small text-secondary">Lượt Xem Ban Đầu</label>
                                <input type="number" 
                                       class="form-control" 
                                       id="views" 
                                       name="views" 
                                       value="${not empty video ? video.views : 0}"
                                       min="0"
                                       style="border-radius: 8px;">
                            </div>
                            <div class="col-md-6 d-flex align-items-center mt-3 mt-md-0">
                                <div class="form-check mt-3">
                                    <input type="checkbox" 
                                           class="form-check-input" 
                                           id="active" 
                                           name="active" 
                                           value="true" 
                                           ${empty video || video.active ? 'checked' : ''}>
                                    <label class="form-check-label fw-semibold small text-secondary" for="active">
                                        Kích hoạt hiển thị cho người xem (Active)
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label fw-semibold small text-secondary">Mô Tả Chi Tiết</label>
                            <textarea class="form-control" 
                                      id="description" 
                                      name="description" 
                                      rows="3" 
                                      placeholder="Nhập mô tả nội dung video..."
                                      style="border-radius: 8px;">${video.description}</textarea>
                        </div>

                        <div class="d-flex justify-content-end gap-2 pt-2 border-top" style="border-color: #f1f5f9;">
                            <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-outline-secondary px-4" style="border-radius: 8px;">
                                Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold" style="background-color: #0f172a; border-color: #0f172a; border-radius: 8px;">
                                ${not empty video ? 'Cập Nhật Video' : 'Lưu Video Mới'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        const fileInput = document.getElementById('posterFile');
        const textInput = document.getElementById('poster');
        const img = document.getElementById('posterPreviewImg');
        const placeholder = document.getElementById('previewPlaceholder');

        if (fileInput) {
            fileInput.addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(evt) {
                        img.src = evt.target.result;
                        img.style.display = 'block';
                        if (placeholder) placeholder.style.display = 'none';
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        if (textInput) {
            textInput.addEventListener('input', function(e) {
                const val = e.target.value.trim();
                if (val && (val.startsWith('http://') || val.startsWith('https://'))) {
                    img.src = val;
                    img.style.display = 'block';
                    if (placeholder) placeholder.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
