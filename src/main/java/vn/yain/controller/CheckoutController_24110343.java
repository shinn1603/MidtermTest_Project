package vn.yain.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.entity.CartItem_24110343;
import vn.yain.entity.OrderDetail_24110343;
import vn.yain.entity.Order_24110343;
import vn.yain.entity.User_24110343;
import vn.yain.service.IOrderService_24110343;
import vn.yain.service.OrderServiceImpl_24110343;

@WebServlet(urlPatterns = { "/checkout", "/order/success" })
public class CheckoutController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOrderService_24110343 orderService = new OrderServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/order/success".equals(path)) {
            handleOrderSuccess(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        User_24110343 user = (User_24110343) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập tài khoản trước khi tiến hành thanh toán đơn hàng.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống. Vui lòng chọn sản phẩm để thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double totalAmount = 0.0;
        int totalQuantity = 0;
        for (CartItem_24110343 item : cart.values()) {
            totalAmount += item.getSubTotal();
            totalQuantity += item.getQuantity();
        }

        req.setAttribute("user", user);
        req.setAttribute("cartItems", cart.values());
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("formattedTotalAmount", String.format("%,.0f đ", totalAmount));
        req.setAttribute("totalQuantity", totalQuantity);

        req.getRequestDispatcher("/views/web/checkout.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User_24110343 user = (User_24110343) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String receiverAddress = req.getParameter("receiverAddress");
        String notes = req.getParameter("notes");
        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        if (receiverName == null || receiverName.trim().isEmpty() ||
            receiverPhone == null || receiverPhone.trim().isEmpty() ||
            receiverAddress == null || receiverAddress.trim().isEmpty()) {

            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin: Người nhận, Số điện thoại và Địa chỉ giao hàng.");
            
            double totalAmount = 0.0;
            int totalQuantity = 0;
            for (CartItem_24110343 item : cart.values()) {
                totalAmount += item.getSubTotal();
                totalQuantity += item.getQuantity();
            }
            req.setAttribute("user", user);
            req.setAttribute("cartItems", cart.values());
            req.setAttribute("totalAmount", totalAmount);
            req.setAttribute("formattedTotalAmount", String.format("%,.0f đ", totalAmount));
            req.setAttribute("totalQuantity", totalQuantity);
            req.setAttribute("receiverName", receiverName);
            req.setAttribute("receiverPhone", receiverPhone);
            req.setAttribute("receiverAddress", receiverAddress);
            req.setAttribute("notes", notes);

            req.getRequestDispatcher("/views/web/checkout.jsp").include(req, resp);
            return;
        }

        double totalAmount = 0.0;
        for (CartItem_24110343 item : cart.values()) {
            totalAmount += item.getSubTotal();
        }

        Order_24110343 order = new Order_24110343();
        order.setUser(user);
        order.setReceiverName(receiverName.trim());
        order.setReceiverPhone(receiverPhone.trim());
        order.setReceiverAddress(receiverAddress.trim());
        order.setPaymentMethod(paymentMethod.trim());
        order.setStatus("Đơn hàng mới");
        order.setTotalAmount(totalAmount);
        order.setNotes(notes != null ? notes.trim() : "");
        order.setOrderDate(new Date());

        List<OrderDetail_24110343> details = new ArrayList<>();
        for (CartItem_24110343 item : cart.values()) {
            OrderDetail_24110343 d = new OrderDetail_24110343();
            d.setVideo(item.getVideo());
            d.setQuantity(item.getQuantity());
            d.setPrice(item.getPrice());
            d.setSize(item.getSize());
            details.add(d);
        }

        boolean success = orderService.createOrder(order, details);

        if (success) {
            // Xóa sạch giỏ hàng sau khi đặt thành công
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);
            session.setAttribute("completedOrder", order);
            resp.sendRedirect(req.getContextPath() + "/order/success");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình tạo đơn hàng. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/web/checkout.jsp").include(req, resp);
        }
    }

    private void handleOrderSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Order_24110343 order = (Order_24110343) session.getAttribute("completedOrder");
        if (order != null) {
            req.setAttribute("order", order);
            session.removeAttribute("completedOrder");
        }
        req.getRequestDispatcher("/views/web/order-success.jsp").include(req, resp);
    }
}
