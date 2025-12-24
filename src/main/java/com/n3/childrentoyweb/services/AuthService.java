package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dto.SignUpUserDTO;

import java.util.regex.Pattern;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.EmailValidation;
import com.n3.childrentoyweb.utils.MD5Util;

public class AuthService {
    private UserDAO userDAO = new UserDAO();
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^(\\+84|0)[0-9]{9,10}$"
    );

    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    );

    public User login(String email, String password) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("Email không được để trống");
        }

        if (!EmailValidation.isValidEmail(email)) {
            throw new IllegalArgumentException("Email không đúng định dạng");
        }

        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống");
        }
        String hashPassword = MD5Util.encryptMd5(password);

        return userDAO.login(email, hashPassword);
    }

    public boolean validate(SignUpUserDTO signUpUserDTO) throws IllegalArgumentException {
        return signUpUserDTO.isValidFirstName() &&
                signUpUserDTO.isValidLastName() &&
                signUpUserDTO.isValidPhone(PHONE_PATTERN) &&
                signUpUserDTO.isValidEmail(EMAIL_PATTERN) &&
                signUpUserDTO.isValidPassword(PASSWORD_PATTERN);
    }
}
