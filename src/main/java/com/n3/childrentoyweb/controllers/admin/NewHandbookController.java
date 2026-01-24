package com.n3.childrentoyweb.controllers.admin;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.n3.childrentoyweb.dto.HandbookDTO;
import com.n3.childrentoyweb.dto.ParagraphDTO;
import com.n3.childrentoyweb.models.CategoryHb;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.CategoryHbService;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/admin/new-handbooks")
public class NewHandbookController extends HttpServlet {

    private HandBookService handBookService;
    private CategoryHbService categoryHbSService;

    public void init(){
        this.handBookService = new HandBookService();
        this.categoryHbSService = new CategoryHbService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       this.addCategoryOfHandbook(req);
        req.getRequestDispatcher("/adminPages/new-handbook.jsp").forward(req, resp);
    }

    private void addCategoryOfHandbook(HttpServletRequest request){
        List<CategoryHb> categoryHbs = this.categoryHbSService.findAll();
        request.setAttribute("categoryOfHB",categoryHbs);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Gson gson = new Gson();
        PrintWriter out = response.getWriter();
        try {
            StringBuilder jsonString = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();

            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }

            JsonObject postData = gson.fromJson(jsonString.toString(), JsonObject.class);

            String title = postData.get("title").getAsString();
            String category = postData.get("category").getAsString();
            long categoryId = Long.parseLong(category);

            JsonArray paragraphsJonArray = postData.getAsJsonArray("paragraphs");
            List<ParagraphDTO> paragraphsList = this.readParagraphsArray(paragraphsJonArray);

            HandbookDTO handbookDTO = new HandbookDTO();
            handbookDTO.setTitle(title);
            handbookDTO.setParagraphs(paragraphsList);

            Long postedUserId = this.getUserIdFromSession(request);
            handbookDTO.setPostedUserId(postedUserId);

            handbookDTO.hidden();
            handbookDTO.setCategoryId(categoryId);

            this.handBookService.saveFullHandbook(handbookDTO);

            response.getWriter().write("{\"success\": true, \"message\": \"Thêm sản phẩm thành công!\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(e.getMessage());
        }
    }

    public Long getUserIdFromSession(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        User currentUser =(User) session.getAttribute("currentUser");
        return currentUser.getId();
    }

    private List<ParagraphDTO>  readParagraphsArray(JsonArray  paragraphsJonArray){
        List<ParagraphDTO> paragraphDTOS = new ArrayList<>();

        for (int i = 0; i < paragraphsJonArray.size(); i++) {

            JsonObject paragraphObj = paragraphsJonArray.get(i).getAsJsonObject();

            int index = paragraphObj.get("index").getAsInt();

            String pTitle = "";
            if (paragraphObj.has("title") && !paragraphObj.get("title").isJsonNull()) {
                pTitle = paragraphObj.get("title").getAsString();
            }

            String content = paragraphObj.get("content").getAsString();

            String imageBase64 = null;
            if (paragraphObj.has("image") && !paragraphObj.get("image").isJsonNull()) {
                imageBase64 = paragraphObj.get("image").getAsString();
            }

            ParagraphDTO paragraph = new ParagraphDTO();
            paragraph.setIndex( index);
            paragraph.setTitle(pTitle);
            paragraph.setContent(content);
            paragraph.setImageBase64(imageBase64);

            paragraphDTOS.add(paragraph);
        }
        return paragraphDTOS;
    }
}
