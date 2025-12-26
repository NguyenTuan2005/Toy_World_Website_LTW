package com.n3.childrentoyweb.utils;

import java.util.Random;

public class OTPUtil {
    public static String generate() {
        return String.format("%06d", new Random().nextInt(999999));
    }
}
