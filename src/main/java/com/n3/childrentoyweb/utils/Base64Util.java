package com.n3.childrentoyweb.utils;

import java.util.Base64;

public class Base64Util {

    public static byte[] decodeBase64Image(String base64Image) {
        // Tách header nếu có
        if (base64Image.contains(",")) {
            base64Image = base64Image.split(",")[1];
        }
        return Base64.getDecoder().decode(base64Image);
    }

}
