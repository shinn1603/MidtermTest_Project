package vn.yain.service;

import java.util.List;
import vn.yain.dao.IOrderDao_24110343;
import vn.yain.dao.IVideoDao_24110343;
import vn.yain.dao.OrderDaoImpl_24110343;
import vn.yain.dao.VideoDaoImpl_24110343;
import vn.yain.entity.Order_24110343;
import vn.yain.entity.OrderDetail_24110343;
import vn.yain.entity.Video_24110343;

public class OrderServiceImpl_24110343 implements IOrderService_24110343 {

    private IOrderDao_24110343 orderDao = new OrderDaoImpl_24110343();
    private IVideoDao_24110343 videoDao = new VideoDaoImpl_24110343();

    @Override
    public boolean createOrder(Order_24110343 order, List<OrderDetail_24110343> details) {
        try {
            if (details != null && !details.isEmpty()) {
                for (OrderDetail_24110343 d : details) {
                    d.setOrder(order);
                    // Giảm số lượng tồn kho của video tương ứng nếu có
                    if (d.getVideo() != null) {
                        Video_24110343 video = videoDao.findById(d.getVideo().getVideoId());
                        if (video != null && video.getStock() != null) {
                            int newStock = Math.max(0, video.getStock() - d.getQuantity());
                            video.setStock(newStock);
                            videoDao.update(video);
                        }
                    }
                }
                order.setOrderDetails(details);
            }
            orderDao.insert(order);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void updateOrderStatus(int orderId, String newStatus) {
        Order_24110343 order = orderDao.findById(orderId);
        if (order != null) {
            order.setStatus(newStatus);
            orderDao.update(order);
        }
    }

    @Override
    public Order_24110343 getOrderById(int orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<Order_24110343> getAllOrders() {
        return orderDao.findAll();
    }

    @Override
    public List<Order_24110343> getOrdersByUser(String username) {
        return orderDao.findByUsername(username);
    }

    @Override
    public List<Order_24110343> getOrdersByUserAndStatus(String username, String status) {
        if (status == null || status.trim().isEmpty() || "all".equalsIgnoreCase(status.trim())) {
            return orderDao.findByUsername(username);
        }
        return orderDao.findByUsernameAndStatus(username, status.trim());
    }
}
