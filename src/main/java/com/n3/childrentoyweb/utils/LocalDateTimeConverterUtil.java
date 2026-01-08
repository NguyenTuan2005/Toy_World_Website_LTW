package com.n3.childrentoyweb.utils;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LocalDateTimeConverterUtil {

    private static final DateTimeFormatter FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static LocalDateTime convertToLocalDateTime(String createdAt){
        return LocalDateTime.parse(createdAt, FORMATTER);
    }

    public static String convertToString(LocalDateTime createdAt) {
        return createdAt == null ? "" : createdAt.format(FORMATTER);
    }

    public static String convertToTimeAgo(LocalDateTime createdAt) {
        if (createdAt == null) return "";

        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(createdAt, now);

        long seconds = duration.getSeconds();

        if (seconds < 60) {
            return "vừa xong";
        }

        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes + " phút trước";
        }

        long hours = minutes / 60;
        if (hours < 24) {
            return hours + " giờ trước";
        }

        long days = hours / 24;
        if (days < 7) {
            return days + " ngày trước";
        }

        long weeks = days / 7;
        if (weeks < 4) {
            return weeks + " tuần trước";
        }

        long months = days / 30;
        if (months < 12) {
            return months + " tháng trước";
        }

        long years = days / 365;
        return years + " năm trước";
    }
}
