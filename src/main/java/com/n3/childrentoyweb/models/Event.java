package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Event extends BaseModel {
    private String name;
    private LocalDateTime openedAt;
    private LocalDateTime closedAt;
    private String description;
    private String typeEvent;
}
