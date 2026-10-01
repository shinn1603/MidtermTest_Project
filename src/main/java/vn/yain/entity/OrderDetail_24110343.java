package vn.yain.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "OrderDetails")
@NamedQuery(name = "OrderDetail_24110343.findAll", query = "SELECT od FROM OrderDetail_24110343 od")
public class OrderDetail_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderDetailId")
    private Integer orderDetailId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OrderId")
    private Order_24110343 order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "VideoId")
    private Video_24110343 video;

    @Column(name = "Quantity")
    private Integer quantity = 1;

    @Column(name = "Price")
    private Double price = 0.0;

    @org.hibernate.annotations.Nationalized
    @Column(name = "Size", columnDefinition = "NVARCHAR(50)")
    private String size = "Size M";

    public OrderDetail_24110343() {
    }

    public OrderDetail_24110343(Order_24110343 order, Video_24110343 video, Integer quantity, Double price) {
        this.order = order;
        this.video = video;
        this.quantity = quantity;
        this.price = price;
        this.size = "Size M";
    }

    public OrderDetail_24110343(Order_24110343 order, Video_24110343 video, Integer quantity, Double price, String size) {
        this.order = order;
        this.video = video;
        this.quantity = quantity;
        this.price = price;
        this.size = size != null && !size.trim().isEmpty() ? size : "Size M";
    }

    public Integer getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(Integer orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public Order_24110343 getOrder() {
        return order;
    }

    public void setOrder(Order_24110343 order) {
        this.order = order;
    }

    public Video_24110343 getVideo() {
        return video;
    }

    public void setVideo(Video_24110343 video) {
        this.video = video;
    }

    public Integer getQuantity() {
        return quantity != null ? quantity : 1;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price != null ? price : 0.0;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getSubTotal() {
        return getPrice() * getQuantity();
    }

    public String getSize() {
        return size != null && !size.trim().isEmpty() ? size : "Size M";
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", getPrice());
    }

    public String getFormattedSubTotal() {
        return String.format("%,.0f đ", getSubTotal());
    }
}
