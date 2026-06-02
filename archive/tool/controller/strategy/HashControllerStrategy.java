package controller.strategy;

import cipher.HashCipher;
import enums.HashAlgorithm;
import enums.InputType;

import java.io.File;

public class HashControllerStrategy implements CipherControllerStrategy {
    private HashCipher hashCipher;
    private InputType type = InputType.TEXT_TYPE;

    public HashControllerStrategy() {
        this.hashCipher = new HashCipher(HashAlgorithm.MD5);
    }

    @Override
    public String encrypt(String data) throws Exception {
        return genHash(data);
    }

    @Override
    public void inputTypeChanged(InputType type) {
        this.type = type;
    }

    public String genHash(String data) throws Exception {
        switch (type) {
            case TEXT_TYPE: {
                return this.hashCipher.hashText(data);
            }
            case FILE_TYPE: {
                File file = new File(data);
                if (!file.isFile()) throw new Exception("Đường dẫn không phải là tệp");
                return this.hashCipher.hashFile(file);
            }
        }
        return null;
    }

    public String[] getAlgorithms() {
        return this.hashCipher.getAlgorithms();
    }

    public void setHashCipher(String algorithm) {
        HashAlgorithm ha = this.hashCipher.findHashAlgorithm(algorithm);
        if (ha == null) return;
        this.hashCipher = new HashCipher(ha);
    }
}
