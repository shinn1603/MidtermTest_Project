package vn.yain.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.yain.entity.Category_24110343;
import vn.yain.entity.User_24110343;
import vn.yain.entity.Video_24110343;
import vn.yain.service.CategoryServiceImpl_24110343;
import vn.yain.service.ICategoryService_24110343;
import vn.yain.service.IVideoService_24110343;
import vn.yain.service.VideoServiceImpl_24110343;

@WebServlet(urlPatterns = { "/admin/videos", "/admin/video/add", "/admin/video/edit", "/admin/video/delete" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 100,
    maxRequestSize = 1024 * 1024 * 120
)
public class VideoAdminController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110343 videoService = new VideoServiceImpl_24110343();
    private ICategoryService_24110343 categoryService = new CategoryServiceImpl_24110343();

    private boolean checkAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        User_24110343 user = (User_24110343) session.getAttribute("user");
        if (!user.getAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    private String saveUploadedFile(Part part, String subDir, HttpServletRequest req) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        String submitted = part.getSubmittedFileName();
        if (submitted == null || submitted.trim().isEmpty()) {
            return null;
        }
        String baseName = Paths.get(submitted).getFileName().toString();
        String ext = "";
        int dot = baseName.lastIndexOf('.');
        if (dot >= 0) {
            ext = baseName.substring(dot);
        }
        String cleanName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 6) + ext;

        String realPath = req.getServletContext().getRealPath("/uploads/" + subDir);
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        part.write(realPath + File.separator + cleanName);
        return subDir + "/" + cleanName;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;

        String path = req.getServletPath();

        if ("/admin/video/add".equals(path)) {
            List<Category_24110343> categories = categoryService.findAll();
            req.setAttribute("categories", categories);

            long count = videoService.countAll() + 1;
            String nextId = String.format("VID%02d", count);
            while (videoService.findById(nextId) != null) {
                count++;
                nextId = String.format("VID%02d", count);
            }
            req.setAttribute("suggestedVideoId", nextId);

            req.getRequestDispatcher("/views/admin/video-form.jsp").include(req, resp);
            return;
        }

        if ("/admin/video/edit".equals(path)) {
            String videoId = req.getParameter("id");
            if (videoId != null && !videoId.trim().isEmpty()) {
                Video_24110343 video = videoService.findById(videoId.trim());
                req.setAttribute("video", video);
            }
            List<Category_24110343> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/video-form.jsp").include(req, resp);
            return;
        }

        if ("/admin/video/delete".equals(path)) {
            String videoId = req.getParameter("id");
            if (videoId != null && !videoId.trim().isEmpty()) {
                try {
                    videoService.delete(videoId.trim());
                    req.getSession().setAttribute("msgSuccess", "Xóa video " + videoId + " thành công!");
                } catch (Exception e) {
                    req.getSession().setAttribute("msgError", "Không thể xóa video: " + e.getMessage());
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
            return;
        }

        int pageSize = 6;
        int currentPage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException ignored) {}
        }

        String search = req.getParameter("search");
        String categoryIdParam = req.getParameter("categoryId");
        Integer categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam.trim());
            } catch (NumberFormatException ignored) {}
        }

        long totalVideos = videoService.countSearch(search, categoryId);
        int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<Video_24110343> videos = videoService.search(search, categoryId, currentPage, pageSize);
        List<Category_24110343> categories = categoryService.findAll();

        if (req.getSession().getAttribute("msgSuccess") != null) {
            req.setAttribute("msgSuccess", req.getSession().getAttribute("msgSuccess"));
            req.getSession().removeAttribute("msgSuccess");
        }
        if (req.getSession().getAttribute("msgError") != null) {
            req.setAttribute("msgError", req.getSession().getAttribute("msgError"));
            req.getSession().removeAttribute("msgError");
        }

        req.setAttribute("videos", videos);
        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("search", search != null ? search : "");
        req.setAttribute("selectedCategoryId", categoryId);

        req.setAttribute("kpiTotalVideos", videoService.countAll());
        req.setAttribute("kpiTotalViews", videoService.getTotalViews());
        req.setAttribute("kpiTotalLikes", videoService.getTotalLikesAll());
        req.setAttribute("kpiTotalShares", videoService.getTotalSharesAll());

        req.getRequestDispatcher("/views/admin/video-list.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();

        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String poster = req.getParameter("poster");
        String description = req.getParameter("description");
        String activeStr = req.getParameter("active");
        String categoryIdStr = req.getParameter("categoryId");
        String viewsStr = req.getParameter("views");

        Part posterFile = null;
        Part videoFile = null;
        try {
            posterFile = req.getPart("posterFile");
        } catch (Exception ignored) {}
        try {
            videoFile = req.getPart("videoFile");
        } catch (Exception ignored) {}

        String uploadedPoster = saveUploadedFile(posterFile, "posters", req);
        String uploadedVideo = saveUploadedFile(videoFile, "videos", req);

        boolean active = "true".equalsIgnoreCase(activeStr) || "on".equalsIgnoreCase(activeStr);
        int views = 0;
        try {
            if (viewsStr != null && !viewsStr.trim().isEmpty()) {
                views = Integer.parseInt(viewsStr.trim());
            }
        } catch (NumberFormatException ignored) {}

        Category_24110343 category = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                category = categoryService.findById(Integer.parseInt(categoryIdStr.trim()));
            } catch (NumberFormatException ignored) {}
        }

        if ("/admin/video/add".equals(path)) {
            if (videoId == null || videoId.trim().isEmpty() || title == null || title.trim().isEmpty()) {
                req.setAttribute("msgError", "Vui lòng nhập đầy đủ Mã video và Tiêu đề.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/video-form.jsp").include(req, resp);
                return;
            }

            if (videoService.findById(videoId.trim()) != null) {
                req.setAttribute("msgError", "Mã video này đã tồn tại trong hệ thống.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/video-form.jsp").include(req, resp);
                return;
            }

            Video_24110343 newVideo = new Video_24110343();
            newVideo.setVideoId(videoId.trim());
            newVideo.setTitle(title.trim());

            if (uploadedPoster != null) {
                newVideo.setPoster(uploadedPoster);
            } else if (poster != null && !poster.trim().isEmpty()) {
                newVideo.setPoster(poster.trim());
            } else {
                newVideo.setPoster("default_poster.jpg");
            }

            if (uploadedVideo != null) {
                newVideo.setVideoUrl(uploadedVideo);
            }

            newVideo.setDescription(description != null ? description.trim() : "");
            newVideo.setActive(active);
            newVideo.setViews(views);
            newVideo.setCategory(category);

            videoService.insert(newVideo);
            req.getSession().setAttribute("msgSuccess", "Thêm video mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
            return;
        }

        if ("/admin/video/edit".equals(path)) {
            Video_24110343 existingVideo = videoService.findById(videoId.trim());
            if (existingVideo != null) {
                existingVideo.setTitle(title.trim());

                if (uploadedPoster != null) {
                    existingVideo.setPoster(uploadedPoster);
                } else if (poster != null && !poster.trim().isEmpty()) {
                    existingVideo.setPoster(poster.trim());
                }

                if (uploadedVideo != null) {
                    existingVideo.setVideoUrl(uploadedVideo);
                }

                existingVideo.setDescription(description != null ? description.trim() : "");
                existingVideo.setActive(active);
                existingVideo.setViews(views);
                existingVideo.setCategory(category);

                videoService.update(existingVideo);
                req.getSession().setAttribute("msgSuccess", "Cập nhật video thành công!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }
}
