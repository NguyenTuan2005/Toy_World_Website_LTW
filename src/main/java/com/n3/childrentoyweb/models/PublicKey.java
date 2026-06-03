package com.n3.childrentoyweb.models;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;
import java.time.LocalDateTime;

public class PublicKey extends BaseModel implements Serializable,Comparable<PublicKey> {
    @ColumnName("user_id")
    private Long userId;

    @ColumnName("public_key")
    private String publicKey;

    @ColumnName("lost_at")
    private LocalDateTime lostAt;


    public PublicKey(Long id, Boolean isActive, LocalDateTime createdAt, LocalDateTime lostAt, Long userId, String publicKey) {
        super(id, isActive, createdAt);
        this.lostAt = lostAt;
        this.userId = userId;
        this.publicKey = publicKey;
    }

    public PublicKey(LocalDateTime lostAt, Long userId, String publicKey) {
        this.lostAt = lostAt;
        this.userId = userId;
        this.publicKey = publicKey;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public LocalDateTime getLostAt() {
        return lostAt;
    }

    public void setLostAt(LocalDateTime lostAt) {
        this.lostAt = lostAt;
    }

    public PublicKey() {

    }


    public Long getUserId() {
        return userId;
    }

    public String getPublicKey() {
        return publicKey;
    }

    @Override
    public String toString() {
        return "PublicKey{" +
                "userId=" + userId +
                ", publicKey='" + publicKey + '\'' +
                ", lostAt=" + lostAt +
                ", id=" + id +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }

    @Override
    public int compareTo(PublicKey publicKey) {
        return publicKey.createdAt.compareTo(this.createdAt);
    }

    public String getStringCreateAt(){
        return this.createdAt.toString();
    }


}
