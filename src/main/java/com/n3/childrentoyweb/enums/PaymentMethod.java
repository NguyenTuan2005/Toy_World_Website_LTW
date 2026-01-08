package com.n3.childrentoyweb.enums;


public enum PaymentMethod {
    VISA("Thẻ tín dụng (Visa/Mastercard)"),
    MOMO( "Ví điện tử MoMo"),
    ZALOPAY("ZaloPay"),
    COD("Thanh toán khi nhận hàng (COD)"),
    QR("Chuyển khoản ngân hàng");

    private final String name;

    private PaymentMethod(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public static PaymentMethod fromName(String name) {
        for (PaymentMethod method : PaymentMethod.values()) {
            if (method.getName().equals(name)) {
                return method;
            }
        }
        throw new IllegalArgumentException("No payment method with name: " + name);
    }
}
