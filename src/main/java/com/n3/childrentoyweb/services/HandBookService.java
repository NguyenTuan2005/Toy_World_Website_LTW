package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.HandBookDTO;
import com.n3.childrentoyweb.dao.HandbookDAO;
import com.n3.childrentoyweb.dao.ParagraphDAO;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.dto.HandbookDTO;
import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.dto.ParagraphDTO;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.models.Paragraph;
import com.n3.childrentoyweb.models.User;

import java.util.List;
import java.util.concurrent.CompletableFuture;

public class HandBookService {
    private HandbookDAO handbookDAO;
    private ParagraphDAO paragraphDAO;
    private UserDAO userDAO;
    private CloudinaryService cloudinaryService;

    public HandBookService(){
        this.handbookDAO = new HandbookDAO();
        this.paragraphDAO = new ParagraphDAO();
        this.userDAO = new UserDAO();

        this.cloudinaryService = new CloudinaryService();
    }

    public long save(Handbook handbook){
        return this.handbookDAO.save(handbook);
    }

    // chua final
    public void saveFullHandbook(HandbookDTO handbookDTO){
        Handbook handbook = new Handbook();
        handbook.setTitle(handbook.getTitle());
//        handbook.setCategoryHandBookId(1L);
        handbook.setStatus("POSTED");
        handbook.setUserId(1L);

        long handbookId = this.handbookDAO.save(handbook);
        System.out.println("handBookId = "+handbookId);

        for(ParagraphDTO paragraphDTO : handbookDTO.getParagraphs()){
            this.saveParagraph(handbookId,paragraphDTO);
        }
    }
    private void saveParagraph(long handbookId,ParagraphDTO paragraphDTO){
        String url = cloudinaryService.upload(paragraphDTO.getImageBase64());
        Paragraph paragraph = new Paragraph(paragraphDTO.getTitle(),paragraphDTO.getContent(),url,"img description", paragraphDTO.getIndex(), handbookId);
       long pId = this.paragraphDAO.save(paragraph);
        System.out.println("pID = "+pId);
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
