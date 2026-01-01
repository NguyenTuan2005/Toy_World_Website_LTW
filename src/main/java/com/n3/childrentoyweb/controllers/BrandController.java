package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.services.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

@WebServlet(name = "brand", value= "/brand")
public class BrandController extends HttpServlet {
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        this.brandService = new BrandService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Brand> brands = brandService.findAll();

        Map<String, List<Brand>> groupedBrands = brands.stream()
                        .collect(Collectors.groupingBy(
                                brand -> brand.getName().substring(0, 1).toUpperCase(),
                                TreeMap::new,
                                Collectors.toList()
                        ));

        req.setAttribute("brands", brands);
        req.setAttribute("groupedBrands", groupedBrands);
        req.getRequestDispatcher("/brand.jsp").forward(req, resp);
    }
}
