package cipher;

import enums.AsymmetricAlgorithm;
import model.Asymmetric;
import utils.FileHelper;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

public class AsymmetricCipher implements TextCipher {
    private Asymmetric asymmetric;

    public AsymmetricCipher(AsymmetricAlgorithm algorithm) {
        this.asymmetric = new Asymmetric(algorithm);
    }

    public String[] genKey() throws NoSuchAlgorithmException, NoSuchProviderException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(asymmetric.getAlgorithmName(), "SUN");
        SecureRandom random = SecureRandom.getInstance("SHA1PRNG", "SUN");
        keyPairGenerator.initialize(asymmetric.getKeySize(), random);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        asymmetric.setPublicKey(keyPair.getPublic());
        asymmetric.setPrivateKey(keyPair.getPrivate());
        return new String[] {Base64.getEncoder().encodeToString(keyPair.getPublic().getEncoded()), Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded())};
    }

    @Override
    public String encryptText(String plainText) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {
        Signature signature = Signature.getInstance(asymmetric.getTransformation());
        signature.initVerify(asymmetric.getPublicKey());
        byte[] data = plainText.getBytes(StandardCharsets.UTF_8);
        return Base64.getEncoder().encodeToString(signature.sign());
    }

    @Override
    public String decryptText(String cipherText) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException, NoSuchProviderException {
        Cipher cipher = Cipher.getInstance(asymmetric.getTransformation());
        cipher.init(Cipher.DECRYPT_MODE, asymmetric.getPrivateKey());
        byte[] data = Base64.getDecoder().decode(cipherText);
        return new String(cipher.doFinal(data), StandardCharsets.UTF_8);
    }

    public String importPublicKey(File src) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        this.asymmetric.setPublicKey(FileHelper.importPublicKey(src, this.asymmetric.getAlgorithmName()));
        return Base64.getEncoder().encodeToString(this.asymmetric.getPublicKey().getEncoded());
    }

    public boolean exportPublicKey(File des) throws IOException {
        if (this.asymmetric.getPublicKey() == null) return false;
        FileHelper.exportKey(this.asymmetric.getPublicKey().getEncoded(), des);
        return true;
    }

    public String importPrivateKey(File src) throws IOException, InvalidKeySpecException, NoSuchAlgorithmException {
        this.asymmetric.setPrivateKey(FileHelper.importPrivateKey(src, this.asymmetric.getAlgorithmName()));
        return Base64.getEncoder().encodeToString(this.asymmetric.getPublicKey().getEncoded());
    }

    public boolean exportPrivateKey(File des) throws IOException {
        if (this.asymmetric.getPrivateKey() == null) return false;
        FileHelper.exportKey(this.asymmetric.getPrivateKey().getEncoded(), des);
        return true;
    }

    public String[] getTransformations() {
        return this.asymmetric.getTransformations();
    }

    public String[] findKeySizes() {
        return this.asymmetric.findKeySizes();
    }

    public AsymmetricAlgorithm findAsymmetricAlgorithm(String algorithm) {
        return this.asymmetric.findAsymmetricAlgorithm(algorithm);
    }

    public void setKeySize(int keySize) {
        this.asymmetric.setKeySize(keySize);
    }
}
