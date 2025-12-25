package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Location extends BaseModel {
    @ColumnName("address")
    private String address;
    @ColumnName("province")
    private String province;

    public Location( String address, String province) {
        this.address = address;
        this.province = province;
    }

    public Location(Long id, String address,String province,Boolean isActive,LocalDateTime createdAt){
        super(id,isActive,createdAt);
        this.address = address;
        this.province = province;
    }

    public Location(){}

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Override
    public String toString() {
        return "Location{" +
                "id=" + id +
                ", province='" + province + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
