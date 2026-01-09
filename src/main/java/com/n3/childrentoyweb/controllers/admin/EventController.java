package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.EventService;
import com.n3.childrentoyweb.services.PromotionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@WebServlet(value = "/admin-x/events")
public class EventController extends HttpServlet {
    private EventService eventService;
    private PromotionService promotionService;
    private BannerService bannerService;
    public static final int  PAGE_SIZE = 10;

    public void init(){
        this.eventService = new EventService();
        this.promotionService = new PromotionService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.addStatisticEvent(req);
        this.addEventsPagination(req);
        req.getRequestDispatcher("/adminPages/events.jsp").forward(req,resp);
    }

    private void addStatisticEvent(HttpServletRequest request){
        int total = eventService.getTotalEvent();
        int ongoing = eventService.getOngoingEvent();
        int upcoming = eventService.getUpcomingEvent();
        int ended = eventService.getEndedEvent();

        request.setAttribute("total_events",total);
        request.setAttribute("total_in_process",ongoing);
        request.setAttribute("total_by_take_place",upcoming);
        request.setAttribute("total_done",ended);
    }


    private void addEventsPagination( HttpServletRequest request){
        int page = 1;
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page").trim());

        Pagination<Event> eventPagination = this.eventService.findEventForManagement(page,PAGE_SIZE);
        System.out.println(eventPagination);
        request.setAttribute("events",eventPagination.getData());
        request.setAttribute("currentPage",eventPagination.getCurrentPage());
        request.setAttribute("totalElements",eventPagination.getTotalElements());
        request.setAttribute("totalPages",eventPagination.getTotalPages());
        request.setAttribute("pageSize",PAGE_SIZE);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("id") == null){
            throw new ObjectNotFoundException();
        }

        long id = Long.parseLong(req.getParameter("id"));
        System.out.println("ID : "+id);
        Event event = this.eventService.findEventById(id).orElseThrow(ObjectNotFoundException::new);

        event.revertActive();

        this.eventService.updateEvent(event);

        String message = (event.getActive())? "Ẩn sự kiện " :"Hiện thị sự kiện ";
        req.setAttribute("notify", message+ event.getName() + LocalDate.now());

        this.addStatisticEvent(req);
        this.addEventsPagination(req);
        req.getRequestDispatcher("/adminPages/events.jsp").forward(req,resp);
    }

}
