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

    public void saveAll(List<ProductAsset> assets) {
        assets.forEach(productAsset -> this.productAssetDAO.save(productAsset));
    }

    public List<ProductAsset> findAllByProductId(long productId) {
        return this.productAssetDAO.findAllByProductId(productId);
    }

    public void deleteAllById(long[] deletedImageIds) {
        if (deletedImageIds == null) {
            return;
        }

        for (long id : deletedImageIds) {
            this.productAssetDAO.deleteById(id);
        }
    }
}
