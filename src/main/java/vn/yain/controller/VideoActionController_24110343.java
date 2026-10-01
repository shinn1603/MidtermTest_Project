package vn.yain.controller;

import java.io.IOException;
import java.util.Date;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.config.JpaConfig_24110343;
import vn.yain.entity.Favorite_24110343;
import vn.yain.entity.Share_24110343;
import vn.yain.entity.User_24110343;
import vn.yain.entity.Video_24110343;
import vn.yain.service.IVideoService_24110343;
import vn.yain.service.VideoServiceImpl_24110343;

@WebServlet(urlPatterns = { "/video/like", "/video/share" })
public class VideoActionController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110343 videoService = new VideoServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();
        String videoId = req.getParameter("id");

        if (videoId == null || videoId.trim().isEmpty()) {
            resp.getWriter().write("{\"success\":false,\"message\":\"Thiếu mã video\"}");
            return;
        }

        videoId = videoId.trim();
        Video_24110343 video = videoService.findById(videoId);
        if (video == null) {
            resp.getWriter().write("{\"success\":false,\"message\":\"Video không tồn tại\"}");
            return;
        }

        HttpSession session = req.getSession(false);
        User_24110343 currentUser = (session != null) ? (User_24110343) session.getAttribute("user") : null;

        if ("/video/like".equals(path)) {
            if (currentUser == null) {
                resp.getWriter().write("{\"success\":false,\"requireLogin\":true,\"message\":\"Vui lòng đăng nhập để thích video này!\"}");
                return;
            }

            EntityManager em = JpaConfig_24110343.getEntityManager();
            EntityTransaction trans = em.getTransaction();
            boolean liked = false;
            try {
                trans.begin();
                TypedQuery<Favorite_24110343> query = em.createQuery(
                    "SELECT f FROM Favorite_24110343 f WHERE f.video.videoId = :vid AND f.user.username = :uname",
                    Favorite_24110343.class
                );
                query.setParameter("vid", videoId);
                query.setParameter("uname", currentUser.getUsername());
                var list = query.getResultList();

                if (!list.isEmpty()) {
                    em.remove(list.get(0));
                    liked = false;
                } else {
                    Favorite_24110343 fav = new Favorite_24110343();
                    fav.setLikedDate(new Date());
                    fav.setVideo(em.getReference(Video_24110343.class, videoId));
                    fav.setUser(em.getReference(User_24110343.class, currentUser.getUsername()));
                    em.persist(fav);
                    liked = true;
                }
                trans.commit();
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
                resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
                return;
            } finally {
                em.close();
            }

            long newLikeCount = videoService.countLikes(videoId);
            resp.getWriter().write(String.format("{\"success\":true,\"liked\":%b,\"likeCount\":%d}", liked, newLikeCount));
            return;
        }

        if ("/video/share".equals(path)) {
            EntityManager em = JpaConfig_24110343.getEntityManager();
            EntityTransaction trans = em.getTransaction();
            try {
                trans.begin();
                Share_24110343 share = new Share_24110343();
                share.setSharedDate(new Date());
                share.setVideo(em.getReference(Video_24110343.class, videoId));
                if (currentUser != null) {
                    share.setUser(em.getReference(User_24110343.class, currentUser.getUsername()));
                    share.setEmails(currentUser.getEmail());
                } else {
                    share.setEmails("guest@domain.com");
                }
                em.persist(share);
                trans.commit();
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
                resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
                return;
            } finally {
                em.close();
            }

            long newShareCount = videoService.countShares(videoId);
            resp.getWriter().write(String.format("{\"success\":true,\"shareCount\":%d}", newShareCount));
        }
    }
}
