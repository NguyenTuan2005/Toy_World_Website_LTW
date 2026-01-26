package com.n3.childrentoyweb.controllers.admin;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.n3.childrentoyweb.dto.HandbookDTO;
import com.n3.childrentoyweb.dto.HandbookDetailDTO;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/admin/edit-handbooks")
public class EditHandbookController extends HttpServlet {
    private HandBookService handBookService;
    private CategoryHbService categoryHbService;

    @Override
    public void init() throws ServletException {
        this.handBookService = new HandBookService();
        this.categoryHbService =new CategoryHbService();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.loadHandbookDetail(req);
        this.addCategoryOfHandbook(req);
        req.getRequestDispatcher("/adminPages/edit-handbook.jsp").forward(req,resp);
    }

    private void loadHandbookDetail(HttpServletRequest request){
        if(request.getParameter("id")== null){
            System.out.println("Not found");
        }

        long handbookId = Long.parseLong(request.getParameter("id"));
        HandbookDetailDTO handbookDetailDTO = this.handBookService.findHandbookDetailById(handbookId);

        request.setAttribute("title",handbookDetailDTO.getTitle());
        request.setAttribute("createdAt",handbookDetailDTO.getCreated());
        request.setAttribute("status",handbookDetailDTO.getStatus());
        request.setAttribute("handbookId",handbookDetailDTO.getId());

        request.setAttribute("userId",handbookDetailDTO.getUserId());
        request.setAttribute("username",handbookDetailDTO.getFullName());

        request.setAttribute("categoryName",handbookDetailDTO.getCategoryName());
        request.setAttribute("categoryId",handbookDetailDTO.getCategoryId());

        List<Map<String, String>> sanitizedParagraphs = handBookService.getSanitizedParagraphs(handbookDetailDTO);

        request.setAttribute("paragraphs", sanitizedParagraphs);

    }

    private void addCategoryOfHandbook(HttpServletRequest request){
        List<CategoryHb> categoryHbs = this.categoryHbService.findAll();
        request.setAttribute("categoryOfHB",categoryHbs);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        try {
            StringBuilder jsonString = new StringBuilder();
            String line;
            BufferedReader reader = req.getReader();

            while ((line = reader.readLine()) != null) {
                jsonString.append(line);
            }

            JsonObject postData = gson.fromJson(jsonString.toString(), JsonObject.class);

            long handbookId = Long.parseLong(postData.get("id").getAsString());
            String title = postData.get("title").getAsString();
            String category = postData.get("category").getAsString();
            long categoryId = Long.parseLong(category);


            JsonArray paragraphsJonArray = postData.getAsJsonArray("paragraphs");
            List<ParagraphDTO> paragraphsList = this.readParagraphsArray(paragraphsJonArray, handbookId);

            HandbookDTO handbookDTO = new HandbookDTO();
            handbookDTO.setId(handbookId);
            handbookDTO.setTitle(title);
            handbookDTO.setParagraphs(paragraphsList);

            Long postedUserId = this.getUserIdFromSession(req);
            handbookDTO.setPostedUserId(postedUserId);

            handbookDTO.hidden();
            handbookDTO.setCategoryId(categoryId);

            this.handBookService.updateFullHandbook(handbookDTO);

            resp.getWriter().write("{\"success\": true, \"message\": \"Sửa bài viết thành công!\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(e.getMessage());
        }
    }

    public Long getUserIdFromSession(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        User currentUser =(User) session.getAttribute("currentUser");
        return currentUser.getId();
    }

    private List<ParagraphDTO>  readParagraphsArray(JsonArray  paragraphsJonArray, Long handbookId){
        List<ParagraphDTO> paragraphDTOS = new ArrayList<>();

        for (int i = 0; i < paragraphsJonArray.size(); i++) {

            JsonObject paragraphObj = paragraphsJonArray.get(i).getAsJsonObject();

            Long id = null;
            if (paragraphObj.has("paragraphId") && !paragraphObj.get("paragraphId").isJsonNull()) {
                String paragraphIdStr = paragraphObj.get("paragraphId").getAsString();
                if (paragraphIdStr != null && !paragraphIdStr.trim().isEmpty()) {
                    id = Long.parseLong(paragraphIdStr);
                }
            }
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
            paragraph.setId(id);
            paragraph.setIndex( index);
            paragraph.setTitle(pTitle);
            paragraph.setContent(content);
            paragraph.setImageBase64(imageBase64);
            paragraph.setHandbookId(handbookId);

            paragraphDTOS.add(paragraph);
        }
        return paragraphDTOS;
    }
}
