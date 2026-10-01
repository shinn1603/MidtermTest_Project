package vn.yain.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.yain.config.JpaConfig_24110343;
import vn.yain.entity.Category_24110343;

public class CategoryDaoImpl_24110343 implements ICategoryDao_24110343 {

    @Override
    public List<Category_24110343> findAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Category_24110343> query = em.createNamedQuery("Category_24110343.findAll", Category_24110343.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Category_24110343 findById(int id) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            return em.find(Category_24110343.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Category_24110343 category) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
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
    public void update(Category_24110343 category) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
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
    public void delete(int id) throws Exception {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category_24110343 category = em.find(Category_24110343.class, id);
            if (category != null) {
                em.remove(category);
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
    public long countVideosByCategoryId(int categoryId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Video_24110343 v WHERE v.category.categoryId = :categoryId AND v.active = true",
                Long.class
            );
            query.setParameter("categoryId", categoryId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
