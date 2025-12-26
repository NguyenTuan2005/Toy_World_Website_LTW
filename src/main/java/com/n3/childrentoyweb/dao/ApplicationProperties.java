package com.n3.childrentoyweb.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApplicationProperties {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = ApplicationProperties.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find application.properties file");
            }
            properties.load(input);
        } catch (IOException e) {
            throw new RuntimeException("Error loading application.properties file", e);
        }
    }

    public static final String HOST = properties.getProperty("db.host");
    public static final String PORT = properties.getProperty("db.port");
    public static final String DBNAME = properties.getProperty("db.dbname");
    public static final String USERNAME = properties.getProperty("db.username");
    public static final String PASSWORD = properties.getProperty("db.password");


    public static final String SMTP_AUTH = properties.getProperty("mail.smtp.auth");;
    public static final String SMTP_STARTTLS = properties.getProperty("mail.smtp.starttls.enable");;
    public static final String SMTP_HOST = properties.getProperty("mail.smtp.host");;
    public static final String SMTP_PORT = properties.getProperty("mail.smtp.port");
    public static final String SMTP_USERNAME = properties.getProperty("mail.username");
    public static final String SMTP_PASSWORD = properties.getProperty("mail.password");

    public static final int OTP_DELAY_IN_SECOND = Integer.parseInt(properties.getProperty("otp.delay-in-second"));

    public static final String SIGNATURE_BRAND_NAME = properties.getProperty("home-page.signature-brand-name");
    public static  final int DISPLAY_PRODUCT_SIZE = Integer.parseInt(properties.getProperty("home-page.display-product-size"));
}
