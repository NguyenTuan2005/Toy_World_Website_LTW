package com.n3.childrentoyweb.dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;

public abstract class BaseDAO {
    protected Jdbi jdbi;

    protected Jdbi get() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }
    private void connect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setUrl("jdbc:mysql://" + DBProperties.HOST
                                    + ":" + DBProperties.PORT
                                    + "/" + DBProperties.DBNAME
        );
        dataSource.setUser(DBProperties.USERNAME);
        dataSource.setPassword(DBProperties.PASSWORD);
        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        jdbi = Jdbi.create(dataSource);
    }
}
