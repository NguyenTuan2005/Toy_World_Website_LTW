package cipher;

public interface TextCipher {
    String encryptText(String plainText) throws Exception;
    String decryptText(String cipherText) throws Exception;
}
