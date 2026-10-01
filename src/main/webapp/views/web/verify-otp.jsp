<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác thực mã OTP</title>
</head>
<body>
    <div class="row justify-content-center mt-4">
        <div class="col-md-5 col-lg-4">
            <div class="card border-0 shadow-sm" style="border-radius: 12px; border: 1px solid #e2e8f0;">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <h4 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h4>
                        <p class="text-muted small">Nhập mã gồm 6 chữ số để kích hoạt tài khoản</p>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small" role="alert">
                            ${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <div class="p-3 mb-4 rounded-3 text-center" style="background-color: #f1f5f9; border: 1px solid #e2e8f0;">
                        <span class="text-secondary small d-block mb-1">
                            Mã OTP xác thực đã được gửi đến: <strong class="text-dark">${sessionScope.regUser.email}</strong>
                        </span>
                        <div class="fw-bold" style="font-size: 26px; letter-spacing: 6px; color: #2563eb; font-family: monospace;">
                            ${demoOtp}
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <div class="mb-3">
                            <label for="otp" class="form-label fw-semibold small text-secondary">Nhập mã OTP</label>
                            <input type="text" 
                                   class="form-control text-center fw-bold" 
                                   id="otp" 
                                   name="otp" 
                                   maxlength="6" 
                                   required 
                                   autofocus 
                                   placeholder="000000"
                                   style="font-size: 20px; letter-spacing: 4px; border-radius: 8px;">
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-dark py-2 fw-semibold" style="background-color: #0f172a; border-radius: 8px;">
                                Kích Hoạt Tài Khoản
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3 pt-2 border-top" style="border-color: #f1f5f9;">
                        <span class="small text-muted">Chưa nhận được mã?</span>
                        <a href="${pageContext.request.contextPath}/verify-otp?action=resend" class="small fw-semibold text-decoration-none text-primary ms-1">
                            Gửi lại mã OTP
                        </a>
                    </div>

                    <div class="text-center mt-2">
                        <a href="${pageContext.request.contextPath}/register" class="small text-muted text-decoration-none">
                            &larr; Quay lại trang Đăng ký
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
