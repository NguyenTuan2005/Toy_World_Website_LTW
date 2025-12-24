package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.RoleEnum;

import java.util.List;

public class CurrentUser {
    private User user;
    private List<RoleEnum> roles;

    public static final String CURRENT_USER = "CurrentUser";

    public CurrentUser() {}

    public CurrentUser(User user, List<RoleEnum> roles) {
        this.user = user;
        this.roles = roles;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<RoleEnum> getRoles() {
        return roles;
    }

    public void setRoles(List<RoleEnum> roles) {
        this.roles = roles;
    }

    public boolean hasAdminRole(){
        return this.roles.stream().anyMatch(RoleEnum::isAdmin);
    }

    public boolean hasUserRole(){
        return this.roles.stream().anyMatch(RoleEnum::isUser);
    }

}
