package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dao.StatisticDAO;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.dto.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class StatisticService {

    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;
    private StatisticDAO statisticDAO;

    public StatisticService() {
        this.orderDAO = new OrderDAO();
        this.productDAO = new ProductDAO();
        this.userDAO = new UserDAO();
        this.statisticDAO = new StatisticDAO();
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

        Map<String, Double> rates = new HashMap<>();
        rates.put("revenueGrowth", calculateRate(currRevenue, prevRevenue));
        rates.put("orderGrowth", calculateRate(currOrder, prevOrder));
        rates.put("productGrowth", calculateRate(currProduct, prevProduct));
        rates.put("userGrowth", calculateRate(currUser, prevUser));

        return rates;
    }

    //    revenue chart
    public List<OrderAnalyticsDTO> getRevenue(String range) {
        if (range == null) {
            throw new IllegalArgumentException("range is required");
        }

        LocalDate today = LocalDate.now();
        LocalDate toDate = today.plusDays(1);

        switch (range) {

            case "30": {
                LocalDate from = today.minusDays(29);
                return fillMissingDays(
                        from,
                        toDate,
                        statisticDAO.revenueByDay(from, toDate)
                );
            }

            case "3month": {
                YearMonth from = YearMonth.now().minusMonths(2);
                YearMonth to = YearMonth.now();
                return fillMissingMonths(
                        from,
                        to,
                        statisticDAO.revenueByMonth(from.atDay(1), toDate)
                );
            }

            case "1year": {
                YearMonth from = YearMonth.now().minusMonths(11);
                YearMonth to = YearMonth.now();
                return fillMissingMonths(
                        from,
                        to,
                        statisticDAO.revenueByMonth(from.atDay(1), toDate)
                );
            }

            default: { // 7 ngày
                LocalDate from = today.minusDays(6);
                return fillMissingDays(
                        from,
                        toDate,
                        statisticDAO.revenueByDay(from, toDate)
                );
            }
        }
    }


    //order stat
    public List<OrderAnalyticsDTO> getOrderStats(String range) {

        if (range == null) {
            throw new IllegalArgumentException("range is required");
        }

        LocalDate today = LocalDate.now();
        LocalDate toDate = today.plusDays(1);

        switch (range) {

            case "30": {
                LocalDate from = today.minusDays(29);
                return fillMissingDays(
                        from,
                        toDate,
                        statisticDAO.orderByDay(from, toDate)
                );
            }

            case "3month": {
                YearMonth from = YearMonth.now().minusMonths(2);
                YearMonth to = YearMonth.now();
                return fillMissingMonths(
                        from,
                        to,
                        statisticDAO.orderByMonth(from.atDay(1), toDate)
                );
            }

            case "1year": {
                YearMonth from = YearMonth.now().minusMonths(11);
                YearMonth to = YearMonth.now();
                return fillMissingMonths(
                        from,
                        to,
                        statisticDAO.orderByMonth(from.atDay(1), toDate)
                );
            }

            default: { // 7 ngày
                LocalDate from = today.minusDays(6);
                return fillMissingDays(
                        from,
                        toDate,
                        statisticDAO.orderByDay(from, toDate)
                );
            }
        }
    }

    public List<OrderAnalyticsDTO> fillMissingDays(
            LocalDate from,
            LocalDate to,
            List<OrderAnalyticsDTO> data
    ) {
        DateTimeFormatter inputFmt = DateTimeFormatter.ISO_LOCAL_DATE;
        DateTimeFormatter outputFmt = DateTimeFormatter.ofPattern("dd/MM");

        Map<LocalDate, Long> rawData = data.stream()
                .collect(Collectors.toMap(
                        r -> LocalDate.parse(r.getLabel(), inputFmt),
                        OrderAnalyticsDTO::getValue
                ));

        List<OrderAnalyticsDTO> result = new ArrayList<>();

        for (LocalDate d = from; d.isBefore(to); d = d.plusDays(1)) {
            long value = rawData.getOrDefault(d, 0L);

            result.add(new OrderAnalyticsDTO(d.format(outputFmt), value));
        }

        return result;
    }

    public List<OrderAnalyticsDTO> fillMissingMonths(
            YearMonth from,
            YearMonth to,
            List<OrderAnalyticsDTO> data
    ) {
        DateTimeFormatter inputFmt = DateTimeFormatter.ofPattern("yyyy-MM");
        DateTimeFormatter outputFmt = DateTimeFormatter.ofPattern("MM/yyyy");

        Map<YearMonth, Long> rawData = data.stream()
                .collect(Collectors.toMap(
                        r -> YearMonth.parse(r.getLabel(), inputFmt),
                        OrderAnalyticsDTO::getValue
                ));

        List<OrderAnalyticsDTO> result = new ArrayList<>();

        for (YearMonth ym = from; !ym.isAfter(to); ym = ym.plusMonths(1)) {
            long value = rawData.getOrDefault(ym, 0L);

            result.add(new OrderAnalyticsDTO(
                    ym.format(outputFmt),
                    value
            ));
        }

        return result;
    }

    //  product stat
    public List<ProductStockStatDTO> getProductStockStat(int limit, String order) {
        if (!"asc".equalsIgnoreCase(order) && !"desc".equalsIgnoreCase(order)) {
            order = "desc";
        }

        return statisticDAO.topStockProduct(limit, order);
    }

    // order status stat
    public List<OrderAnalyticsDTO> getOrderStatusStat(String range) {
        if (range == null) {
            throw new IllegalArgumentException("range is required");
        }

        LocalDateTime to = LocalDate.now().plusDays(1).atStartOfDay();

        LocalDateTime from;

        switch (range) {

            case "30": {
                from = LocalDate.now().minusDays(29).atStartOfDay();
                break;
            }

            case "3month": {
                from = LocalDate.now().minusMonths(2).atStartOfDay();
                break;
            }

            case "1year": {
                from = LocalDate.now().minusMonths(11).atStartOfDay();
                break;
            }

            default: {
                from = LocalDate.now().minusDays(6).atStartOfDay();
            }
        }

        return statisticDAO.countOrderByStatus(from, to);
    }

    public List<PaymentMethodChartDTO> getPaymentMethodChart() {
        return this.statisticDAO.percentByPaymentMethod();
    }

    public List<ProductChartDTO> top3ProductByMonth(int month) {
        return this.statisticDAO.top3ProductByMonth(month, LocalDate.now().getYear());
    }

    public static void main(String[] args) {
        System.out.println(new StatisticService().getOrderStatusStat("30"));

    }
}