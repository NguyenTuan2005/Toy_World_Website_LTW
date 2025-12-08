package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class UserComment extends BaseModel {
    private String content;
    private User user;
    private Product product;

    public void setUser (User user) {
        this.user = user;
    }
}
