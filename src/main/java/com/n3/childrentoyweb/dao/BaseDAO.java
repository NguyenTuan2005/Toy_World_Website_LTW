package com.n3.childrentoyweb.dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import static com.n3.childrentoyweb.dao.ApplicationProperties.*;


public abstract class BaseDAO {
    protected Jdbi jdbi;
    private static MysqlDataSource dataSource;

    protected Jdbi getJdbi() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }
    private void connect() {
        if (dataSource == null) {
            dataSource = new MysqlDataSource();
        }
        dataSource.setUrl("jdbc:mysql://" + HOST
                                    + ":" + PORT
                                    + "/" + DBNAME
        );
        dataSource.setUser(USERNAME);
        dataSource.setPassword(PASSWORD);
        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        jdbi = Jdbi.create(dataSource);
        jdbi.open();
    }
}
