<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
</head>
<body>
    <div class="row justify-content-center mt-4">
        <div class="col-md-5 col-lg-4">
            <div class="card border-0 shadow-sm" style="border-radius: 12px; border: 1px solid #e2e8f0;">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <h4 class="fw-bold text-dark mb-1">Đăng Nhập</h4>
                        <p class="text-muted small">Nhập thông tin tài khoản để tiếp tục</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small" role="alert">
                            ${message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold small text-secondary">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username" value="${username}" required autofocus placeholder="username">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label fw-semibold small text-secondary">Mật khẩu</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" required placeholder="••••••••" style="border-right: none;">
                                <button class="btn btn-outline-secondary toggle-password" type="button" data-target="password" style="border-left: none; background-color: #fff; border-color: #dee2e6; color: #64748b;" title="Hiện/ẩn mật khẩu">
                                    <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-dark py-2 fw-semibold" style="background-color: #0f172a; border-radius: 8px;">
                                Đăng Nhập
                            </button>
                        </div>
                    </form>

                    <script>
                        document.querySelectorAll('.toggle-password').forEach(btn => {
                            btn.addEventListener('click', function() {
                                const targetId = this.getAttribute('data-target');
                                const input = document.getElementById(targetId);
                                if (input.type === 'password') {
                                    input.type = 'text';
                                    this.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7.029 7.029 0 0 0 2.79-.588zM5.21 3.088A7.028 7.028 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474L5.21 3.089z"/><path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829l-2.83-2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171-4.87-12 12 .708.708 12-12-.707-.707z"/></svg>';
                                } else {
                                    input.type = 'password';
                                    this.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/><path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/></svg>';
                                }
                            });
                        });
                    </script>

                    <div class="text-center mt-3">
                        <span class="small text-muted">Chưa có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/register" class="small fw-semibold text-decoration-none ms-1">Đăng ký ngay</a>
                    </div>

                    <div class="p-3 bg-light rounded-3 mt-4 small border">
                        <div class="text-secondary fw-semibold mb-1">Tài khoản kiểm thử nhanh:</div>
                        <div>• Quản trị: <code>admin</code> / <code>123</code></div>
                        <div>• Người dùng: <code>tho24110343</code> / <code>123</code></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
