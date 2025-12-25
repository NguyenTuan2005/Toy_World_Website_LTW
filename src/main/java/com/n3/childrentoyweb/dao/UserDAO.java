package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import com.n3.childrentoyweb.utils.MD5Util;

import java.time.LocalDateTime;
import java.util.List;

public class UserDAO extends BaseDAO {
    public User findByEmail(String email) {
        String sql = """
        select first_name, last_name, phone, gender, password, email, location_id
        from users
        where email = :email
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public User login(String email, String password) {

        String sql = """
            SELECT u.id, u.first_name, u.last_name, phone, gender, password, email, location_id
            FROM users u
            WHERE u.email = :email
              AND u.password = :password
              AND u.is_active = 1
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .bind("password", password)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<ManageUserDTO> findAllUserForManagement(int page, int pageSize){
        int offset = (page - 1) * pageSize;
        String sql = """
                select
                    u.id,
                    u.email,
                    u.first_name,
                    u.last_name,
                    u.phone,
                    u.gender,
                    l.province,
                    u.created_at,
                    u.is_active
                from users u
                join locations l on l.id = u.location_id
                where  l.is_active = 1
                order by u.created_at
                limit :limit offset :offsets
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit",pageSize)
                        .bind("offsets",offset)
                        .map((rs, ctx) -> {
                            ManageUserDTO manageUserDTO = new ManageUserDTO();
                            manageUserDTO.setUserId(rs.getLong("id"));
                            manageUserDTO.setFirstName(rs.getString("first_name"));
                            manageUserDTO.setLastName(rs.getString("last_name"));
                            manageUserDTO.setSex(rs.getString("gender"));
                            manageUserDTO.setProvince(rs.getString("province"));
                            manageUserDTO.setEmail(rs.getString("email"));
                            manageUserDTO.setPhone(rs.getString("phone"));
                            manageUserDTO.setStatus(rs.getBoolean("is_active") ?"hoạt động":"khóa");
                            manageUserDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            return manageUserDTO;
                        })
                        .list()
        );
    }

    public int countAllUsers(){
        String sql = """
                select count(u.id)
                from users u
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(int.class)
                        .one()
        );
    }

    public void save(User user) {
        String sql = """
            Insert into user (first_name, last_name, phone, gender, password, email, location_id)
            Values (:firstName, :lastName, :phone, :gender, :password, :email, :locationId) 
        """;

        super.getJdbi().useHandle(handle ->
                handle.createQuery(sql)
                        .bind("firstName", user.getFirstName())
                        .bind("lastName", user.getLastName())
                        .bind("phone", user.getPhone())
                        .bind("gender", user.getGender())
                        .bind("email", user.getEmail())
                        .bind("password", MD5Util.md5HashToString(user.getPassword()))
                        .bind("locationId", user.getLocationId())
                );
    }
}
