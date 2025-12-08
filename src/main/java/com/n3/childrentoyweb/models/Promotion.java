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
public class Promotion extends BaseModel {
    private String name;
    private LocalDateTime expiredAt;
    private Double discountPercent;
    private Double discountPrice;
    private Event event;
}
