package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dto.SignUpUserDTO;

import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.EmailValidation;
import com.n3.childrentoyweb.utils.MD5Util;

public class AuthService {
    private UserDAO userDAO = new UserDAO();


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
                signUpUserDTO.isValidPhone() &&
                signUpUserDTO.isValidEmail() &&
                signUpUserDTO.isValidPassword();
    }
}
