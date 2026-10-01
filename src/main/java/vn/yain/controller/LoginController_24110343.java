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

@WebServlet(urlPatterns = { "/login" })
public class LoginController_24110343 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110343 userService = new UserServiceImpl_24110343();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User_24110343 currentUser = (User_24110343) session.getAttribute("user");
            if (currentUser.getAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/videos");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
            return;
        }

        if (req.getSession().getAttribute("msgSuccess") != null) {
            req.setAttribute("message", req.getSession().getAttribute("msgSuccess"));
            req.getSession().removeAttribute("msgSuccess");
        }

        req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tên đăng nhập và mật khẩu.");
            req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
            return;
        }

        User_24110343 user = userService.login(username.trim(), password.trim());

        if (user != null) {
            if (!user.getActive()) {
                req.setAttribute("username", username);
                req.setAttribute("error", "Tài khoản chưa được kích hoạt qua mã OTP.");
                req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            if (user.getAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/videos");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("username", username);
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác.");
            req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
        }
    }
}
