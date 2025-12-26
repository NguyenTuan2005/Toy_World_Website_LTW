package com.n3.childrentoyweb.exception;

public class EmailInvalidException extends RuntimeException{
    private String message;

    public EmailInvalidException(String message){
       super(message);
        this.message = message;
    }


}
