package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.ValidatorUtil;

public class CommentCriteria {
    private final String SKIP = "";
    private String productId;
    private String userName;
    private String productName;
    private String orderBy = null;
    private String orderType = "desc";

    public CommentCriteria(String keyword) {
        if (keyword == null || keyword.isBlank())
            return;

        keyword = keyword.trim();

        if (ValidatorUtil.isNumber(keyword)) {
            this.productId = keyword;
            return;
        }

        if (ValidatorUtil.isFullName(keyword)) {
            this.userName = keyword;
            return;
        }

        this.productName = keyword;
    }

    public String getProductIdForSql() {
        if (this.productId != null) {
            this.userName = null;
            this.productName = null;
        }
        return this.productId == null ? SKIP : "and p.id = " + productId + " ";
    }

    public String getUserNameForSql() {
        if (this.userName != null) {
            this.productId = null;
            this.productName = null;
        }
        return this.userName == null ? SKIP : "and concat(u.last_name, ' ', u.first_name) like '%" + userName + "%' ";
    }

    public String getProductNameForSql() {
        if (this.productName != null) {
            this.productId = null;
            this.userName = null;
        }
        return this.productName == null ? SKIP : "and p.name like '%" + productName + "%' ";
    }

    public String getOrderByForSql() {
        if (this.orderBy != null) {
            return " order by " + this.orderBy + " " + this.orderType;
        }
        return this.SKIP;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }
}
