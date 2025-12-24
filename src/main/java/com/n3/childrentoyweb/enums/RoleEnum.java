package com.n3.childrentoyweb.enums;


public enum RoleEnum {
    ROLE_USER,
    ROLE_ADMIN;

    public boolean isAdmin() {
        return this == ROLE_ADMIN;
    }
    public boolean isUser() {
        return this == ROLE_USER;
    }
}
