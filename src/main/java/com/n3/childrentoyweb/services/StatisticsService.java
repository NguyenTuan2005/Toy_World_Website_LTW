package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dao.UserDAO;

import java.util.HashMap;
import java.util.Map;

public class StatisticsService {

    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;

    public StatisticsService() {
        this.orderDAO = new OrderDAO();
        this.productDAO = new ProductDAO();
        this.userDAO = new UserDAO();
    }

    private double calculateRate(double current, double previous) {
        if (previous == 0) return current > 0 ? 100.0 : 0.0;
        double rate = ((current - previous) / previous) * 100;
        return Math.round(rate * 100.0) / 100.0;
    }

    public Map<String, Double> getGrowthRates(int year, int month) {

        int previousMonth = (month == 1) ? 12 : month - 1;
        int previousYear = (month == 1) ? year - 1 : year;


        double currRevenue = orderDAO.calculateRevenueInMonth(year, month);
        double currOrder = (double) orderDAO.countAllInMonth(year, month);
        double currProduct = (double) productDAO.countProductInMonth(year, month);
        double currUser = (double) userDAO.countAllInMonth(year, month);

        double prevRevenue = orderDAO.calculateRevenueInMonth(previousYear, previousMonth);
        double prevOrder = (double) orderDAO.countAllInMonth(previousYear, previousMonth);
        double prevProduct = (double) productDAO.countProductInMonth(previousYear, previousMonth);
        double prevUser = (double) userDAO.countAllInMonth(previousYear, previousMonth);


        System.out.println(currRevenue);
        System.out.println(prevRevenue+"\n");

        System.out.println(currOrder);
        System.out.println(prevOrder+"\n");

        System.out.println(currProduct);
        System.out.println(prevProduct+"\n");

        System.out.println(currUser);
        System.out.println(prevUser);


        Map<String, Double> rates = new HashMap<>();
        rates.put("revenueGrowth", calculateRate(currRevenue, prevRevenue));
        rates.put("orderGrowth", calculateRate(currOrder, prevOrder));
        rates.put("productGrowth", calculateRate(currProduct, prevProduct));
        rates.put("userGrowth", calculateRate(currUser, prevUser));

        return rates;
    }




    public static void main(String[] args) {
        System.out.println(new StatisticsService().getGrowthRates(2026, 1));
    }
}