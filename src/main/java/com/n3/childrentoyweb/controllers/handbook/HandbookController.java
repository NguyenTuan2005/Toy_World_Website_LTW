package com.n3.childrentoyweb.controllers.handbook;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.HandBookCardDTO;
import com.n3.childrentoyweb.dto.HandBookCriteria;
import com.n3.childrentoyweb.dto.HandbookAdminCriteria;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "handbook", value = "/handbook")
public class HandbookController extends HttpServlet {
    private static final int PAGE_SIZE = 6;
    private static final int SUGGEST_PAGE_SIZE = 3;
    private BannerService bannerService;
    private HandBookService handBookService;

    @Override
    public void init() throws ServletException {
        this.bannerService = new BannerService();
        this.handBookService = new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
        Banner banner = this.bannerService.findByGroupTag(BannerGroupTag.HANDBOOK.getTag()).stream().findFirst().orElse(new Banner());

        HandBookCriteria handBookCriteria = new HandBookCriteria();
        handBookCriteria.setOnMonth(true);
        handBookCriteria.setCurrentPage(page);
        handBookCriteria.setPageSize(PAGE_SIZE);

        Pagination<HandBookCardDTO> handbookCards = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        handBookCriteria.setOrderBy("h.views");
        handBookCriteria.setPageSize(SUGGEST_PAGE_SIZE);

        Pagination<HandBookCardDTO> suggestHandbookCards = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        req.setAttribute("banner", banner);

        req.setAttribute("handbooks",handbookCards.getData());
        req.setAttribute("currentPage",handbookCards.getCurrentPage());
        req.setAttribute("totalElements",handbookCards.getTotalElements());
        req.setAttribute("totalPages",handbookCards.getTotalPages());

        req.setAttribute("suggestHandbooks", suggestHandbookCards.getData());
        req.getRequestDispatcher("/handbook.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
//        ProductCriteria productCriteria = new ProductCriteria(keyword);
//
//        Pagination<ProductManagementDTO> products = productService.findByCriteria(productCriteria);
//
//        req.setAttribute("keyword", keyword);
//        req.setAttribute("products", products.getData());
        req.getRequestDispatcher("/handbook.jsp").forward(req, resp);
    }
}
