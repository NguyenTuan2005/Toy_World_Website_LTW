package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class UserRole extends BaseModel{
    private Long userId;
    private Long roleId;

    public UserRole(Long userId, Long roleId) {
        this.userId = userId;
        this.roleId = roleId;
    }
}
