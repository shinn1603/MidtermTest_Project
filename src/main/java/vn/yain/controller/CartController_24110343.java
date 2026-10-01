package vn.yain.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.entity.CartItem_24110343;
import vn.yain.entity.Video_24110343;
import vn.yain.service.IVideoService_24110343;
import vn.yain.service.VideoServiceImpl_24110343;

@WebServlet(urlPatterns = { "/cart", "/cart/add", "/cart/update", "/cart/delete", "/cart/clear" })
public class CartController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110343 videoService = new VideoServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/cart/delete".equals(path)) {
            handleDelete(req, resp);
        } else if ("/cart/clear".equals(path)) {
            handleClear(req, resp);
        } else if ("/cart/add".equals(path)) {
            handleAdd(req, resp);
        } else {
            handleViewCart(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/cart/add".equals(path)) {
            handleAdd(req, resp);
        } else if ("/cart/update".equals(path)) {
            handleUpdate(req, resp);
        } else if ("/cart/delete".equals(path)) {
            handleDelete(req, resp);
        } else if ("/cart/clear".equals(path)) {
            handleClear(req, resp);
        } else {
            handleViewCart(req, resp);
        }
    }

    private void handleViewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");

        double totalAmount = 0.0;
        int totalQuantity = 0;

        if (cart != null) {
            for (CartItem_24110343 item : cart.values()) {
                totalAmount += item.getSubTotal();
                totalQuantity += item.getQuantity();
            }
        }

        req.setAttribute("cartItems", cart != null ? cart.values() : null);
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("formattedTotalAmount", String.format("%,.0f đ", totalAmount));
        req.setAttribute("totalQuantity", totalQuantity);

        // Flash message từ session
        if (session.getAttribute("cartMsg") != null) {
            req.setAttribute("cartMsg", session.getAttribute("cartMsg"));
            session.removeAttribute("cartMsg");
        }
        if (session.getAttribute("cartWarning") != null) {
            req.setAttribute("cartWarning", session.getAttribute("cartWarning"));
            session.removeAttribute("cartWarning");
        }

        req.getRequestDispatcher("/views/web/cart.jsp").include(req, resp);
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("videoId");
        String qtyParam = req.getParameter("quantity");
        String sizeParam = req.getParameter("size");
        String noteParam = req.getParameter("note");
        String redirect = req.getParameter("redirect"); // "cart", "detail", "home", "checkout"

        int quantity = 1;
        try {
            if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                quantity = Integer.parseInt(qtyParam.trim());
            }
        } catch (NumberFormatException e) {
            quantity = 1;
        }

        if (quantity < 1) {
            quantity = 1;
        }

        String chosenSize = (sizeParam != null && !sizeParam.trim().isEmpty()) ? sizeParam.trim() : "Size M (1080p FHD)";
        String chosenNote = (noteParam != null) ? noteParam.trim() : "";

        if (videoId != null && !videoId.trim().isEmpty()) {
            Video_24110343 video = videoService.findById(videoId.trim());
            if (video != null) {
                HttpSession session = req.getSession();
                @SuppressWarnings("unchecked")
                Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new LinkedHashMap<>();
                }

                int maxLimit = (video.getStock() != null && video.getStock() > 0) ? video.getStock() : 50;

                String cleanSize = chosenSize.replaceAll("[^a-zA-Z0-9]", "");
                String cartKey = video.getVideoId() + "_" + cleanSize;

                CartItem_24110343 existing = cart.get(cartKey);
                if (existing != null) {
                    int newQty = existing.getQuantity() + quantity;
                    if (newQty > maxLimit) {
                        existing.setQuantity(maxLimit);
                        session.setAttribute("cartWarning", "Số lượng sản phẩm \"" + video.getTitle() + " (" + chosenSize + ")\" đã đạt giới hạn tối đa tồn kho (" + maxLimit + ").");
                    } else {
                        existing.setQuantity(newQty);
                        session.setAttribute("cartMsg", "Đã cập nhật số lượng \"" + video.getTitle() + " (" + chosenSize + ")\" trong giỏ hàng.");
                    }
                    if (!chosenNote.isEmpty()) {
                        existing.setNote(chosenNote);
                    }
                } else {
                    if (quantity > maxLimit) {
                        quantity = maxLimit;
                        session.setAttribute("cartWarning", "Số lượng yêu cầu vượt quá tồn kho. Đã thêm tối đa " + maxLimit + " sản phẩm vào giỏ.");
                    } else {
                        session.setAttribute("cartMsg", "Đã thêm \"" + video.getTitle() + " (" + chosenSize + ")\" vào giỏ hàng.");
                    }
                    CartItem_24110343 newItem = new CartItem_24110343(video, quantity, video.getPrice(), chosenSize, chosenNote);
                    cart.put(cartKey, newItem);
                }

                updateSessionCart(session, cart);
            }
        }

        if ("detail".equalsIgnoreCase(redirect) && videoId != null) {
            resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + videoId);
        } else if ("home".equalsIgnoreCase(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/home#products");
        } else if ("checkout".equalsIgnoreCase(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/checkout");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String cartKey = req.getParameter("cartKey");
        if (cartKey == null || cartKey.trim().isEmpty()) {
            cartKey = req.getParameter("videoId");
        }
        String qtyParam = req.getParameter("quantity");
        String action = req.getParameter("action"); // "plus", "minus", "set"

        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");

        if (cart != null && cartKey != null && cart.containsKey(cartKey)) {
            CartItem_24110343 item = cart.get(cartKey);
            int currentQty = item.getQuantity();
            int maxLimit = (item.getVideo() != null && item.getVideo().getStock() != null && item.getVideo().getStock() > 0)
                    ? item.getVideo().getStock() : 50;

            if ("plus".equalsIgnoreCase(action)) {
                if (currentQty + 1 <= maxLimit) {
                    item.setQuantity(currentQty + 1);
                    session.setAttribute("cartMsg", "Đã tăng số lượng sản phẩm.");
                } else {
                    session.setAttribute("cartWarning", "Số lượng sản phẩm đã đạt giới hạn tối đa tồn kho (" + maxLimit + ").");
                }
            } else if ("minus".equalsIgnoreCase(action)) {
                if (currentQty - 1 >= 1) {
                    item.setQuantity(currentQty - 1);
                    session.setAttribute("cartMsg", "Đã giảm số lượng sản phẩm.");
                } else {
                    // Nếu giảm dưới 1 thì xóa khỏi giỏ
                    cart.remove(cartKey);
                    session.setAttribute("cartMsg", "Đã xóa sản phẩm khỏi giỏ hàng.");
                }
            } else {
                // Set số lượng trực tiếp
                try {
                    int newQty = Integer.parseInt(qtyParam);
                    if (newQty <= 0) {
                        cart.remove(cartKey);
                        session.setAttribute("cartMsg", "Đã xóa sản phẩm khỏi giỏ hàng do số lượng <= 0.");
                    } else if (newQty > maxLimit) {
                        item.setQuantity(maxLimit);
                        session.setAttribute("cartWarning", "Số lượng vượt quá tồn kho. Đã tự động điều chỉnh về mức tối đa: " + maxLimit);
                    } else {
                        item.setQuantity(newQty);
                        session.setAttribute("cartMsg", "Đã cập nhật số lượng thành công.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("cartWarning", "Số lượng nhập không hợp lệ.");
                }
            }

            updateSessionCart(session, cart);
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String cartKey = req.getParameter("cartKey");
        if (cartKey == null || cartKey.trim().isEmpty()) {
            cartKey = req.getParameter("videoId");
        }
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110343> cart = (Map<String, CartItem_24110343>) session.getAttribute("cart");

        if (cart != null && cartKey != null) {
            CartItem_24110343 removed = cart.remove(cartKey);
            if (removed != null) {
                session.setAttribute("cartMsg", "Đã xóa sản phẩm \"" + removed.getVideo().getTitle() + " (" + removed.getSize() + ")\" khỏi giỏ hàng.");
            }
            updateSessionCart(session, cart);
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleClear(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("cart");
        session.setAttribute("cartCount", 0);
        session.setAttribute("cartMsg", "Đã xóa sạch toàn bộ sản phẩm trong giỏ hàng.");

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void updateSessionCart(HttpSession session, Map<String, CartItem_24110343> cart) {
        int totalQty = 0;
        for (CartItem_24110343 item : cart.values()) {
            totalQty += item.getQuantity();
        }
        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", totalQty);
    }
}
