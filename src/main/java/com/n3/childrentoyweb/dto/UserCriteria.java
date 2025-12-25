package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.ValidatorUtil;

public class UserCriteria {
    private final String SKIP ="";
    private String id;
    private String fullName;
    private String phone;
    private String email;

    public UserCriteria(){}

    public UserCriteria(String keyword){

        if (keyword == null || keyword.isBlank()) {
            return;
        }

        keyword = keyword.trim();

        if (ValidatorUtil.isEmail(keyword)) {
            this.email = keyword;
            return;
        }

        if (ValidatorUtil.isPhone(keyword)) {
            this.phone = keyword;
            return;
        }

        if (ValidatorUtil.isNumber(keyword)) {
            this.id = keyword;
            return;
        }

        if (ValidatorUtil.isFullName(keyword)) {
            this.fullName = keyword;
        }


    }

    public UserCriteria(String id, String fullName, String phone, String email) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
    }

    public String getIdForSql(){
        if(this.id != null) {
            this.fullName = null;
            this.phone =null;
            this.email = null;
        }
        return this.id == null ? this.SKIP : "and u.id = "+id +" ";
    }

    public String getFullNameForSql(){
        return this.fullName == null ? this.SKIP : "and concat(u.first_name,u.last_name) like '%"+fullName+"%' ";
    }

    public String getPhoneForSql(){
        if(this.phone != null){
            this.id = null;
            this.fullName = null;
            this.email = null;
        }
        return this.phone == null ? this.SKIP : "and u.phone = '"+phone +"' ";
    }

    public String getEmailForSql(){
        if(this.email != null){
            this.fullName = null;
            this.phone =null;
            this.id = null;
        }
        return  this.email == null ? this.SKIP : "and u.email = '"+email +"' ";
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "UserCriteria{" +
                "SKIP='" + SKIP + '\'' +
                ", id='" + id + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }


}
