package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/find-events")
public class FindEventController extends HttpServlet {

    private EventService eventService;

    @Override
    public void init() throws ServletException {
        this.eventService = new EventService();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.addStatisticEvent(req);
        this.findEventsPagination(req);
        req.getRequestDispatcher("/adminPages/events.jsp").forward(req,resp);
    }

    private void findEventsPagination( HttpServletRequest request){
        String eventName = request.getParameter("keyword");
        System.out.println("->"+eventName);

        Pagination<Event> eventPagination = this.eventService.findEventByName(eventName);
        System.out.println(eventPagination);
        request.setAttribute("events",eventPagination.getData());
        request.setAttribute("currentPage",eventPagination.getCurrentPage());
        request.setAttribute("totalElements",eventPagination.getTotalElements());
        request.setAttribute("totalPages",eventPagination.getTotalPages());
        request.setAttribute("pageSize",10);
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
}
