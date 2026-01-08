package com.n3.childrentoyweb.enums;


public enum RoleEnum {
    ROLE_USER("ROLE_USER"),
    ROLE_ADMIN("ROLE_ADMIN");

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
