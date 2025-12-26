package com.n3.childrentoyweb.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jdbi.v3.core.mapper.ColumnMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class JsonColumnMapper implements ColumnMapper<Map<String, String>> {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    public Map<String, String> map(ResultSet rs, int columnNumber, StatementContext ctx)
            throws SQLException {

        String json = rs.getString(columnNumber);
        if (json == null || json.isEmpty()) return null;

        try {
            return mapper.readValue(json, new TypeReference<Map<String, String>>() {});
        } catch (Exception e) {
            throw new SQLException("Cannot map JSON to Map<String,String>", e);
        }
    }
}
