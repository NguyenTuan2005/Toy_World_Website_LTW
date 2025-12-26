package com.n3.childrentoyweb.utils;

import java.security.MessageDigest;

public class MD5Util {
    public static String encryptMd5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String md5HashToString(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(password.getBytes("UTF-8"));
            int h = 0;
            if (digest.length < 4) {
                for (byte b : digest) {
                    h = (h << 8) | (b & 0xFF);
                }
            } else {
                h = ((digest[0] & 0xFF) << 24)
                        | ((digest[1] & 0xFF) << 16)
                        | ((digest[2] & 0xFF) << 8)
                        | (digest[3] & 0xFF);
            }
            return String.valueOf(h);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
