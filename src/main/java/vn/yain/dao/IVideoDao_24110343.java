package vn.yain.dao;

import java.util.List;
import vn.yain.entity.Video_24110343;

public interface IVideoDao_24110343 {
    List<Video_24110343> findAll();
    List<Video_24110343> findAll(int page, int pageSize);
    long countAll();
    Video_24110343 findById(String videoId);
    void insert(Video_24110343 video);
    void update(Video_24110343 video);
    void delete(String videoId) throws Exception;
    
    List<Video_24110343> findByCategoryId(int categoryId, int page, int pageSize);
    long countByCategoryId(int categoryId);
    
    long countLikes(String videoId);
    long countShares(String videoId);

    List<Video_24110343> search(String keyword, Integer categoryId, int page, int pageSize);
    long countSearch(String keyword, Integer categoryId);

    long getTotalViews();
    long getTotalLikesAll();
    long getTotalSharesAll();
}
