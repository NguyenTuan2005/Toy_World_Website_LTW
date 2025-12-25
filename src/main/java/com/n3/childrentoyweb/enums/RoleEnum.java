package com.n3.childrentoyweb.enums;


public enum RoleEnum {
    ROLE_USER("user"),
    ROLE_ADMIN("admin");

    private final String roleName;

    private RoleEnum(String roleName){
        this.roleName = roleName;
    }
    public boolean isAdmin() {
        return this == ROLE_ADMIN;
    }
    public boolean isUser() {
        return this == ROLE_USER;
    }

    public String getRoleName() {
        return this.roleName;
    }
}
