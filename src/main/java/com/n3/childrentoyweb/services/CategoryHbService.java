package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.CategoryHbDAO;
import com.n3.childrentoyweb.models.CategoryHb;

import java.util.List;

public class CategoryHbService {
    private CategoryHbDAO categoryHbDAO;

    public CategoryHbService(){
        this.categoryHbDAO = new CategoryHbDAO();
    }

    public List<CategoryHb> findAll(){
        return this.categoryHbDAO.findAll();
    }
}
