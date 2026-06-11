package model;

import enums.AsymmetricAlgorithm;

import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;

public class Asymmetric {
    private AsymmetricAlgorithm algorithm;
    private PrivateKey privateKey;
    private PublicKey publicKey;
    private byte[] sign;
    private int keySize;

    public Asymmetric(AsymmetricAlgorithm algorithm) {
        this.algorithm = algorithm;
        this.keySize = algorithm.getKeySizes()[0];
    }

    public String getAlgorithmName() {
        return algorithm.getAlgorithm();
    }

    public int getKeySize() {
        return keySize;
    }

    public void setPrivateKey(PrivateKey privateKey) {
        this.privateKey = privateKey;
    }

    public void setPublicKey(PublicKey publicKey) {
        this.publicKey = publicKey;
    }

    public void setSign(byte[] sign) {
        this.sign = sign;
    }

    public String getTransformation() {
        return this.algorithm.getTransformation();
    }

    public PublicKey getPublicKey() {
        return this.publicKey;
    }

    public PrivateKey getPrivateKey() {
        return this.privateKey;
    }

    public byte[] getSign() {
        return this.sign;
    }
}
