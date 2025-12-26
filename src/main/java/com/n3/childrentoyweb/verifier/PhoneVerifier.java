package com.n3.childrentoyweb.verifier;

import java.util.regex.Pattern;

public class PhoneVerifier implements Verifier{
    public static final Pattern PHONE_PATTERN = Pattern.compile(
            "^(0)[0-9]{9,10}$"
    );

    @Override
    public boolean verify(String input) throws IllegalArgumentException {
        if(input != null && PHONE_PATTERN.matcher(input).matches()) return true;
        else throw new IllegalArgumentException("Số điện thoại không hợp lệ");
    }
}
