package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.services.BrandService;
import com.n3.childrentoyweb.services.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;


@WebServlet(name = "NewBrandManage",value = "/admin/new-brands")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class NewBrandController extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        this.cloudinaryService = new CloudinaryService();
        this.brandService = new BrandService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/adminPages/new-brand.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String brandName = req.getParameter("brandName");
        boolean isValidBrandName = brandName != null && !brandName.isEmpty();

        if (isValidBrandName) {
            req.setAttribute("notify", "Tên không hợp lệ");
            req.getRequestDispatcher("/adminPages/new-brand.jsp").forward(req, resp);
            return;
        }
        String url = "https://ccx.smu.edu.sg/sites/cmp.smu.edu.sg/files/perspectives/Brand.jpg";
        Part filePart = req.getPart("imgFile");

        if (filePart != null)
           url = cloudinaryService.upload(filePart);

        boolean isActive = req.getParameter("status").equals("active");

        Brand brand = new Brand();
        brand.setName(brandName);
        brand.setActive(isActive);
        brand.setImgPath(url);

        brandService.save(brand);

        req.setAttribute("notify", "Đã thêm thành công");

        req.getRequestDispatcher("/adminPages/new-brand.jsp").forward(req, resp);
    }

}
