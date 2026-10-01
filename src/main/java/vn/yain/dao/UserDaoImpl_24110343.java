package vn.yain.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.yain.config.JpaConfig_24110343;
import vn.yain.entity.User_24110343;

public class UserDaoImpl_24110343 implements IUserDao_24110343 {

    @Override
    public User_24110343 findById(String username) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            return em.find(User_24110343.class, username);
        } finally {
            em.close();
        }
    }

    @Override
    public User_24110343 findByEmail(String email) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<User_24110343> query = em.createQuery(
                "SELECT u FROM User_24110343 u WHERE u.email = :email",
                User_24110343.class
            );
            query.setParameter("email", email);
            List<User_24110343> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24110343> findAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<User_24110343> query = em.createNamedQuery("User_24110343.findAll", User_24110343.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(User_24110343 user) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
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
    public void update(User_24110343 user) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
    public void delete(String username) throws Exception {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User_24110343 user = em.find(User_24110343.class, username);
            if (user != null) {
                em.remove(user);
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
    public boolean checkExistUsername(String username) {
        return findById(username) != null;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return findByEmail(email) != null;
    }
}
