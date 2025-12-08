package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.List;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class User extends BaseModel {
    private String firstName;
    private String lastName;
    private String phone;
    private String gender;
    private String password;
    private String email;
    private Location location;
    @Builder.Default
    private List<Role> roles = new ArrayList<>();
    @Builder.Default
    private List<UserComment> comments = new ArrayList<>();

    public void addUserComment (UserComment comment) {
        this.comments.add(comment);
        comment.setUser(this);
    }

    public void addAllUserComment (List<UserComment> comments) {
        for (UserComment comment : comments) {
            this.addUserComment(comment);
        }
    }
}
