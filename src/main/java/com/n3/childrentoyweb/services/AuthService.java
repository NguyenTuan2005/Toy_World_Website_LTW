package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dto.SignUpUserDTO;

import java.util.regex.Pattern;

public class AuthService {
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^(\\+84|0)[0-9]{9,10}$"
    );

    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    );

    public boolean validate(SignUpUserDTO signUpUserDTO) throws IllegalArgumentException {
        return signUpUserDTO.isValidFirstName() &&
                signUpUserDTO.isValidLastName() &&
                signUpUserDTO.isValidPhone(PHONE_PATTERN) &&
                signUpUserDTO.isValidEmail(EMAIL_PATTERN) &&
                signUpUserDTO.isValidPassword(PASSWORD_PATTERN);
    }
}
