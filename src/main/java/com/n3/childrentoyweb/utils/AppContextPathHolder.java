package com.n3.childrentoyweb.utils;

public class AppContextPathHolder {
    private static String contextPath;

    public static void setContextPath(String cp) {
        contextPath = cp;
    }

    public static String getContextPath() {
        return contextPath;
    }
}
