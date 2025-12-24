package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.Role;

import java.util.List;

public class CurrentUser {
    private Long id;
    private List<Role> roles;

    public static final String CURRENT_USER = "CurrentUser";

    public CurrentUser() {}

    public CurrentUser(Long id, List<Role> roles) {
        this.id = id;
        this.roles = roles;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public List<Role> getRoles() {
        return roles;
    }

    @Override
    public String toString() {
        return "CurrentUser{" +
                "id=" + id +
                ", roles=" + roles +
                '}';
    }

    public boolean hasAdminRole(){
        return this.roles.stream().anyMatch(Role::isAdmin);
    }

    public boolean hasUserRole(){
        return this.roles.stream().anyMatch(Role::isUser);
    }

}
