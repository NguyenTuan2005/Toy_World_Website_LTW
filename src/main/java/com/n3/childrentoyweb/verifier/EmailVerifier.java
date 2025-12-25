package com.n3.childrentoyweb.verifier;

import java.util.regex.Pattern;

public class EmailVerifier implements Verifier{
    public static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    @Override
    public boolean verify(String input) throws IllegalArgumentException {
        if(input != null && EMAIL_PATTERN.matcher(input).matches()) return true;
        else throw new IllegalArgumentException("Email không hợp lệ");
    }
}
