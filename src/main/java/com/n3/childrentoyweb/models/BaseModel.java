package com.n3.childrentoyweb.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public abstract class BaseModel {
    protected Long id;
    protected Boolean isActive;
    protected LocalDateTime createdAt;
}
