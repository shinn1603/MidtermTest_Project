package vn.yain.util;

import java.util.Properties;
import java.util.concurrent.CompletableFuture;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil_24110343 {

    private static final String SMTP_HOST = System.getProperty("mail.smtp.host", "smtp.gmail.com");
    private static final String SMTP_PORT = System.getProperty("mail.smtp.port", "587");
    private static final String SENDER_EMAIL = System.getProperty("mail.sender.email", "tho8189@gmail.com");
    private static final String SENDER_PASSWORD = System.getProperty("mail.sender.password", "ifhl dgwc kmse fugk");

    public static CompletableFuture<Boolean> sendOtpEmail(String recipientEmail, String recipientName, String otpCode) {
        return CompletableFuture.supplyAsync(() -> {
            if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
                return false;
            }

            System.out.println("Gửi OTP đến: " + recipientEmail + " | Mã: " + otpCode);

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.connectiontimeout", "5000");
            props.put("mail.smtp.timeout", "5000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD.replace(" ", ""));
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SENDER_EMAIL, "Hệ Thống Video", "UTF-8"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
                message.setSubject("Mã OTP Kích Hoạt Tài Khoản");

                String nameDisplay = (recipientName != null && !recipientName.trim().isEmpty()) ? recipientName : recipientEmail;

                String htmlContent = "<!DOCTYPE html>"
                    + "<html><head><meta charset='UTF-8'></head>"
                    + "<body style='font-family: Arial, sans-serif; background-color: #f8fafc; padding: 24px 0; margin: 0; color: #1e293b;'>"
                    + "  <div style='max-width: 520px; margin: 0 auto; background: #ffffff; border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0; box-shadow: 0 4px 14px rgba(0,0,0,0.06);'>"
                    + "    <div style='background-color: #0f172a; padding: 20px; text-align: center; border-bottom: 2px solid #2563eb;'>"
                    + "      <h2 style='color: #ffffff; margin: 0; font-size: 18px; letter-spacing: 0.5px;'>XÁC THỰC TÀI KHOẢN</h2>"
                    + "    </div>"
                    + "    <div style='padding: 28px 24px;'>"
                    + "      <p style='font-size: 15px; margin-top: 0;'>Xin chào <strong>" + nameDisplay + "</strong>,</p>"
                    + "      <p style='font-size: 14px; color: #475569; line-height: 1.6;'>"
                    + "        Bạn vừa đăng ký tài khoản trên hệ thống. Vui lòng sử dụng mã xác thực OTP bên dưới để kích hoạt tài khoản:"
                    + "      </p>"
                    + "      <div style='background-color: #f1f5f9; border: 2px dashed #2563eb; border-radius: 10px; text-align: center; padding: 18px; margin: 24px 0;'>"
                    + "        <span style='font-size: 11px; color: #64748b; display: block; margin-bottom: 6px; text-transform: uppercase; font-weight: bold; letter-spacing: 1px;'>MÃ OTP</span>"
                    + "        <span style='font-size: 32px; font-weight: bold; color: #2563eb; letter-spacing: 8px; font-family: monospace;'>" + otpCode + "</span>"
                    + "      </div>"
                    + "      <p style='font-size: 13px; color: #64748b; line-height: 1.6; margin-bottom: 0;'>"
                    + "        &bull; Mã có hiệu lực trong vòng 5 phút.<br>"
                    + "        &bull; Vui lòng không chia sẻ mã này cho người khác."
                    + "      </p>"
                    + "    </div>"
                    + "    <div style='background-color: #f8fafc; padding: 14px; text-align: center; border-top: 1px solid #e2e8f0; font-size: 12px; color: #94a3b8;'>"
                    + "      Email tự động từ hệ thống. Vui lòng không trả lời thư này."
                    + "    </div>"
                    + "  </div>"
                    + "</body></html>";

                message.setContent(htmlContent, "text/html; charset=UTF-8");
                Transport.send(message);
                System.out.println("Đã gửi email thành công đến: " + recipientEmail);
                return true;
            } catch (Exception e) {
                System.err.println("Lỗi gửi email đến " + recipientEmail + ": " + e.getMessage());
                return false;
            }
        });
    }
}
