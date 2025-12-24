package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.models.User;

public class AuthService {
    private UserDAO userDAO = new UserDAO();


    public User login(String email, String password){
        return userDAO.login(email, password);
    }

    public static void main(String[] args) {
        System.out.println( new AuthService().login("user1@gmail.com", "1"));
    }
}
