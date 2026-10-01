package vn.yain.entity;

import java.io.Serializable;

public class CartItem_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Video_24110343 video;
    private int quantity;
    private double price;
    private String size = "Size M (1080p FHD)";
    private String note = "";

    public CartItem_24110343() {
    }

    public CartItem_24110343(Video_24110343 video, int quantity, double price) {
        this.video = video;
        this.quantity = quantity;
        this.price = price;
        this.size = "Size M (1080p FHD)";
        this.note = "";
    }

    public CartItem_24110343(Video_24110343 video, int quantity, double price, String size, String note) {
        this.video = video;
        this.quantity = quantity;
        this.price = price;
        this.size = (size != null && !size.trim().isEmpty()) ? size.trim() : "Size M (1080p FHD)";
        this.note = (note != null) ? note.trim() : "";
    }

    public String getCartKey() {
        String cleanSize = size != null ? size.replaceAll("[^a-zA-Z0-9]", "") : "M";
        return (video != null ? video.getVideoId() : "vid") + "_" + cleanSize;
    }

    public Video_24110343 getVideo() {
        return video;
    }

    public void setVideo(Video_24110343 video) {
        this.video = video;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSize() {
        return (size != null && !size.trim().isEmpty()) ? size : "Size M (1080p FHD)";
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getNote() {
        return note != null ? note : "";
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getSubTotal() {
        return price * quantity;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }

    public String getFormattedSubTotal() {
        return String.format("%,.0f đ", getSubTotal());
    }
}
