package vn.yain.entity;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Videos")
@NamedQuery(name = "Video_24110343.findAll", query = "SELECT v FROM Video_24110343 v")
public class Video_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50)
    private String videoId;

    @Column(name = "Title", length = 200)
    private String title;

    @Column(name = "Poster", length = 50)
    private String poster;

    @Column(name = "Views")
    private Integer views;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "Active")
    private Boolean active;

    @Column(name = "VideoUrl", length = 255)
    private String videoUrl;

    @Column(name = "Price")
    private Double price = 100000.0;

    @Column(name = "Stock")
    private Integer stock = 50;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CategoryId")
    private Category_24110343 category;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Favorite_24110343> favorites;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Share_24110343> shares;

    @Transient
    private long likeCount;

    @Transient
    private long shareCount;

    public Video_24110343() {
    }

    public Video_24110343(String videoId, String title, String poster, Integer views, String description, Boolean active, Category_24110343 category) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.category = category;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Integer getViews() {
        return views != null ? views : 0;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active != null && active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public Category_24110343 getCategory() {
        return category;
    }

    public void setCategory(Category_24110343 category) {
        this.category = category;
    }

    public List<Favorite_24110343> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite_24110343> favorites) {
        this.favorites = favorites;
    }

    public List<Share_24110343> getShares() {
        return shares;
    }

    public void setShares(List<Share_24110343> shares) {
        this.shares = shares;
    }

    public long getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(long likeCount) {
        this.likeCount = likeCount;
    }

    public long getShareCount() {
        return shareCount;
    }

    public void setShareCount(long shareCount) {
        this.shareCount = shareCount;
    }

    public Double getPrice() {
        return price != null ? price : 100000.0;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock != null ? stock : 50;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", getPrice());
    }
}
