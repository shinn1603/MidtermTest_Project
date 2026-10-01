package vn.yain.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Orders")
@NamedQuery(name = "Order_24110343.findAll", query = "SELECT o FROM Order_24110343 o ORDER BY o.orderDate DESC")
public class Order_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId")
    private Integer orderId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "OrderDate")
    private Date orderDate = new Date();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "Username")
    private User_24110343 user;

    @org.hibernate.annotations.Nationalized
    @Column(name = "ReceiverName", columnDefinition = "NVARCHAR(100)")
    private String receiverName;

    @Column(name = "ReceiverPhone", length = 20)
    private String receiverPhone;

    @org.hibernate.annotations.Nationalized
    @Column(name = "ReceiverAddress", columnDefinition = "NVARCHAR(255)")
    private String receiverAddress;

    @Column(name = "TotalAmount")
    private Double totalAmount = 0.0;

    @org.hibernate.annotations.Nationalized
    @Column(name = "PaymentMethod", columnDefinition = "NVARCHAR(50)")
    private String paymentMethod = "COD";

    @org.hibernate.annotations.Nationalized
    @Column(name = "Status", columnDefinition = "NVARCHAR(50)")
    private String status = "Đơn hàng mới";

    @org.hibernate.annotations.Nationalized
    @Column(name = "Notes", columnDefinition = "NVARCHAR(500)")
    private String notes;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail_24110343> orderDetails;

    public Order_24110343() {
    }

    public Order_24110343(User_24110343 user, String receiverName, String receiverPhone, String receiverAddress,
                          Double totalAmount, String paymentMethod, String status, String notes) {
        this.user = user;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.receiverAddress = receiverAddress;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.notes = notes;
        this.orderDate = new Date();
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public User_24110343 getUser() {
        return user;
    }

    public void setUser(User_24110343 user) {
        this.user = user;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public Double getTotalAmount() {
        return totalAmount != null ? totalAmount : 0.0;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod != null ? paymentMethod : "COD";
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status != null ? status : "Đơn hàng mới";
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public List<OrderDetail_24110343> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail_24110343> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public String getFormattedTotalAmount() {
        return String.format("%,.0f đ", getTotalAmount());
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        switch (status.trim()) {
            case "Đơn hàng mới":
                return "bg-info text-dark";
            case "Đã xác nhận":
                return "bg-primary text-white";
            case "Chuẩn bị hàng":
                return "bg-warning text-dark";
            case "Vận chuyển":
                return "bg-secondary text-white";
            case "Giao hàng":
                return "bg-light-primary text-primary border border-primary";
            case "Đã giao":
                return "bg-success text-white";
            case "Đơn hàng hủy":
                return "bg-danger text-white";
            case "Đơn hàng hoàn":
                return "bg-dark text-white";
            default:
                return "bg-secondary text-white";
        }
    }
}
