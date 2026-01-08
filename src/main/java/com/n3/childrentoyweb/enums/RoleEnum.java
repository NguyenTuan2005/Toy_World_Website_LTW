package com.n3.childrentoyweb.enums;


public enum RoleEnum {
    ROLE_USER("user", 1L),
    ROLE_ADMIN("admin", 2L);

    private final String roleName;
    private final Long roleId;

    private RoleEnum(String roleName, Long roleId){
        this.roleName = roleName;
        this.roleId = roleId;
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
    public Long getRoleId() {return this.roleId;}
}
