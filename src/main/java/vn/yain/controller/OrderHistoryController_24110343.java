package vn.yain.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.entity.Order_24110343;
import vn.yain.entity.User_24110343;
import vn.yain.service.IOrderService_24110343;
import vn.yain.service.OrderServiceImpl_24110343;

@WebServlet(urlPatterns = { "/order-history" })
public class OrderHistoryController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOrderService_24110343 orderService = new OrderServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110343 user = (User_24110343) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để xem lịch sử đơn hàng của bạn.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String selectedStatus = req.getParameter("status");
        if (selectedStatus == null || selectedStatus.trim().isEmpty()) {
            selectedStatus = "all";
        } else {
            selectedStatus = selectedStatus.trim();
        }

        // Lấy tất cả đơn hàng của user để đếm số lượng theo từng trạng thái
        List<Order_24110343> allOrders = orderService.getOrdersByUser(user.getUsername());
        Map<String, Integer> statusCounts = new HashMap<>();
        statusCounts.put("all", allOrders.size());
        statusCounts.put("Đơn hàng mới", 0);
        statusCounts.put("Đã xác nhận", 0);
        statusCounts.put("Chuẩn bị hàng", 0);
        statusCounts.put("Vận chuyển", 0);
        statusCounts.put("Giao hàng", 0);
        statusCounts.put("Đã giao", 0);
        statusCounts.put("Đơn hàng hủy", 0);
        statusCounts.put("Đơn hàng hoàn", 0);

        for (Order_24110343 o : allOrders) {
            String st = o.getStatus() != null ? o.getStatus().trim() : "";
            if (statusCounts.containsKey(st)) {
                statusCounts.put(st, statusCounts.get(st) + 1);
            }
        }

        // Lấy danh sách đơn hàng tương ứng theo bộ lọc
        List<Order_24110343> displayOrders;
        if ("all".equalsIgnoreCase(selectedStatus)) {
            displayOrders = allOrders;
        } else {
            displayOrders = orderService.getOrdersByUserAndStatus(user.getUsername(), selectedStatus);
        }

        req.setAttribute("orders", displayOrders);
        req.setAttribute("selectedStatus", selectedStatus);
        req.setAttribute("statusCounts", statusCounts);

        req.getRequestDispatcher("/views/web/order-history.jsp").include(req, resp);
    }
}
