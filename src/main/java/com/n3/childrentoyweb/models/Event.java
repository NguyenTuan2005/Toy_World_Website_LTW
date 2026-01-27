package com.n3.childrentoyweb.models;


import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
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

    private String status;

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

    public Event() {

    }

    public void setName(String name) {
        this.name = name;
    }

    public void setOpenedAt(LocalDateTime openedAt) {
        this.openedAt = openedAt;
    }

    public void setClosedAt(LocalDateTime closedAt) {
        this.closedAt = closedAt;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTypeEvent(String typeEvent) {
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


    private String getEventStatusText() {
        LocalDateTime now = LocalDateTime.now();

        if (openedAt != null && now.isBefore(openedAt)) {
            return "Chưa diễn ra";
        }

        if (closedAt != null && now.isAfter(closedAt)) {
            return "Đã kết thúc";
        }

        return "Đang diễn ra";
    }


    public String getStatus() {
        return status;
    }

    public void setStatus() {
        this.status = this.getEventStatusText();
    }

    public String getOpenedAtFormatted() {
        if (openedAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(openedAt);
    }

    public String getClosedAtFormatted() {
        if (closedAt == null) return "";

        return LocalDateTimeConverterUtil.convertToString(closedAt);
    }
}
