package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dto.SignUpUserDTO;

import java.util.regex.Pattern;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.models.User;

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

    public User login(String email, String password){
        return userDAO.login(email, password);
    }

    public boolean validate(SignUpUserDTO signUpUserDTO) throws IllegalArgumentException {
        return signUpUserDTO.isValidFirstName() &&
                signUpUserDTO.isValidLastName() &&
                signUpUserDTO.isValidPhone(PHONE_PATTERN) &&
                signUpUserDTO.isValidEmail(EMAIL_PATTERN) &&
                signUpUserDTO.isValidPassword(PASSWORD_PATTERN);
    }

    public static void main(String[] args) {
        System.out.println( new AuthService().login("user1@gmail.com", "1"));
    }
}
