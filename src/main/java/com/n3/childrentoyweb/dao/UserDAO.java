package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.MD5Util;

public class UserDAO  extends BaseDAO {

    public User login(String email, String passwordPlain) {

        String sql = """
            SELECT u.first_name, u.last_name, phone, gender, password, email, location_id
            FROM users u
            WHERE u.email = :email
              AND u.password = :password
              AND u.is_active = 1
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .bind("password", MD5Util.encryptMd5(passwordPlain))
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }
}
