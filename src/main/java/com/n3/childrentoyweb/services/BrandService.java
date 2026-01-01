package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.BrandDAO;
import com.n3.childrentoyweb.models.Brand;

import java.util.List;

public class BrandService {
    private BrandDAO brandDAO;

    public BrandService() {
        this.brandDAO = new BrandDAO();
    }

    public List<Brand> findAll() {
        return brandDAO.findALl();
    }
}
