package enums;

public enum HashAlgorithm {
    MD5("MD5");

    private final String algorithm;

    HashAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public String getAlgorithm() {
        return this.algorithm;
    }
}
