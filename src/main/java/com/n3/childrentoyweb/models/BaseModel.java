package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public abstract class BaseModel {
    protected Long id;
    protected Boolean isActive;
    protected LocalDateTime createdAt;
}
