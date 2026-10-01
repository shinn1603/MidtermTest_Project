package vn.yain.dao;

import java.util.List;
import vn.yain.entity.Order_24110343;

public interface IOrderDao_24110343 {
    void insert(Order_24110343 order);
    void update(Order_24110343 order);
    Order_24110343 findById(int orderId);
    List<Order_24110343> findAll();
    List<Order_24110343> findByUsername(String username);
    List<Order_24110343> findByUsernameAndStatus(String username, String status);
}
