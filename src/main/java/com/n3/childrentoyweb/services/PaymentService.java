package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.PaymentDAO;
import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.models.Payment;

import java.util.List;

public class PaymentService {
    private PaymentDAO paymentDAO;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
    }

    public List<PaymentMethod> findAllPaymentMethod() {
        return this.paymentDAO.findAllPaymentMethod();
    }

    public long findPaymentMethodIdByName(String paymentMethodName) {
        return this.paymentDAO.findPaymentMethodIdByName(paymentMethodName);
    }

    public void save(Payment payment) {
        this.paymentDAO.save(payment);
    }
}
