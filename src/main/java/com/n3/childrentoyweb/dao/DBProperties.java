package com.n3.childrentoyweb.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBProperties {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = DBProperties.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find db.properties file");
            }
            properties.load(input);
        } catch (IOException e) {
            throw new RuntimeException("Error loading db.properties file", e);
        }
    }

    public static final String HOST = properties.getProperty("db.host");
    public static final String PORT = properties.getProperty("db.port");
    public static final String DBNAME = properties.getProperty("db.dbname");
    public static final String USERNAME = properties.getProperty("db.username");
    public static final String PASSWORD = properties.getProperty("db.password");
}
