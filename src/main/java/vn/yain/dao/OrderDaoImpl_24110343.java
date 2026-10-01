package vn.yain.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.yain.config.JpaConfig_24110343;
import vn.yain.entity.Order_24110343;

public class OrderDaoImpl_24110343 implements IOrderDao_24110343 {

    @Override
    public void insert(Order_24110343 order) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(order);
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
    public void update(Order_24110343 order) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(order);
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
    public Order_24110343 findById(int orderId) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Order_24110343> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24110343 o LEFT JOIN FETCH o.orderDetails WHERE o.orderId = :orderId",
                Order_24110343.class
            );
            query.setParameter("orderId", orderId);
            List<Order_24110343> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24110343> findAll() {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Order_24110343> query = em.createNamedQuery("Order_24110343.findAll", Order_24110343.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24110343> findByUsername(String username) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Order_24110343> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24110343 o LEFT JOIN FETCH o.orderDetails od LEFT JOIN FETCH od.video WHERE o.user.username = :username ORDER BY o.orderDate DESC",
                Order_24110343.class
            );
            query.setParameter("username", username);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24110343> findByUsernameAndStatus(String username, String status) {
        EntityManager em = JpaConfig_24110343.getEntityManager();
        try {
            TypedQuery<Order_24110343> query = em.createQuery(
                "SELECT DISTINCT o FROM Order_24110343 o LEFT JOIN FETCH o.orderDetails od LEFT JOIN FETCH od.video WHERE o.user.username = :username AND o.status = :status ORDER BY o.orderDate DESC",
                Order_24110343.class
            );
            query.setParameter("username", username);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
