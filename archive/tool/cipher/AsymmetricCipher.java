package cipher;

import enums.AsymmetricAlgorithm;
import model.Asymmetric;
import utils.FileHelper;

import java.io.*;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

public class AsymmetricCipher implements TextCipher, FileCipher{
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
        asymmetric.setSign(signature.sign());
        return Base64.getEncoder().encodeToString(asymmetric.getSign());
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

    @Override
    public String encryptFile(String plainText) throws Exception {
        Signature signature = Signature.getInstance(asymmetric.getTransformation());
        signature.initSign(asymmetric.getPrivateKey());
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(plainText));
        byte[] read = new byte[1024];
        int length;
        while ((length = bis.read(read)) != -1) {
            signature.update(read, 0, length);
        }
        bis.close();
        asymmetric.setSign(signature.sign());
        return Base64.getEncoder().encodeToString(asymmetric.getSign());
    }

    public String importPrivateKey(File src) throws IOException, InvalidKeySpecException, NoSuchAlgorithmException {
        this.asymmetric.setPrivateKey(FileHelper.importPrivateKey(src, this.asymmetric.getAlgorithmName()));
        return Base64.getEncoder().encodeToString(this.asymmetric.getPrivateKey().getEncoded());
    }

    public boolean exportPrivateKey(File des) throws IOException {
        if (this.asymmetric.getPrivateKey() == null) return false;
        FileHelper.exportKey(this.asymmetric.getPrivateKey().getEncoded(), des);
        return true;
    }

    public boolean downloadSign(File des) throws IOException {
        byte[] sign = asymmetric.getSign();
        if (sign == null || sign.length == 0)
            return false;
        FileHelper.exportKey(sign, des);
        return true;
    }
}
