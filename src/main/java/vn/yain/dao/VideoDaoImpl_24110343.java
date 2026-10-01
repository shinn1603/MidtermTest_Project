package vn.yain.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.yain.config.JpaConfig_24110343;
import vn.yain.entity.Video_24110343;

public class VideoDaoImpl_24110343 implements IVideoDao_24110343 {

    @Override
    public List<Video_24110343> findAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Video_24110343> query = em.createNamedQuery("Video_24110343.findAll", Video_24110343.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110343> findAll(int page, int pageSize) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Video_24110343> query = em.createQuery("SELECT v FROM Video_24110343 v ORDER BY v.videoId ASC", Video_24110343.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(v) FROM Video_24110343 v", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public Video_24110343 findById(String videoId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            Video_24110343 video = em.find(Video_24110343.class, videoId);
            if (video != null) {
                video.setLikeCount(countLikes(videoId));
                video.setShareCount(countShares(videoId));
            }
            return video;
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Video_24110343 video) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Video_24110343 video) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String videoId) throws Exception {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video_24110343 video = em.find(Video_24110343.class, videoId);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110343> findByCategoryId(int categoryId, int page, int pageSize) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Video_24110343> query = em.createQuery(
                "SELECT v FROM Video_24110343 v WHERE v.category.categoryId = :catId AND v.active = true ORDER BY v.videoId ASC",
                Video_24110343.class
            );
            query.setParameter("catId", categoryId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            List<Video_24110343> list = query.getResultList();
            for (Video_24110343 v : list) {
                v.setLikeCount(countLikes(v.getVideoId()));
                v.setShareCount(countShares(v.getVideoId()));
            }
            return list;
        } finally {
            em.close();
        }
    }

    @Override
    public long countByCategoryId(int categoryId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Video_24110343 v WHERE v.category.categoryId = :catId AND v.active = true",
                Long.class
            );
            query.setParameter("catId", categoryId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countLikes(String videoId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(f) FROM Favorite_24110343 f WHERE f.video.videoId = :videoId",
                Long.class
            );
            query.setParameter("videoId", videoId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countShares(String videoId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(s) FROM Share_24110343 s WHERE s.video.videoId = :videoId",
                Long.class
            );
            query.setParameter("videoId", videoId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110343> search(String keyword, Integer categoryId, int page, int pageSize) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT v FROM Video_24110343 v WHERE 1=1 ");
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append("AND LOWER(v.title) LIKE :keyword ");
            }
            if (categoryId != null && categoryId > 0) {
                jpql.append("AND v.category.categoryId = :catId ");
            }
            jpql.append("ORDER BY v.videoId ASC");

            TypedQuery<Video_24110343> query = em.createQuery(jpql.toString(), Video_24110343.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("catId", categoryId);
            }
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countSearch(String keyword, Integer categoryId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(v) FROM Video_24110343 v WHERE 1=1 ");
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append("AND LOWER(v.title) LIKE :keyword ");
            }
            if (categoryId != null && categoryId > 0) {
                jpql.append("AND v.category.categoryId = :catId ");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("catId", categoryId);
            }
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long getTotalViews() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COALESCE(SUM(v.views), 0L) FROM Video_24110343 v", Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public long getTotalLikesAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(f) FROM Favorite_24110343 f", Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public long getTotalSharesAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(s) FROM Share_24110343 s", Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }
}
