package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.HandbookDTO;
import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.dto.ParagraphDTO;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.models.HandbookCategory;
import com.n3.childrentoyweb.models.Paragraph;
import com.n3.childrentoyweb.models.User;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class HandBookService {
    private HandbookDAO handbookDAO;
    private ParagraphDAO paragraphDAO;
    private UserDAO userDAO;
    private HandbookCategoryDAO handbookCategoryDAO;

    private CloudinaryService cloudinaryService;


    public HandBookService(){
        this.handbookDAO = new HandbookDAO();
        this.paragraphDAO = new ParagraphDAO();
        this.userDAO = new UserDAO();
        this.handbookCategoryDAO = new HandbookCategoryDAO();

        this.cloudinaryService = new CloudinaryService();
    }

    public long save(Handbook handbook){
        return this.handbookDAO.save(handbook);
    }

    // chua final
    public void saveFullHandbook(HandbookDTO handbookDTO){
        Handbook handbook = new Handbook();
        handbook.setTitle(handbookDTO.getTitle());
        handbook.setStatus(handbookDTO.getStatus());
        handbook.setUserId(handbookDTO.getPostedUserId());

        long handbookId = this.handbookDAO.save(handbook);
        System.out.println("handBookId = "+handbookId);

        int LIMIT_THREADS = 2;
        ExecutorService executor = Executors.newFixedThreadPool(LIMIT_THREADS);

        HandbookCategory handbookCategory = new HandbookCategory(handbookDTO.getCategoryId(),handbookId);
        executor.submit(() -> {
            long hbcId = this.handbookCategoryDAO.save(handbookCategory);
            System.out.println("handbookCategoryId "+hbcId);
            return null;
        });

        for(ParagraphDTO paragraphDTO : handbookDTO.getParagraphs()){
            executor.submit(() -> {
                this.saveParagraph(handbookId,paragraphDTO);
                return null;
            });
        }
    }

    private void saveParagraph(long handbookId,ParagraphDTO paragraphDTO){
        boolean isNotImage = paragraphDTO.getImageBase64() == null || paragraphDTO.getImageBase64().isEmpty();
        String url =null;
        if(!isNotImage)
            url = cloudinaryService.upload(paragraphDTO.getImageBase64());

        Paragraph paragraph = new Paragraph(paragraphDTO.getTitle(),paragraphDTO.getContent(),url,"img description", paragraphDTO.getIndex(), handbookId);
        long pId = this.paragraphDAO.save(paragraph);

        System.out.println("paragraphID = "+pId);
    }

    public HandbookDetailDTO findHandbookDetailById(long id){
        Handbook handbook = this.handbookDAO.findById(id);

        CompletableFuture<User> userCompletableFuture =  CompletableFuture.supplyAsync(()->this.userDAO.findById(handbook.getUserId()));
        CompletableFuture<List<Paragraph>> paragraphsCompletableFuture = CompletableFuture.supplyAsync(()-> this.paragraphDAO.findAllByHandbookId(handbook.getId()));

        try {
            CompletableFuture<HandbookDetailDTO> handbookDetailDTOCompletableFuture =
                    userCompletableFuture.thenCombine(paragraphsCompletableFuture, (user, paragraphs) -> {
                        HandbookDetailDTO handbookDetailDTO = new HandbookDetailDTO();
                        handbookDetailDTO.setId(handbook.getId());
                        handbookDetailDTO.setTitle(handbook.getTitle());
                        handbookDetailDTO.setCreated(handbook.getCreatedAt());

                        handbookDetailDTO.setUserId(user.getId());
                        handbookDetailDTO.setFullName(user.getFirstName() + " "+user.getLastName());


                        handbookDetailDTO.setCategoryId(-1);
                        handbookDetailDTO.setCategoryName("Category name deo co");

                        handbookDetailDTO.setParagraphs(paragraphs);
                        return handbookDetailDTO;
                    });
            return handbookDetailDTOCompletableFuture.get();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        HandBookService handBookService = new HandBookService();
        System.out.println(handBookService.findHandbookDetailById(4));
    }
}
