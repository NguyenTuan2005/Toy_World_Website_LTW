package com.n3.childrentoyweb.dao;

import  java.util.List;

public class Pagination <T>{
    private List<T> data;
    private int currentPage;
    private int totalElements;
    private int totalPages;

    public Pagination(List<T> data, int currentPage, int totalElements, int totalPages) {
        this.data = data;
        this.currentPage = currentPage;
        this.totalElements = totalElements;
        this.totalPages = totalPages;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "Pagination{" +
                "data=" + data +
                ", currentPage=" + currentPage +
                ", totalElements=" + totalElements +
                ", totalPages=" + totalPages +
                '}';
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalElements() {
        return totalElements;
    }

    public void setTotalElements(int totalElements) {
        this.totalElements = totalElements;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
}
