package com.n3.childrentoyweb.controllers.antbmhttt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet(name = "download-tool", value = "/download-tool")
public class DownloadToolController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("table_atbmhttt/table_public_keys.sql");

        if (inputStream == null) {
            request.setAttribute("error", "Không tìm thấy file");
            request.getRequestDispatcher("/tool.jsp").forward(request, response);
            return;
        }

        response.setContentType("application/octet-stream");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"table_public_keys.sql\""
        );

        try (
                BufferedInputStream bis = new BufferedInputStream(inputStream);
                BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())
        ) {
            byte[] buffer = new byte[1080];
            int bytesRead;

            while ((bytesRead = bis.read(buffer)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }

            bos.flush();
        }
    }
}
