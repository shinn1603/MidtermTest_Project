package vn.yain.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.entity.User_24110343;
import vn.yain.service.IUserService_24110343;
import vn.yain.service.UserServiceImpl_24110343;

@WebServlet(urlPatterns = { "/verify-otp" })
public class VerifyOtpController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110343 userService = new UserServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110343 regUser = (User_24110343) session.getAttribute("regUser");
        String otpCode = (String) session.getAttribute("otpCode");

        if (regUser == null || otpCode == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        String action = req.getParameter("action");
        if ("resend".equalsIgnoreCase(action)) {
            String newOtp = String.valueOf((int) ((Math.random() * 900000) + 100000));
            session.setAttribute("otpCode", newOtp);
            otpCode = newOtp;
            
            System.out.println("Gửi lại OTP [" + regUser.getUsername() + "]: " + newOtp);
            vn.yain.util.EmailUtil_24110343.sendOtpEmail(regUser.getEmail(), regUser.getFullname(), newOtp);
            
            req.setAttribute("message", "Mã OTP mới đã được gửi đến email " + regUser.getEmail() + "!");
        }

        req.setAttribute("demoOtp", otpCode);
        req.getRequestDispatcher("/views/web/verify-otp.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User_24110343 regUser = (User_24110343) session.getAttribute("regUser");
        String otpSession = (String) session.getAttribute("otpCode");

        if (regUser == null || otpSession == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        String otpInput = req.getParameter("otp");

        if (otpInput != null && otpInput.trim().equals(otpSession)) {
            regUser.setActive(true);
            userService.register(regUser);

            session.removeAttribute("regUser");
            session.removeAttribute("otpCode");

            req.getSession().setAttribute("msgSuccess", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng nhập lại.");
            req.setAttribute("demoOtp", otpSession);
            req.getRequestDispatcher("/views/web/verify-otp.jsp").include(req, resp);
        }
    }
}
