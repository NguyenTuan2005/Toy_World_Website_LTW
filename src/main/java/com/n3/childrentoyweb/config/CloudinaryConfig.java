package com.n3.childrentoyweb.config;

import com.cloudinary.Cloudinary;
import com.n3.childrentoyweb.dao.ApplicationProperties;

import java.util.HashMap;
import java.util.Map;

public class CloudinaryConfig {
    private static Cloudinary cloudinary;

    public static Cloudinary getCloudinary() {
        if (cloudinary == null) {
            Map<String, String> config = new HashMap<>();
            config.put("cloud_name", ApplicationProperties.CLOUDINARY_NAME);
            config.put("api_key",ApplicationProperties.CLOUDINARY_API_KEY);
            config.put("api_secret", ApplicationProperties.CLOUDINARY_SECRET_KEY);

            cloudinary = new Cloudinary(config);
        }
        return cloudinary;
    }
}

