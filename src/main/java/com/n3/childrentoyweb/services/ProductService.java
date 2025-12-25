package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ApplicationProperties;
import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.models.Product;

import java.util.List;
import java.util.Optional;

public class ProductService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;
    private static final int FIRST_PAGE = 1;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
    }


    public List<Product> findAll() {
        return productDAO.findAll();
    }

    public List<Product> findAllByPage(int page, int pageSize) {
        return productDAO.findAllByPage(page, pageSize);
    }

    public int countAll(){
        return this.productDAO.countAll();
    }

    public List<HomeProductDTO> findNewImportProductsInMonth() {
        return this.productDAO.findNewImportProductsInMonth(FIRST_PAGE,ApplicationProperties.DISPLAY_PRODUCT_SIZE);
    }

    public List<HomeProductDTO> findSignatureProduct(){
        return this.productDAO.findSignatureProduct(FIRST_PAGE,ApplicationProperties.DISPLAY_PRODUCT_SIZE,ApplicationProperties.SIGNATURE_BRAND_NAME);
    }
    public Optional<Product> findById(Long id ){
        return this.productDAO.findById(id);
    }
}
