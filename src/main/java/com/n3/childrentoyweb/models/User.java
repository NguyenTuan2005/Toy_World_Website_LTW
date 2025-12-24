package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;
import java.util.regex.Pattern;

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

    public User(String firstName, String lastName, String phone, String gender,
                         String email, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.gender = gender;
        this.email = email;
        this.password = password;
    }

    public boolean isValidFirstName() {
        return firstName != null && !firstName.trim().isEmpty();
    }

    public boolean isValidLastName() {
        return lastName != null && !lastName.trim().isEmpty();
    }

    public boolean isValidPhone(Pattern phonePattern) {
        return phone != null && phonePattern.matcher(phone).matches();
    }

    public boolean isValidEmail(Pattern emailPattern) {
        return email != null && emailPattern.matcher(email).matches();
    }

    public boolean isValidPassword(Pattern passwordPattern) {
        return password != null && passwordPattern.matcher(password).matches();
    }

    public boolean matchPassword(String confirmPassword) {
        return password.equals(confirmPassword);
    }
}
