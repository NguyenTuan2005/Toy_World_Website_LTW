package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.exception.EmailAlreadyExistsException;
import com.n3.childrentoyweb.models.User;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public void isEmailExist(String email) {
        if (userDAO.findByEmail(email) != null) {
            throw new EmailAlreadyExistsException("Email này đã tồn tại");
        }
    }

    public void save(User user) {
        userDAO.save(user);
    }
}
