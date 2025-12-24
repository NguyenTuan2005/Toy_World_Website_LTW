package com.n3.childrentoyweb.enums;


public enum Role {
    admin,
    user;

    public boolean isAdmin() {
        return this == admin;
    }
    public boolean isUser() {
        return this == user;
    }
}
