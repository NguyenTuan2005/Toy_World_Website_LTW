package com.n3.childrentoyweb.exception;

public class OTPInvalidException extends RuntimeException{
    private String message;

    public OTPInvalidException(String message){
        super(message);
        this.message = message;
    }
}
