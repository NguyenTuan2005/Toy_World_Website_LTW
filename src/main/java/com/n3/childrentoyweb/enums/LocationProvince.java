package com.n3.childrentoyweb.enums;

public enum LocationProvince {
    AN_GIANG("An Giang"),
    BA_RIA_VUNG_TAU("Bà Rịa - Vũng Tàu"),
    BAC_GIANG("Bắc Giang"),
    BAC_KAN("Bắc Kạn"),
    BAC_LIEU("Bạc Liêu"),
    BAC_NINH("Bắc Ninh"),
    BEN_TRE("Bến Tre"),
    BINH_DINH("Bình Định"),
    BINH_DUONG("Bình Dương"),
    BINH_PHUOC("Bình Phước"),
    BINH_THUAN("Bình Thuận"),
    CA_MAU("Cà Mau"),
    CAN_THO("Cần Thơ"),
    CAO_BANG("Cao Bằng"),
    DA_NANG("Đà Nẵng"),
    DAK_LAK("Đắk Lắk"),
    DAK_NONG("Đắk Nông"),
    DIEN_BIEN("Điện Biên"),
    DONG_NAI("Đồng Nai"),
    DONG_THAP("Đồng Tháp"),
    GIA_LAI("Gia Lai"),
    HA_GIANG("Hà Giang"),
    HA_NOI("Hà Nội"),
    HA_NAM("Hà Nam"),
    HA_TINH("Hà Tĩnh"),
    HAI_DUONG("Hải Dương"),
    HAI_PHONG("Hải Phòng"),
    HAU_GIANG("Hậu Giang"),
    HOA_BINH("Hòa Bình"),
    HUNG_YEN("Hưng Yên"),
    TPHCM("TPHCM"),
    KHANH_HOA("Khánh Hòa"),
    KIEN_GIANG("Kiên Giang"),
    KON_TUM("Kon Tum"),
    LAI_CHAU("Lai Châu"),
    LAM_DONG("Lâm Đồng"),
    LANG_SON("Lạng Sơn"),
    LAO_CAI("Lào Cai"),
    NAM_DINH("Nam Định"),
    NGHE_AN("Nghệ An"),
    NINH_BINH("Ninh Bình"),
    NINH_THUAN("Ninh Thuận"),
    PHU_THO("Phú Thọ"),
    PHU_YEN("Phú Yên"),
    QUANG_BINH("Quảng Bình"),
    QUANG_NAM("Quảng Nam"),
    QUANG_NGAI("Quảng Ngãi"),
    QUANG_NINH("Quảng Ninh"),
    QUANG_TRI("Quảng Trị"),
    SOC_TRANG("Sóc Trăng"),
    SON_LA("Sơn La"),
    TAY_NINH("Tây Ninh"),
    THAI_BINH("Thái Bình"),
    THAI_NGUYEN("Thái Nguyên"),
    THANH_HOA("Thanh Hóa"),
    THUA_THIEN_HUE("Thừa Thiên Huế"),
    TIEN_GIANG("Tiền Giang"),
    TRA_VINH("Trà Vinh"),
    TUYEN_QUANG("Tuyên Quang"),
    VINH_LONG("Vĩnh Long"),
    VINH_PHUC("Vĩnh Phúc"),
    YEN_BAI("Yên Bái");

    private final String province;

    LocationProvince(String province) {
        this.province = province;
    }

    public String getProvince() {
        return province;
    }
}