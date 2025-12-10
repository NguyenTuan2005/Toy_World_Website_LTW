package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Location extends BaseModel {
    private String address;
    private String province;

    public Location( String address, String province) {
        this.address = address;
        this.province = province;
    }
}
