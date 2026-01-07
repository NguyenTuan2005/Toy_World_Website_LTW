package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.ValidatorUtil;

public class BrandCriteria {
    private final String SKIP ="";
    private String id;
    private String name;

    public BrandCriteria(String keyword){

        if (keyword == null || keyword.isBlank()) {
            return;
        }

        keyword = keyword.trim();



        if (ValidatorUtil.isNumber(keyword)) {
            this.id = keyword;
            return;
        }

        this.name = keyword;
    }

    public String getIdForSql(){
        if(this.id != null) {
            this.name = null;
        }
        return this.id == null ? this.SKIP : "and b.id = "+id +" ";
    }

    @Override
    public String toString() {
        return "BrandCriteria{" +
                "SKIP='" + SKIP + '\'' +
                ", id='" + id + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    public String getNameForSql(){
        return this.name == null ? this.SKIP : "and b.name like '%"+this.name+"%' ";
    }

}
