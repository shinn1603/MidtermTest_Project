package vn.yain.service;

import java.util.List;
import vn.yain.dao.IVideoDao_24110343;
import vn.yain.dao.VideoDaoImpl_24110343;
import vn.yain.entity.Video_24110343;

public class VideoServiceImpl_24110343 implements IVideoService_24110343 {

    private IVideoDao_24110343 videoDao = new VideoDaoImpl_24110343();

    @Override
    public List<Video_24110343> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video_24110343> findAll(int page, int pageSize) {
        return videoDao.findAll(page, pageSize);
    }

    @Override
    public long countAll() {
        return videoDao.countAll();
    }

    @Override
    public Video_24110343 findById(String videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public void insert(Video_24110343 video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video_24110343 video) {
        videoDao.update(video);
    }

    @Override
    public void delete(String videoId) throws Exception {
        videoDao.delete(videoId);
    }

    @Override
    public List<Video_24110343> findByCategoryId(int categoryId, int page, int pageSize) {
        return videoDao.findByCategoryId(categoryId, page, pageSize);
    }

    @Override
    public long countByCategoryId(int categoryId) {
        return videoDao.countByCategoryId(categoryId);
    }

    @Override
    public long countLikes(String videoId) {
        return videoDao.countLikes(videoId);
    }

    @Override
    public long countShares(String videoId) {
        return videoDao.countShares(videoId);
    }

    @Override
    public List<Video_24110343> search(String keyword, Integer categoryId, int page, int pageSize) {
        return videoDao.search(keyword, categoryId, page, pageSize);
    }

    @Override
    public long countSearch(String keyword, Integer categoryId) {
        return videoDao.countSearch(keyword, categoryId);
    }

    @Override
    public long getTotalViews() {
        return videoDao.getTotalViews();
    }

    @Override
    public long getTotalLikesAll() {
        return videoDao.getTotalLikesAll();
    }

    @Override
    public long getTotalSharesAll() {
        return videoDao.getTotalSharesAll();
    }
}
