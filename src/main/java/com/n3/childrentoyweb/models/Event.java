package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Event extends BaseModel {
    @ColumnName("name")
    private String name;
    @ColumnName("opened_at")
    private LocalDateTime openedAt;
    @ColumnName("closed_at")
    private LocalDateTime closedAt;
    @ColumnName("description")
    private String description;
    @ColumnName("type_event")
    private String typeEvent;

    public Event(Long id, String name, LocalDateTime openedAt, LocalDateTime closedAt, String description, String typeEvent,Boolean isActive, LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.name = name;
        this.openedAt = openedAt;
        this.closedAt = closedAt;
        this.description = description;
        this.typeEvent = typeEvent;
    }

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
