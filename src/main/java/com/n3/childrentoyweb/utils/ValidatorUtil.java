package com.n3.childrentoyweb.utils;

import java.text.Normalizer;

public class ValidatorUtil {
    public static boolean isNumber(String value) {
        return value != null && value.matches("\\d+");
    }

    public static boolean isEmail(String value) {
        if (value == null) return false;

        return value.trim().matches(
                "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        );
    }


    public static boolean isPhone(String value) {
        return value != null &&
                value.matches("^0\\d{9,10}$");
    }

    public static boolean isFullName(String value) {
        if (value == null || value.isBlank()) return false;

        String normalized = Normalizer.normalize(value, Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");

        return normalized.matches("^[A-Za-z ]{2,}$");
    }
}
