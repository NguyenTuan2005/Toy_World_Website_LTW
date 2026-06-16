package com.n3.childrentoyweb.controllers.antbmhttt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/download-tool")
public class DownloadToolController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException, IOException {

        File file = new File("src/main/resources/table_atbmhttt/table_public_keys.sql");

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "File not found");
            return;
        }

        response.setContentType("application/octet-stream");
        response.setContentLengthLong(file.length());

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"" + file.getName() + "\""
        );
        try (BufferedInputStream bis =
                     new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream bos =
                     new BufferedOutputStream(response.getOutputStream())) {

            byte[] buffer = new byte[8192];
            int bytesRead;

            while ((bytesRead = bis.read(buffer)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }

            bos.flush();
        }
    }
}
