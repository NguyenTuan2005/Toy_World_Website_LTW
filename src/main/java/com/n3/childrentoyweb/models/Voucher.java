package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.Category;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Voucher extends BaseModel {
    private String name;
    private LocalDateTime expiredAt;
    private Double discountPercent;
    private Double maxPrice;
    private Integer used;
    private Integer volumes;
    private Category category;
    private Brand brand;
}
