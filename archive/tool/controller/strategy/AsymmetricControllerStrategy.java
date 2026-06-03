package controller.strategy;

import cipher.AsymmetricCipher;
import enums.AsymmetricAlgorithm;
import enums.InputType;
import view.bottom.BottomPanel;
import view.top.AsymmetricCard;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.spec.InvalidKeySpecException;

import static enums.InputType.TEXT_TYPE;

public class AsymmetricControllerStrategy implements CipherControllerStrategy {
    private AsymmetricCipher asymmetricCipher;

    public AsymmetricControllerStrategy() {
        this.asymmetricCipher = new AsymmetricCipher(AsymmetricAlgorithm.SHA256WITHDSA);
    }

    @Override
    public String encrypt(String data) throws Exception {
        return this.asymmetricCipher.encryptText(data);
    }

    @Override
    public void inputTypeChanged(InputType type) {
    }

    public String[] genKeyPair() throws NoSuchAlgorithmException, NoSuchProviderException {
        return this.asymmetricCipher.genKey();
    }

    public void exportPublicKey(File des) throws IOException {
        String result ="Đã xuất khóa công khai cho bạn";
        if (!this.asymmetricCipher.exportPublicKey(des))
            result = "Không thể xuất khóa công khai cho bạn";
        BottomPanel.updateResult(result);
    }

    public String importPublicKey(File src) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        return this.asymmetricCipher.importPublicKey(src);
    }

    public void exportPrivateKey(File des) throws IOException {
        String result = "Đã xuất khóa riêng tư cho bạn";
        if (!this.asymmetricCipher.exportPrivateKey(des))
            result = "Không thể xuất khóa riêng tư cho bạn";
        BottomPanel.updateResult(result);
    }

    public String importPrivateKey(File des) throws IOException, InvalidKeySpecException, NoSuchAlgorithmException {
        return this.asymmetricCipher.importPrivateKey(des);
    }
}
