<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Video Theo Danh Mục</title>
    <style>
        .category-heading {
            font-size: 1.25rem;
            font-weight: 700;
            color: #0f172a;
            padding-bottom: 12px;
            margin-bottom: 24px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .category-badge-count {
            font-size: 0.85rem;
            font-weight: 600;
            background-color: #f1f5f9;
            color: #2563eb;
            border: 1px solid #cbd5e1;
            padding: 3px 12px;
            border-radius: 9999px;
        }
        .video-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .video-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px -5px rgba(15, 23, 42, 0.08);
            border-color: #cbd5e1;
        }
        .poster-container {
            width: 100%;
            height: 190px;
            background-color: #f1f5f9;
            overflow: hidden;
            position: relative;
        }
        .poster-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .video-card:hover .poster-container img {
            transform: scale(1.03);
        }
        .video-card-body {
            padding: 16px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .video-title {
            font-weight: 600;
            font-size: 15px;
            color: #0f172a;
            text-decoration: none;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 44px;
            line-height: 1.4;
            margin-bottom: 10px;
        }
        .video-title:hover {
            color: #2563eb;
        }
        .meta-line {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .meta-label {
            font-weight: 500;
            color: #475569;
        }
        .meta-value {
            font-weight: 600;
            color: #0f172a;
        }
        .category-pill {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            color: #334155;
            padding: 2px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }
        .video-card-footer {
            padding-top: 12px;
            margin-top: auto;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .count-pill {
            font-size: 12px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .count-share {
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
        }
        .count-like {
            background-color: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
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
    <div id="products">
        <c:forEach var="item" items="${categoryModels}">
            <div class="category-block mb-5">
                <div class="category-heading">
                    <div>
                        <span>${item.category.categoryname}</span>
                        <span class="category-badge-count ms-2">(${item.totalVideos})</span>
                    </div>
                </div>

                <div class="row g-4">
                    <c:forEach var="v" items="${item.videos}">
                        <div class="col-md-4">
                            <div class="video-card shadow-sm">
                                <div class="poster-container">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}">
                                        <c:choose>
                                            <c:when test="${not empty v.poster && v.poster.contains('/')}">
                                                <img src="${pageContext.request.contextPath}/uploads/${v.poster}" alt="${v.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://picsum.photos/seed/${v.videoId}/400/225" alt="${v.title}">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                                <div class="video-card-body">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title">
                                        ${v.title}
                                    </a>
                                    
                                    <div class="meta-line">
                                        <span class="meta-label">Mã video:</span>
                                        <span class="meta-value">${v.videoId}</span>
                                    </div>
                                    <div class="meta-line">
                                        <span class="meta-label">Category name:</span>
                                        <span class="category-pill">${v.category != null ? v.category.categoryname : 'N/A'}</span>
                                    </div>
                                    <div class="meta-line">
                                        <span class="meta-label">View:</span>
                                        <span class="meta-value">${v.views}</span>
                                    </div>

                                    <div class="video-card-footer">
                                        <span class="count-pill count-share">Share(${v.shareCount})</span>
                                        <span class="count-pill count-like">Like(${v.likeCount})</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty item.videos}">
                        <div class="col-12">
                            <div class="text-center py-5 text-muted bg-white rounded-3 border" style="border-color: #e2e8f0;">
                                Chưa có video nào trong danh mục này.
                            </div>
                        </div>
                    </c:if>
                </div>

                <c:if test="${item.totalPages > 1}">
                    <div class="d-flex justify-content-center mt-4">
                        <nav>
                            <ul class="pagination pagination-sm mb-0">
                                <li class="page-item ${item.currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=1">&lt;&lt;</a>
                                </li>
                                <c:forEach var="p" begin="1" end="${item.totalPages}">
                                    <li class="page-item ${item.currentPage == p ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=${p}">${p}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${item.currentPage == item.totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/home?p_${item.category.categoryId}=${item.totalPages}">&gt;&gt;</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
</body>
</html>
