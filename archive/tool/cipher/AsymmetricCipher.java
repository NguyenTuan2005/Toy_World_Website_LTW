package cipher;

import enums.AsymmetricAlgorithm;
import model.Asymmetric;
import utils.FileHelper;

import java.io.File;
import java.io.IOException;
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
        signature.initSign(asymmetric.getPrivateKey());
        byte[] data = Base64.getDecoder().decode(plainText);
        signature.update(data);
        return Base64.getEncoder().encodeToString(signature.sign());
    }

    @Override
    public String decryptText(String cipherText) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {
        Signature signature = Signature.getInstance(asymmetric.getTransformation());
        signature.initVerify(asymmetric.getPublicKey());
        byte[] data = Base64.getDecoder().decode(cipherText);
        signature.update(data);
        signature.verify(new byte[0]);
        return null;
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
}
