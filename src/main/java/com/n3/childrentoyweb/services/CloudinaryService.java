package com.n3.childrentoyweb.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.n3.childrentoyweb.config.CloudinaryConfig;
import com.n3.childrentoyweb.utils.Base64Util;
import jakarta.servlet.http.Part;

import java.io.InputStream;
import java.util.Base64;
import java.util.Map;

public class CloudinaryService {

    public String upload(Part filePart) {
        try {

            byte[] fileBytes;
            try (InputStream is = filePart.getInputStream()) {
                fileBytes = is.readAllBytes();
            }

            Cloudinary cloudinary = CloudinaryConfig.getCloudinary();

            Map uploadResult = cloudinary.uploader().upload(
                    fileBytes,
                    ObjectUtils.asMap(
                            "folder", "jsp_uploads",
                            "resource_type", "image"
//                            "access_mode", "public"
                    )
            );

            return uploadResult.get("secure_url").toString();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String upload(String base64Image){
        try {

            byte[] fileBytes = Base64Util.decodeBase64Image(base64Image);

            Cloudinary cloudinary = CloudinaryConfig.getCloudinary();

            Map uploadResult = cloudinary.uploader().upload(
                    fileBytes,
                    ObjectUtils.asMap(
                            "folder", "jsp_uploads",
                            "resource_type", "image",
                            "access_mode", "public"
                    )
            );

            return uploadResult.get("secure_url").toString();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
