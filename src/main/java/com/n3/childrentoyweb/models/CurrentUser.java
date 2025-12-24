package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.Role;

import java.util.List;

public class CurrentUser {
    private User user;
    private List<Role> roles;

    public static final String CURRENT_USER = "CurrentUser";

    public CurrentUser() {}

    public CurrentUser(User user, List<Role> roles) {
        this.user = user;
        this.roles = roles;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public boolean hasAdminRole(){
        return this.roles.stream().anyMatch(Role::isAdmin);
    }

    public boolean hasUserRole(){
        return this.roles.stream().anyMatch(Role::isUser);
    }

}
