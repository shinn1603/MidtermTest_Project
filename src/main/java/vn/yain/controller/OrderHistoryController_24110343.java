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
            String norm = normalizeStatus(o.getStatus());
            if (statusCounts.containsKey(norm)) {
                statusCounts.put(norm, statusCounts.get(norm) + 1);
            }
        }

        String normSelected = normalizeStatus(selectedStatus);
        List<Order_24110343> displayOrders;
        if ("all".equalsIgnoreCase(selectedStatus)) {
            displayOrders = allOrders;
            normSelected = "all";
        } else {
            final String target = normSelected;
            displayOrders = new java.util.ArrayList<>();
            for (Order_24110343 o : allOrders) {
                if (normalizeStatus(o.getStatus()).equalsIgnoreCase(target)) {
                    displayOrders.add(o);
                }
            }
        }

        req.setAttribute("orders", displayOrders);
        req.setAttribute("selectedStatus", normSelected);
        req.setAttribute("statusCounts", statusCounts);

        req.getRequestDispatcher("/views/web/order-history.jsp").include(req, resp);
    }

    private String normalizeStatus(String st) {
        if (st == null || st.trim().isEmpty()) return "all";
        String s = st.trim().toLowerCase();
        if (s.contains("mới")) return "Đơn hàng mới";
        if (s.contains("xác nhận")) return "Đã xác nhận";
        if (s.contains("chuẩn bị")) return "Chuẩn bị hàng";
        if (s.contains("chuyển") || s.contains("chuyện")) return "Vận chuyển";
        if (s.contains("đã giao")) return "Đã giao";
        if (s.contains("giao")) return "Giao hàng";
        if (s.contains("hủy")) return "Đơn hàng hủy";
        if (s.contains("hoàn")) return "Đơn hàng hoàn";
        return st.trim();
    }
}
