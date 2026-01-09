package com.n3.childrentoyweb.utils;

import jakarta.servlet.ServletContext;

public class EndpointUtil {
    public static void printAllEndpoints(ServletContext context) {

        context.getServletRegistrations()
                .forEach((name, reg) -> {
                    System.out.println("Servlet: " + name);
                    System.out.println("Mappings: " + reg.getMappings());
                    System.out.println("----------------------");
                });
    }
}
