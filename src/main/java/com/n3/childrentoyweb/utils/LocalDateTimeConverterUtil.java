package com.n3.childrentoyweb.utils;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class LocalDateTimeConverterUtil {

    private static final DateTimeFormatter FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private static final DateTimeFormatter HTML_FORMAT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

    public static LocalDateTime convertToLocalDateTime(String createdAt){
        return LocalDateTime.parse(createdAt, FORMATTER);
    }

    public static LocalDateTime convertHTMLDateToLocalDateTime(String createdAt){
        return LocalDateTime.parse(createdAt, HTML_FORMAT);
    }

    public static String convertToString(LocalDateTime createdAt) {
        return createdAt == null ? "" : createdAt.format(FORMATTER);
    }

    public static LocalDateTime convertDateStringToLocalDateTime(String dateStr) {
        LocalDate localDate = LocalDate.parse(dateStr);
        return localDate.atStartOfDay();
    }

    public static String convertToTimeAgo(LocalDateTime createdAt) {
        if (createdAt == null) return "";

        LocalDateTime now = LocalDateTime.now();

        long seconds = ChronoUnit.SECONDS.between(createdAt, now);
        if (seconds < 60) return "vừa xong";

        long minutes = ChronoUnit.MINUTES.between(createdAt, now);
        if (minutes < 60) return minutes + " phút trước";

        long hours = ChronoUnit.HOURS.between(createdAt, now);
        if (hours < 24) return hours + " giờ trước";

        long days = ChronoUnit.DAYS.between(createdAt, now);
        if (days < 7) return days + " ngày trước";

        if (days < 30) return (days / 7) + " tuần trước";

        long months = ChronoUnit.MONTHS.between(createdAt, now);
        if (months < 12) return months + " tháng trước";

        long years = ChronoUnit.YEARS.between(createdAt, now);
        return years + " năm trước";
    }

}
