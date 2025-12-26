package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;

public  class UserDetailDTO {
    private User user;
    private Location location;
    private String role;

    public UserDetailDTO(User user, Location location, String role) {
        this.user = user;
        this.location = location;
        this.role = role;
    }
    public UserDetailDTO(User user, Location location) {
        this.user = user;
        this.location = location;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "UserDetailDTO{" +
                "user=" + user +
                ", location=" + location +
                ", role='" + role + '\'' +
                '}';
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}