package vn.yain.entity;

import java.io.Serializable;
import java.util.List;

public class CategoryHomeModel_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Category_24110343 category;
    private long totalVideos;
    private int currentPage;
    private int totalPages;
    private List<Video_24110343> videos;

    public CategoryHomeModel_24110343() {
    }

    public CategoryHomeModel_24110343(Category_24110343 category, long totalVideos, int currentPage, int totalPages, List<Video_24110343> videos) {
        this.category = category;
        this.totalVideos = totalVideos;
        this.currentPage = currentPage;
        this.totalPages = totalPages;
        this.videos = videos;
    }

    public Category_24110343 getCategory() {
        return category;
    }

    public void setCategory(Category_24110343 category) {
        this.category = category;
    }

    public long getTotalVideos() {
        return totalVideos;
    }

    public void setTotalVideos(long totalVideos) {
        this.totalVideos = totalVideos;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public List<Video_24110343> getVideos() {
        return videos;
    }

    public void setVideos(List<Video_24110343> videos) {
        this.videos = videos;
    }
}
