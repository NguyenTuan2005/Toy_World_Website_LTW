package com.n3.childrentoyweb.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dao.PaymentDAO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.enums.PaymentStatus;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderSignature;
import com.n3.childrentoyweb.models.Payment;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

public class PaymentService {
    private PaymentDAO paymentDAO;
    private OrderDAO orderDAO;
    private OrderSignatureDAO orderSignatureDAO;
    private OrderSignatureService orderSignatureService;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
        this.orderDAO = new OrderDAO();
        this.orderSignatureDAO = new OrderSignatureDAO();
        this.orderSignatureService = new OrderSignatureService(new OrderSignatureDAO(), new OrderDAO());
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

    public void checkout(long userId, long orderId, String paymentMethodName) throws NoSuchAlgorithmException, InvalidKeySpecException, SignatureException, InvalidKeyException, JsonProcessingException {

        Order order = orderDAO.findById(orderId);

        if(order == null)
            throw new DataInvalidException("Order không tồn tại");

        if(order.getUserId() != userId)
            throw new DataInvalidException("Người dùng không có quyền truy cập đơn hàng này");

        if(order.isSigned() == false)
            throw new DataInvalidException("Đơn hàng chưa có chữ ký điện tử");


        if(paymentMethodName == null || paymentMethodName.trim().isEmpty())
            throw new DataInvalidException("Chưa chọn phương thức thanh toán");

        OrderSignature orderSignature = orderSignatureDAO.findOrderSignatureById(orderId);

        if(!orderSignatureService.verifyOrder(userId, orderId, orderSignature.getSignatureValue())){
            throw new SignatureException("Không thể xác thực đơn hàng, dữ liệu đơn hàng đã thay đổi!");
        }

        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setPaymentMethodId(findPaymentMethodIdByName(paymentMethodName));
        payment.setStatus(PaymentStatus.SUCCESS.getStatus());
        payment.setBalance(order.getTotalPrice());
        this.save(payment);


        order.setStatus(OrderStatus.IN_PREPARE.getStatus());
        orderDAO.update(order);
    }

}
