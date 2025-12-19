package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.models.Product;

import java.util.List;

public class ProductService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
    }


    public List<Product> findAll() {
        return productDAO.findAll();
    }

}
