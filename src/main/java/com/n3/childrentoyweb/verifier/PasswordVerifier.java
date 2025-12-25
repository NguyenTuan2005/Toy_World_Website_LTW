package com.n3.childrentoyweb.verifier;

import java.util.regex.Pattern;

public class PasswordVerifier implements Verifier{
    public static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    );

    @Override
    public boolean verify(String input) throws IllegalArgumentException {
        if (input != null && PASSWORD_PATTERN.matcher(input).matches()) return true;
        else throw new IllegalArgumentException("Mật khẩu không hợp lệ vui lòng nhập lại");
    }
}
