package vn.yain.controller;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.yain.entity.User_24110343;
import vn.yain.service.IUserService_24110343;
import vn.yain.service.UserServiceImpl_24110343;

@WebServlet(urlPatterns = { "/register" })
public class RegisterController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110343 userService = new UserServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
            return;
        }

        if (userService.checkExistUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại trong hệ thống.");
            req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
            return;
        }

        if (email != null && !email.trim().isEmpty() && userService.checkExistEmail(email)) {
            req.setAttribute("error", "Email này đã được đăng ký.");
            req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
            return;
        }

        Random random = new Random();
        int otpNumber = 100000 + random.nextInt(900000);
        String otpCode = String.valueOf(otpNumber);

        User_24110343 tempUser = new User_24110343();
        tempUser.setUsername(username.trim());
        tempUser.setPassword(password.trim());
        tempUser.setFullname(fullname != null ? fullname.trim() : "");
        tempUser.setEmail(email != null ? email.trim() : "");
        tempUser.setPhone(phone != null ? phone.trim() : "");
        tempUser.setAdmin(false);
        tempUser.setActive(false);
        tempUser.setImages("user.png");

        HttpSession session = req.getSession();
        session.setAttribute("regUser", tempUser);
        session.setAttribute("otpCode", otpCode);

        vn.yain.util.EmailUtil_24110343.sendOtpEmail(tempUser.getEmail(), tempUser.getFullname(), otpCode);
        System.out.println("Đăng ký [" + username + "] - OTP: " + otpCode);

        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
