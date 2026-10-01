package vn.yain.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Favorites")
public class Favorite_24110343 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FavoriteId")
    private int favoriteId;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikedDate")
    private Date likedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId")
    private Video_24110343 video;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username")
    private User_24110343 user;

    public Favorite_24110343() {
    }

    public Favorite_24110343(Date likedDate, Video_24110343 video, User_24110343 user) {
        this.likedDate = likedDate;
        this.video = video;
        this.user = user;
    }

    public int getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(int favoriteId) {
        this.favoriteId = favoriteId;
    }

    public Date getLikedDate() {
        return likedDate;
    }

    public void setLikedDate(Date likedDate) {
        this.likedDate = likedDate;
    }

    public Video_24110343 getVideo() {
        return video;
    }

    public void setVideo(Video_24110343 video) {
        this.video = video;
    }

    public User_24110343 getUser() {
        return user;
    }

    public void setUser(User_24110343 user) {
        this.user = user;
    }
}
