package com.n3.childrentoyweb.controllers.admin.orders;

import com.n3.childrentoyweb.dto.AdminOrderListDTO;
import com.n3.childrentoyweb.services.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/admin/orders")
public class OrderController extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init(){
        orderService = new OrderService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String sortType = request.getParameter("sort");
        if (sortType == null || sortType.isBlank()) {
            sortType = "newest";
        }

        String searchKeyword = request.getParameter("q");

        List<AdminOrderListDTO> orders = orderService.findAll(searchKeyword,sortType, page);
        int totalPages = orderService.getTotalPages();

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders",orderService.countAll());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/adminPages/orders/orders.jsp")
                .forward(request, response);;

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}