package vn.yain.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.yain.entity.CategoryHomeModel_24110343;
import vn.yain.entity.Category_24110343;
import vn.yain.entity.Video_24110343;
import vn.yain.service.CategoryServiceImpl_24110343;
import vn.yain.service.ICategoryService_24110343;
import vn.yain.service.IVideoService_24110343;
import vn.yain.service.VideoServiceImpl_24110343;

@WebServlet(urlPatterns = { "/home" })
public class HomeController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110343 categoryService = new CategoryServiceImpl_24110343();
    private IVideoService_24110343 videoService = new VideoServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24110343> categories = categoryService.findAll();
        List<CategoryHomeModel_24110343> categoryModels = new ArrayList<>();

        int pageSize = 3;

        for (Category_24110343 cat : categories) {
            int catPage = 1;
            String pParam = req.getParameter("p_" + cat.getCategoryId());
            if (pParam != null) {
                try {
                    catPage = Integer.parseInt(pParam);
                } catch (NumberFormatException ignored) {}
            } else {
                String selectedCatId = req.getParameter("catId");
                String generalPage = req.getParameter("page");
                if (selectedCatId != null && generalPage != null) {
                    try {
                        if (Integer.parseInt(selectedCatId) == cat.getCategoryId()) {
                            catPage = Integer.parseInt(generalPage);
                        }
                    } catch (NumberFormatException ignored) {}
                }
            }

            long totalVideos = categoryService.countVideosByCategoryId(cat.getCategoryId());
            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (catPage < 1) catPage = 1;
            if (catPage > totalPages) catPage = totalPages;

            List<Video_24110343> videos = videoService.findByCategoryId(cat.getCategoryId(), catPage, pageSize);

            CategoryHomeModel_24110343 model = new CategoryHomeModel_24110343(
                cat, totalVideos, catPage, totalPages, videos
            );
            categoryModels.add(model);
        }

        req.setAttribute("categoryModels", categoryModels);
        req.getRequestDispatcher("/views/web/home.jsp").include(req, resp);
    }
}
