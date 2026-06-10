package com.n3.childrentoyweb.dto;

import java.time.LocalDateTime;

public class UserPublicKeyDTO {
    private Long userId;
    private Long publicKeyId;
    private String email;
    private String fullName;
    private LocalDateTime createdAt;
    private LocalDateTime lostAt;
    private String lost;
    public UserPublicKeyDTO(Long userId,
                            Long publicKeyId,
                            String email,
                            String fullName,
                            LocalDateTime createdAt,
                            LocalDateTime lostAt,
                            String lost) {
        this.userId = userId;
        this.publicKeyId = publicKeyId;
        this.email = email;
        this.fullName = fullName;
        this.createdAt = createdAt;
        this.lostAt = lostAt;
        this.lost = lost;
    }


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getPublicKeyId() {
        return publicKeyId;
    }

    public void setPublicKeyId(Long publicKeyId) {
        this.publicKeyId = publicKeyId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getLostAt() {
        return lostAt;
    }

    public void setLostAt(LocalDateTime lostAt) {
        this.lostAt = lostAt;
    }

    public String getLost() {
        return lost;
    }

    public void setLost(String lost) {
        this.lost = lost;
    }

    @Override
    public String toString() {
        return "UserPublicKeyDTO{" +
                "userId=" + userId +
                ", publicKeyId=" + publicKeyId +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", createdAt=" + createdAt +
                ", lostAt=" + lostAt +
                ", lost='" + lost + '\'' +
                '}';
    }
}
