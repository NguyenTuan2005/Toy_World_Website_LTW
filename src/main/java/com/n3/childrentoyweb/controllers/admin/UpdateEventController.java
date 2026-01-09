package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.EventService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/update-events")
public class UpdateEventController extends HttpServlet {

    private EventService eventService;

    @Override
    public void init() throws ServletException {
        this.eventService = new EventService();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.loadEvent(req);
        req.getRequestDispatcher("/adminPages/update-event.jsp").forward(req, resp);
    }

    private void loadEvent(HttpServletRequest req){
        if(req.getParameter("id") == null){
            System.out.println("ok");
            throw new ObjectNotFoundException();
        }

        long id = Long.parseLong(req.getParameter("id"));
        Event event = this.eventService.findEventById(id).orElseThrow(ObjectNotFoundException::new);
        req.setAttribute("event", event);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.updateEvent(req);
        resp.sendRedirect(req.getHeader("Referer"));
    }

    private void updateEvent(HttpServletRequest request){
        if(request.getParameter("id") == null){
            throw new ObjectNotFoundException();
        }
        String eventName = request.getParameter("eventName");
        String eventType = request.getParameter("eventType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        long id = Long.parseLong(request.getParameter("id"));

        // In ra console
        System.out.println("===== NEW EVENT =====");
        System.out.println("Tên: " + eventName);
        System.out.println("Loại: " + eventType);
        System.out.println("Bắt đầu: " + startDate);
        System.out.println("Kết thúc: " + endDate);
        System.out.println("Mô tả: " + description);
        System.out.println("Trạng thái: " + status);
        try {
            Event event = this.eventService.findEventById(id).orElseThrow(ObjectNotFoundException::new);

            event.setName(eventName);
            event.setTypeEvent(eventType);
            event.setDescription(description);
            event.setActive(Boolean.parseBoolean(status));
            event.setOpenedAt(LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(startDate));
            event.setClosedAt(LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(endDate));
            this.eventService.updateEvent(event);
        } catch (Exception e) {
            throw new  RuntimeException();
        }
    }
}
