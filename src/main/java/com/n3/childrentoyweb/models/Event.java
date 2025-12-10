package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Event extends BaseModel {
    private String name;
    private LocalDateTime openedAt;
    private LocalDateTime closedAt;
    private String description;
    private String typeEvent;

    public Event( String name, LocalDateTime openedAt, LocalDateTime closedAt, String description, String typeEvent) {
        this.name = name;
        this.openedAt = openedAt;
        this.closedAt = closedAt;
        this.description = description;
        this.typeEvent = typeEvent;
    }

    public String getName() {
        return name;
    }

    public LocalDateTime getOpenedAt() {
        return openedAt;
    }

    public LocalDateTime getClosedAt() {
        return closedAt;
    }

    public String getDescription() {
        return description;
    }

    public String getTypeEvent() {
        return typeEvent;
    }
}
