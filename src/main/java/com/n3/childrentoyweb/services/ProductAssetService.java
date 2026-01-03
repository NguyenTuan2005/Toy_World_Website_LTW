package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.models.ProductAsset;

import java.util.List;
import java.util.Optional;

public class ProductAssetService {
    private ProductAssetDAO productAssetDAO;

    public ProductAssetService() {
        this.productAssetDAO = new ProductAssetDAO();
    }

    public List<ProductAsset> findAll(){
        return this.productAssetDAO.findAll();
    }

    public Optional<ProductAsset> findFirstByProductId(long productId) {
        return this.productAssetDAO.findFirstByProductId(productId);
    }
}
