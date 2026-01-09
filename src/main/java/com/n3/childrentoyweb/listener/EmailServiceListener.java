package com.n3.childrentoyweb.listener;

import com.n3.childrentoyweb.services.EmailService;
import jakarta.servlet.annotation.WebListener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

@WebListener
public class EmailServiceListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        EmailService.getInstance().shutdown();
    }
}
