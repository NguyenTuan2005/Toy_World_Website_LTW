package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.*;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.models.HandbookCategory;
import com.n3.childrentoyweb.models.Paragraph;
import com.n3.childrentoyweb.models.User;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;


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

        int LIMIT_THREADS = 2;
        ExecutorService executor = Executors.newFixedThreadPool(LIMIT_THREADS);
        try {
            HandbookCategory handbookCategory = new HandbookCategory(handbookDTO.getCategoryId(), handbookId);
            executor.submit(() -> {
                long hbcId = this.handbookCategoryDAO.save(handbookCategory);
                return null;
            });

            for (ParagraphDTO paragraphDTO : handbookDTO.getParagraphs()) {
                ParagraphDTO p = paragraphDTO;
                executor.submit(() -> {
                    this.saveParagraph(handbookId, p);
                    return null;
                });
            }
        } finally {
            executor.shutdown();
            try {
                if (!executor.awaitTermination(30, TimeUnit.SECONDS)) {
                    executor.shutdownNow();
                }
            } catch (InterruptedException e) {
                executor.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }

    private void saveParagraph(long handbookId,ParagraphDTO paragraphDTO){
        boolean isNotImage = paragraphDTO.getImageBase64() == null || paragraphDTO.getImageBase64().isEmpty();
        String url =null;
        if(!isNotImage)
            url = cloudinaryService.upload(paragraphDTO.getImageBase64());

        Paragraph paragraph = new Paragraph(paragraphDTO.getTitle(),paragraphDTO.getContent(),url,"img description", paragraphDTO.getIndex(), handbookId);
        long pId = this.paragraphDAO.save(paragraph);
    }

    public HandbookDetailDTO findHandbookDetailById(long id){
        Handbook handbook = this.handbookDAO.findById(id);

        CompletableFuture<User> userCompletableFuture =  CompletableFuture.supplyAsync(()->this.userDAO.findById(handbook.getUserId()));
        CompletableFuture<List<Paragraph>> paragraphsCompletableFuture = CompletableFuture.supplyAsync(()-> this.paragraphDAO.findAllByHandbookId(handbook.getId())
                .stream().sorted().toList());

        try {
            CompletableFuture<HandbookDetailDTO> handbookDetailDTOCompletableFuture =
                    userCompletableFuture.thenCombine(paragraphsCompletableFuture, (user, paragraphs) -> {
                        HandbookDetailDTO handbookDetailDTO = new HandbookDetailDTO();
                        handbookDetailDTO.setId(handbook.getId());
                        handbookDetailDTO.setTitle(handbook.getTitle());
                        handbookDetailDTO.setCreated(handbook.getCreatedAt());
                        handbookDetailDTO.setStatus(handbook.getStatus());

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

    public Optional<Handbook> findById(long handbookId) {
        return Optional.ofNullable(this.handbookDAO.findById(handbookId));
    }

    public boolean updateHandbook(Handbook handbook){
        return  this.handbookDAO.updateHandbook(handbook) > 0;
    }

    public Pagination<HandBookCardDTO> findHandbookCardByCriteria(HandBookCriteria handBookCriteria){
        List<HandBookCardDTO> handBookCardDTOS =  this.handbookDAO.findHandbookCardByCriteria(handBookCriteria);
        int totalElements  = handBookCardDTOS.size();
        int totalPages = totalElements / handBookCriteria.getPageSize();
        boolean hasLeftover = totalElements > totalPages * handBookCriteria.getPageSize();
        int currentPage = handBookCriteria.getCurrentPage() == null ? 1 : handBookCriteria.getCurrentPage();
        return new Pagination<>(handBookCardDTOS, currentPage,totalElements,totalPages + (hasLeftover ? 1 : 0));
    }

    public Pagination<HandBookCardDTO> findHandbookCardByCriteriaForManagement(HandBookCriteria handBookCriteria) {
        List<HandBookCardDTO> handBookCardDTOS =  this.handbookDAO.findHandbookCardByCriteria(handBookCriteria);
        int totalElements  = this.handbookDAO.countAll();
        int totalPages = totalElements / handBookCriteria.getPageSize();
        boolean hasLeftover = totalElements > totalPages * handBookCriteria.getPageSize();
        int currentPage = handBookCriteria.getCurrentPage() == null ? 1 : handBookCriteria.getCurrentPage();
        return new Pagination<>(handBookCardDTOS, currentPage,totalElements,totalPages + (hasLeftover ? 1:0));
    }

    public void updateFullHandbook(HandbookDTO handbookDTO) {
        Handbook handbook = new Handbook();
        handbook.setId(handbookDTO.getId());
        handbook.setTitle(handbookDTO.getTitle());
        handbook.setStatus(handbookDTO.getStatus());
        handbook.setUserId(handbookDTO.getPostedUserId());

        this.handbookDAO.updateHandbook(handbook);

        List<Paragraph> paragraphs = this.paragraphDAO.findAllByHandbookId(handbook.getId());
        List<ParagraphDTO> paragraphDTOS = handbookDTO.getParagraphs();

        Set<Long> existingIds = paragraphs.stream()
                .map(Paragraph::getId)
                .collect(Collectors.toSet());

        List<ParagraphDTO> saveParagraph = paragraphDTOS.stream()
                .filter(pdto -> pdto.getId() == null || !existingIds.contains(pdto.getId()))
                .toList();
        List<ParagraphDTO> updateParagraph = paragraphDTOS.stream()
                .filter(pdto -> pdto.getId() != null && existingIds.contains(pdto.getId()))
                .toList();

        Set<Long> remainIds = paragraphDTOS.stream()
                .map(ParagraphDTO::getId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        List<Paragraph> deleteParagraph = paragraphs.stream()
                .filter(paragraph ->  !remainIds.contains(paragraph.getId()))
                .toList();

        for (ParagraphDTO paragraphDTO : saveParagraph) {
            this.saveParagraph(handbook.getId(), paragraphDTO);
        }

        for (ParagraphDTO paragraphDTO : updateParagraph) {
            this.updateParagraph(handbook.getId(), paragraphDTO);
        }

        for (Paragraph paragraph : deleteParagraph) {
            this.deleteParagraph(paragraph);
        }
    }

    private void deleteParagraph(Paragraph paragraph) {
        this.paragraphDAO.deleteById(paragraph.getId());
    }

    private void updateParagraph(long id, ParagraphDTO paragraphDTO) {
        String url = paragraphDTO.isBase64Format() ? null : paragraphDTO.getImageBase64();
        if(paragraphDTO.isBase64Format())
            url = cloudinaryService.upload(paragraphDTO.getImageBase64());

        Paragraph paragraph = new Paragraph(paragraphDTO.getTitle(),paragraphDTO.getContent(),url,"img description", paragraphDTO.getIndex(), id);
        paragraph.setId(paragraphDTO.getId());
        this.paragraphDAO.update(paragraph);
    }
}
