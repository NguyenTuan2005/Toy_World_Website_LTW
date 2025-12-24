package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.models.User;

import java.util.regex.Pattern;

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

    public boolean isValidFirstName() {
        if(this.user.isValidFirstName()) return true;
        else throw new IllegalArgumentException("Tên không hợp lệ");
    }

    public boolean isValidLastName() {
        if(this.user.isValidLastName()) return true;
        else throw new IllegalArgumentException("Họ không hợp lệ");
    }

    public boolean isValidPhone(Pattern phonePattern) {
        if(this.user.isValidPhone(phonePattern)) return true;
        else throw new IllegalArgumentException("Số điện thoại không hợp lệ");
    }

    public boolean isValidEmail(Pattern emailPattern) {
        if(this.user.isValidEmail(emailPattern)) return true;
        else throw new IllegalArgumentException("Email không hợp lệ");
    }

    public boolean isValidPassword(Pattern passwordPattern) {
        if(this.user.isValidPassword(passwordPattern)
                && this.user.matchPassword(this.confirmPassword)) return true;
        else throw new IllegalArgumentException("Mật khẩu không hợp lệ vui lòng nhập lại");
    }
}
