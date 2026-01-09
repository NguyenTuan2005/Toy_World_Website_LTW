package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.EventService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/new-events")
public class NewEventController extends HttpServlet {

    private EventService eventService;

    @Override
    public void init() throws ServletException {
        this.eventService = new EventService();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("isNewEvent", true);
        req.getRequestDispatcher("/adminPages/new-events.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String eventName = request.getParameter("eventName");
        String eventType = request.getParameter("eventType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // In ra console
        System.out.println("===== NEW EVENT =====");
        System.out.println("Tên: " + eventName);
        System.out.println("Loại: " + eventType);
        System.out.println("Bắt đầu: " + startDate);
        System.out.println("Kết thúc: " + endDate);
        System.out.println("Mô tả: " + description);
        System.out.println("Trạng thái: " + status);
        try {
            Event event = new Event();

            event.setName(eventName);
            event.setTypeEvent(eventType);
            event.setDescription(description);
            event.setActive(Boolean.parseBoolean(status));
            event.setOpenedAt(LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(startDate));
            event.setClosedAt(LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(endDate));
            request.setAttribute("isNewEvent", true);
            this.eventService.save(event);
        } catch (Exception e) {
            throw new  RuntimeException();
        }

        request.getRequestDispatcher("/adminPages/new-events.jsp").forward(request,resp);
    }
}
