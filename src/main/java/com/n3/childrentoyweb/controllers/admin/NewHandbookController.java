package com.n3.childrentoyweb.controllers.admin;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.n3.childrentoyweb.dto.HandbookDTO;
import com.n3.childrentoyweb.dto.ParagraphDTO;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/handbooks")
public class NewHandbookController extends HttpServlet {

    private HandBookService handBookService;

    public void init(){
        this.handBookService = new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/adminPages/handbook-demo.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Gson gson = new Gson();
        PrintWriter out = response.getWriter();
        try {
            // Bước 2: Đọc JSON từ request body
            StringBuilder jsonString = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();

            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }

            JsonObject postData = gson.fromJson(jsonString.toString(), JsonObject.class);

            String title = postData.get("title").getAsString();
            String category = postData.get("category").getAsString();

            System.out.println("titli: " + title);
            System.out.println("category " + category);

            // Bước 5: Đọc ARRAY paragraphs
            JsonArray paragraphsArray = postData.getAsJsonArray("paragraphs");
            List<ParagraphDTO> paragraphsList = new ArrayList<>();

            // Bước 6: Duyệt từng phần tử trong array
            for (int i = 0; i < paragraphsArray.size(); i++) {

                JsonObject paragraphObj = paragraphsArray.get(i).getAsJsonObject();

                int index = paragraphObj.get("index").getAsInt();

                String pTitle = "";
                if (paragraphObj.has("title") && !paragraphObj.get("title").isJsonNull()) {
                    pTitle = paragraphObj.get("title").getAsString();
                }

                String content = paragraphObj.get("content").getAsString();

                // Image có thể null
                String imageBase64 = null;
                if (paragraphObj.has("image") && !paragraphObj.get("image").isJsonNull()) {
                    imageBase64 = paragraphObj.get("image").getAsString();
                }

                ParagraphDTO paragraph = new ParagraphDTO();
                paragraph.setIndex( index);
                paragraph.setTitle(pTitle);
                paragraph.setContent(content);
                paragraph.setImageBase64(imageBase64);

                paragraphsList.add(paragraph);
            }

            paragraphsList.forEach(System.out::println);

            HandbookDTO handbookDTO = new HandbookDTO();
            handbookDTO.setTitle(title);
            handbookDTO.setCategory(category);
            handbookDTO.setParagraphs(paragraphsList);

            this.handBookService.saveFullHandbook(handbookDTO);

        } catch (Exception e) {
            e.printStackTrace();
            out.println(e.getMessage());
        }
        out.println("Ok dax luu");
    }
}
