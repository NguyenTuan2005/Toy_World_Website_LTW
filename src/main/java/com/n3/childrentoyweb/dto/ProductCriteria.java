package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.ValidatorUtil;

public class ProductCriteria {
    private final String SKIP = "";
    private String id;
    private String name;

    public ProductCriteria(String keyword) {
        if (keyword == null || keyword.isBlank())
            return;

        keyword = keyword.trim();

        if (ValidatorUtil.isNumber(keyword)) {
            this.id = keyword;
            return;
        }

        this.name = keyword;
    }

    public String getNameForSql() {
        if (this.name != null) {
            this.id = null;
        }
        return this.name == null ? this.SKIP : "and p.name like '%" + this.name + "%'";
    }

    public String getIdForSql() {
        if (this.id != null) {
            this.name = null;
        }
        return this.id == null ? this.SKIP : "and p.id = " + this.id + " ";
    }

}
