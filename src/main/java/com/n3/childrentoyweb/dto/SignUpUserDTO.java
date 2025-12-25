package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.verifier.EmailVerifier;
import com.n3.childrentoyweb.verifier.NameVerifier;
import com.n3.childrentoyweb.verifier.PasswordVerifier;
import com.n3.childrentoyweb.verifier.PhoneVerifier;

public class SignUpUserDTO {
    private User user;
    private String confirmPassword;

    public SignUpUserDTO() {
    }

    public SignUpUserDTO(User user, String confirmPassword) {
        this.user = user;
        this.confirmPassword = confirmPassword;
    }

    public User getUser() {return user;}

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public boolean isValidFirstName() throws IllegalArgumentException {
        return new NameVerifier().verify(this.user.getFirstName());
    }

    public boolean isValidLastName() throws IllegalArgumentException {
        return new NameVerifier().verify(this.user.getLastName());
    }

    public boolean isValidPhone() throws IllegalArgumentException {
        return new PhoneVerifier().verify(this.user.getPhone());
    }

    public boolean isValidEmail() throws IllegalArgumentException {
        return new EmailVerifier().verify(this.user.getEmail());
    }

    public boolean isValidPassword() throws IllegalArgumentException {
        return new PasswordVerifier().verify(this.user.getPassword())
                && this.user.matchPassword(this.confirmPassword);
    }
}
