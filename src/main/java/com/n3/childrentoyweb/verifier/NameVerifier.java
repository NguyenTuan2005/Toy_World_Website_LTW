package com.n3.childrentoyweb.verifier;

public class NameVerifier implements Verifier {
    @Override
    public boolean verify(String input) throws IllegalArgumentException {
        if (input != null && !input.trim().isEmpty()) return true;
        else throw new IllegalArgumentException("Tên không hợp lệ");
    }
}
