package com.n3.childrentoyweb.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSigningPayload;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.utils.JsonUtil;

import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.Optional;

public class OrderSignatureService {
    private OrderSignatureDAO orderSignatureDAO;
    private OrderDAO orderDAO;

    public OrderSignatureService(OrderSignatureDAO orderSignatureDAO, OrderDAO orderDAO) {
        this.orderSignatureDAO = orderSignatureDAO;
    }

    public boolean verifyOrder(Long userId, Long orderId, String signatureBase64) throws JsonProcessingException, NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, SignatureException {
        OrderSigningPayload orderPayload = buildOrderSigningPayload(orderId).orElseThrow(() -> new ObjectNotFoundException("Order not found"));
        String orderPayloadStr = JsonUtil.convertToJsonPayload(orderPayload);


        OrderSignatureDTO orderSignature = orderSignatureDAO.findOrderSignatureByUserAndOrderId(userId, orderId).orElseThrow(() -> new ObjectNotFoundException("Order not found"));
        String publicKeyBase64 = orderSignature.getPublicKey();
        String algorithm = orderSignature.getAlgorithm();


        byte[] signBytes = Base64.getDecoder().decode(signatureBase64.trim());
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKeyBase64));
        KeyFactory keyFactory = KeyFactory.getInstance("DSA");
        PublicKey publicKey = keyFactory.generatePublic(keySpec);


        Signature signature = Signature.getInstance(algorithm);
        signature.initVerify(publicKey);
        signature.update(orderPayloadStr.getBytes(StandardCharsets.UTF_8));

        return signature.verify(signBytes);
    }



    public Optional<OrderSigningPayload> buildOrderSigningPayload(Long orderId) {
        Optional<OrderSigningPayload> orderForSigning = orderSignatureDAO.findOrderForSigning(orderId);

        if (orderForSigning.isEmpty()) {
            return Optional.empty();
        }

        OrderSigningPayload orderPayload = orderForSigning.get();

        orderPayload.setItems(orderSignatureDAO.findOrderItemsForSigning(orderId));

        return Optional.of(orderPayload);
    }

}
