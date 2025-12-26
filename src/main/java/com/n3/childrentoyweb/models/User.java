package com.n3.childrentoyweb.models;


import com.n3.childrentoyweb.verifier.EmailVerifier;
import com.n3.childrentoyweb.verifier.NameVerifier;
import com.n3.childrentoyweb.verifier.PasswordVerifier;
import com.n3.childrentoyweb.verifier.PhoneVerifier;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;

public class User extends BaseModel implements Serializable {
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

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public User(String firstName, String lastName, String phone, String gender, String password, String email, Long locationId) {
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

    public User(){}

    @Override
    public String toString() {
        return "User{" +
                "firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", phone='" + phone + '\'' +
                ", gender='" + gender + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", locationId=" + locationId +
                ", id=" + id +
                '}';
    }

    public boolean isValidFirstName() throws IllegalArgumentException {
        return new NameVerifier().verify(this.firstName);
    }

    public boolean isValidLastName() throws IllegalArgumentException {
        return new NameVerifier().verify(this.lastName);
    }

    public boolean isValidPhone() throws IllegalArgumentException {
        return new PhoneVerifier().verify(this.phone);
    }

    public boolean isValidEmail() throws IllegalArgumentException {
        return new EmailVerifier().verify(this.email);
    }

    public boolean isValidPassword() throws IllegalArgumentException {
        return new PasswordVerifier().verify(this.password);
    }

    public boolean matchPassword(String confirmPassword) {
        return password.equals(confirmPassword);
    }
}
