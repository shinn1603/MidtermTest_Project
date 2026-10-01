package vn.yain.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.yain.entity.Video_24110343;
import vn.yain.service.IVideoService_24110343;
import vn.yain.service.VideoServiceImpl_24110343;

@WebServlet(urlPatterns = { "/video/detail" })
public class VideoDetailController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110343 videoService = new VideoServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        Video_24110343 video = videoService.findById(videoId.trim());
        if (video == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        video.setViews(video.getViews() + 1);
        try {
            videoService.update(video);
        } catch (Exception ignored) {}

        req.setAttribute("video", video);
        req.getRequestDispatcher("/views/web/video-detail.jsp").include(req, resp);
    }
}
