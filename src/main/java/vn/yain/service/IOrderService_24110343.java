package vn.yain.service;

import java.util.List;
import vn.yain.entity.Order_24110343;
import vn.yain.entity.OrderDetail_24110343;

public interface IOrderService_24110343 {
    boolean createOrder(Order_24110343 order, List<OrderDetail_24110343> details);
    void updateOrderStatus(int orderId, String newStatus);
    Order_24110343 getOrderById(int orderId);
    List<Order_24110343> getAllOrders();
    List<Order_24110343> getOrdersByUser(String username);
    List<Order_24110343> getOrdersByUserAndStatus(String username, String status);
}
