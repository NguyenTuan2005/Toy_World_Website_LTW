package com.n3.childrentoyweb.dto;

public class ProductCriteria {
    private final String SKIP = "";
    private String name;

    public ProductCriteria(String keyword) {
        if (keyword == null || keyword.isBlank())
            return;

        keyword = keyword.trim();

        this.name = keyword;
    }

    public String getNameForSql() {
        return this.name == null ? this.SKIP : "and p.name like '%" + this.name + "%'";
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
