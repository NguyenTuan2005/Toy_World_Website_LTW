package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.models.Product;

import java.util.List;
import java.util.Optional;

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

    public List<Product> findAllByPage(int page, int pageSize) {
        return productDAO.findAllByPage(page, pageSize);
    }

    public int countAll(){
        return this.productDAO.countAll();
    }

    public List<HomeProductDTO> findNewImportProductsInMonth(int page, int pageSize) {
        return this.productDAO.findNewImportProductsInMonth(page,pageSize);
    }

    public List<HomeProductDTO> findSignatureProduct(){
        return this.productDAO.findSignatureProduct(1,10,"LEGO");
    }
    public Optional<Product> findById(Long id ){
        return this.productDAO.findById(id);
    }
}
