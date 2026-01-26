package com.n3.childrentoyweb.dto;

public class HandBookCriteria {
    private String SKIP="";
    private Long id;
    private Boolean isOnMonth;
    private Boolean isOnDay;
    private Boolean isHidden;
    private Long userId;
    private String title;

    private Integer currentPage;
    private Integer pageSize = 1;
    private String orderBy = null;
    private String orderType = "desc";

    public HandBookCriteria(){}

    public Integer getPageSize() {
        return pageSize;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setOnMonth(Boolean onMonth) {
        isOnMonth = onMonth;
    }

    public void setOnDay(Boolean onDay) {
        isOnDay = onDay;
    }

    public void setHidden(Boolean hidden) {
        isHidden = hidden;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPaginationForSql(){
        if(this.currentPage != null && this.pageSize != null){
            int offsets =  ((currentPage - 1) * pageSize);
            return " Limit "+pageSize+"  offset "+offsets;
        }
        return "Limit 10";
    }

    public String getIdForSql(){
        if(!(id == null || id == 0)){
            this.userId =null;
            this.title = null;
            this.isOnDay = null;
            this.isOnMonth = null;
            return " and h.id = "+ this.id;
        }
        return this.SKIP;
    }

    public String getIsOnMonthForSql(){
        if (isOnMonth != null && isOnMonth)
            return " AND YEAR(h.created_at) = YEAR(CURDATE())\n" +
                    "AND MONTH(h.created_at) = MONTH(CURDATE())\n ";
        return this.SKIP;
    }

    public String getIsOnDayForSql(){
        if (isOnDay!= null && isOnDay) {
            this.isOnMonth = false;
            return " AND YEAR(h.created_at) = YEAR(CURDATE())\n" +
                    " AND MONTH(h.created_at) = MONTH(CURDATE())\n" +
                    " AND DAY(h.created_at) = DAY(CURDATE())\n";
        }
        return this.SKIP;
    }

    public String getIsHiddenForSql(){
        if (isHidden != null && isHidden)
            return " AND h.status = 'HIDDEN'";
        else  if(isHidden != null  && !isHidden)
            return " AND h.status = 'POSTED'";
        return this.SKIP;
    }

    public String getTitleForSql(){
        if (this.title != null)
            return " AND h.title like '%"+this.title.trim()+"%'";
        return this.SKIP;
    }

    public String getUserIdForSql(){
        if(userId != null && userId >0){
            return " AND h.user_id = "+this.userId;
        }
        return this.SKIP;
    }

    public String getOrderByForSql() {
        if (orderBy != null)
            return " order by " + orderBy + " " + orderType;
        return SKIP;
    }

    @Override
    public String toString() {
        return "HandBookCriteria{" +
                "SKIP='" + SKIP + '\'' +
                ", id=" + id +
                ", isOnMonth=" + isOnMonth +
                ", isOnDay=" + isOnDay +
                ", isHidden=" + isHidden +
                ", userId=" + userId +
                ", title='" + title + '\'' +
                ", currentPage=" + currentPage +
                ", pageSize=" + pageSize +
                '}';
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
