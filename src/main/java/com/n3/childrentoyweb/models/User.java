package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class User extends BaseModel {
    private String firstName;
    private String lastName;
    private String phone;
    private String gender;
    private String password;
    private String email;
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
