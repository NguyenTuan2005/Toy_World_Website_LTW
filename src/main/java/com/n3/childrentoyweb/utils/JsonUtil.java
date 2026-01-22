package com.n3.childrentoyweb.utils;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import io.leangen.geantyref.TypeToken;

import java.lang.reflect.Type;
import java.util.Map;

public class JsonUtil {
    public static Map<String, String> parseProductRestInfo(String restInfoJson) {
        if (restInfoJson == null || restInfoJson.isBlank()) {
            return null;
        }

        try {
            Gson gson = new Gson();
            Type type = new TypeToken<Map<String, String>>(){}.getType();
            return gson.fromJson(restInfoJson, type);
        } catch (JsonSyntaxException e) {
            throw new IllegalArgumentException(e);
        }
    }

    public static String parseProductRestInfo(Map<String, String> restInfoMap) {
        if (restInfoMap == null || restInfoMap.isEmpty()) {
            return null;
        }

        return new Gson().toJson(restInfoMap);
    }
}
