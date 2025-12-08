package com.n3.childrentoyweb.models;

import com.n3.childrentoyweb.enums.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class Product extends BaseModel {
    private Double price;
    private Promotion promotion;
    private Integer quantity;
    private String name;
    @Builder.Default
    private Map<String, String> restInfo = new HashMap<>();
    private String description;
    private Brand brand;
    private Category category;
    @Builder.Default
    private List<ProductAsset> productAssets = new ArrayList<>();

    public void addProductAsset (ProductAsset productAsset) {
        this.productAssets.add(productAsset);
        productAsset.setProduct(this);
    }

    public void addAllProductAsset (List<ProductAsset> productAssets) {
        for (ProductAsset productAsset : productAssets) {
            this.addProductAsset(productAsset);
        }
    }
}
