package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class User extends BaseModel {
    @ColumnName("first_name")
    private String firstName;

    @ColumnName("last_name")
    private String lastName;

    @ColumnName("phone")
    private String phone;

    @ColumnName("gender")
    private String gender;

    @ColumnName("password")
    private String password;

    @ColumnName("email")
    private String email;

    @ColumnName("location_id")
    private Long locationId;

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getPhone() {
        return phone;
    }

    public String getGender() {
        return gender;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public Long getLocationId() {
        return locationId;
    }

    public User( String firstName, String lastName, String phone, String gender, String password, String email, Long locationId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.gender = gender;
        this.password = password;
        this.email = email;
        this.locationId = locationId;
    }
}
