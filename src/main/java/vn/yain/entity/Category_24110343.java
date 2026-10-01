package vn.yain.entity;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category_24110343.findAll", query = "SELECT c FROM Category_24110343 c")
public class Category_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryId;

    @Column(name = "Categoryname", length = 100)
    private String categoryname;

    @Column(name = "Categorycode", length = 100)
    private String categorycode;

    @Column(name = "Images", length = 500)
    private String images;

    @Column(name = "Status")
    private Boolean status;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video_24110343> videos;

    public Category_24110343() {
    }

    public Category_24110343(String categoryname, String categorycode, String images, Boolean status) {
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.images = images;
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorycode() {
        return categorycode;
    }

    public void setCategorycode(String categorycode) {
        this.categorycode = categorycode;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public List<Video_24110343> getVideos() {
        return videos;
    }

    public void setVideos(List<Video_24110343> videos) {
        this.videos = videos;
    }
}
