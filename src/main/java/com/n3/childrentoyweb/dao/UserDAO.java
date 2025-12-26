package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.dto.UserCriteria;
import com.n3.childrentoyweb.dto.UserDetailDTO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import com.n3.childrentoyweb.utils.MD5Util;
import java.util.List;

public class UserDAO extends BaseDAO {

    public User findByEmail(String email) {
        String sql = """
        select id, first_name, last_name, phone, gender, password, email, location_id
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
                            manageUserDTO.setActive(rs.getBoolean("is_active"));
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
            Insert into users (first_name, last_name, phone, gender, password, email, location_id)
            Values (:firstName, :lastName, :phone, :gender, :password, :email, :locationId) 
        """;

        super.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("firstName", user.getFirstName())
                        .bind("lastName", user.getLastName())
                        .bind("phone", user.getPhone())
                        .bind("gender", user.getGender())
                        .bind("email", user.getEmail())
                        .bind("password", MD5Util.encryptMd5(user.getPassword()))
                        .bind("locationId", user.getLocationId())
                        .execute()
                );
    }

    public List<ManageUserDTO> findByCriteria(UserCriteria userCriteria) {

        StringBuilder sql = new StringBuilder("""
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
                where  1 = 1
                """);

        sql.append(userCriteria.getIdForSql());
        sql.append(userCriteria.getPhoneForSql());
        sql.append(userCriteria.getFullNameForSql());
        sql.append(userCriteria.getEmailForSql());
        sql.append(" limit 10");



        System.out.println(sql);
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            ManageUserDTO manageUserDTO = new ManageUserDTO();
                            manageUserDTO.setUserId(rs.getLong("id"));
                            manageUserDTO.setFirstName(rs.getString("first_name"));
                            manageUserDTO.setLastName(rs.getString("last_name"));
                            manageUserDTO.setSex(rs.getString("gender"));
                            manageUserDTO.setProvince(rs.getString("province"));
                            manageUserDTO.setEmail(rs.getString("email"));
                            manageUserDTO.setPhone(rs.getString("phone"));
                            manageUserDTO.setActive(rs.getBoolean("is_active"));
                            manageUserDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            return manageUserDTO;
                        })
                        .list());
    }


    public boolean delete(long id){
        return this.getJdbi().withHandle(handle ->
                handle.createUpdate("""
                                            UPDATE users
                                            SET is_active = 0
                                            WHERE id = :id
                                        """)
                        .bind("id", id)
                        .execute()
                ) > 0;
    }

    public boolean activeUser(long id) {
        return this.getJdbi().withHandle(handle ->
                handle.createUpdate("""
                                            UPDATE users
                                            SET is_active = 1
                                            WHERE id = :id
                                        """)
                        .bind("id", id)
                        .execute()
        ) > 0;
    }

    public User findById(long id){
        String sql = """
        select id, first_name, last_name, phone, gender, password, email, location_id, is_active, created_at
        from users
        where id = :id
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            User user = new User();
                            user.setId(rs.getLong("id"));
                            user.setFirstName(rs.getString("first_name"));
                            user.setLastName(rs.getString("last_name"));
                            user.setPhone(rs.getString("phone"));
                            user.setPassword(rs.getString("password"));
                            user.setGender(rs.getString("gender"));
                            user.setEmail(rs.getString("email"));
                            user.setLocationId(rs.getLong("location_id"));
                            user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                            user.setActive(rs.getBoolean("is_active"));
                            return user;
                        })
                        .findOne()
                        .orElse(null)
        );
    }


    public void update(User user) {
            String sql = """
                            UPDATE users
                            SET first_name  = :firstName,
                                last_name   = :lastName,
                                phone       = :phone,
                                gender      = :gender,
                                password    = :password,
                                email       = :email,
                                is_active   = :isActive
                            WHERE id = :id
                        """;

             this.getJdbi().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("id", user.getId())
                            .bind("firstName", user.getFirstName())
                            .bind("lastName", user.getLastName())
                            .bind("phone", user.getPhone())
                            .bind("gender", user.getGender())
                            .bind("password", user.getPassword())
                            .bind("email", user.getEmail())
                            .bind("isActive",user.getActive())
                            .execute()
            );
    }
}
