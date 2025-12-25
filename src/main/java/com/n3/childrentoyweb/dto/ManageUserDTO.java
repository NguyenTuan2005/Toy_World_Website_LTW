package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class ManageUserDTO  {
    private  Long userId;
    private String email;
    private String phone;
    private  String firstName;
    private  String lastName;
    private String sex;
    private String province;
    private String role;
    private String status;
    private LocalDateTime createdAt;

    public ManageUserDTO() {
    }


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public ManageUserDTO(Long userId, String email, String phone, String firstName, String lastName, String sex, String province, String role, String status, LocalDateTime createdAt) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex = sex;
        this.province = province;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }
}
