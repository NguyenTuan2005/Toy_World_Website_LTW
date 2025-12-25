package com.n3.childrentoyweb.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LocalDateTimeConverterUtil {
    public static LocalDateTime convertToLocalDateTime(String createdAt){
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        LocalDateTime dateTime = LocalDateTime.parse(createdAt, formatter);

        return dateTime;
    }
}
