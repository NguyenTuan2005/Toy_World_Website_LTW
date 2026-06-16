package controller.strategy;

import cipher.AsymmetricCipher;
import enums.AsymmetricAlgorithm;
import enums.InputType;
import view.bottom.BottomPanel;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.spec.InvalidKeySpecException;

public class AsymmetricControllerStrategy implements CipherControllerStrategy {
    private AsymmetricCipher asymmetricCipher;
    private InputType type = InputType.FILE_TYPE;

    public AsymmetricControllerStrategy() {
        this.asymmetricCipher = new AsymmetricCipher(AsymmetricAlgorithm.SHA1WITHDSA);
    }

    @Override
    public String encrypt(String data) throws Exception {
        if (data.isBlank()) return "Không có dữ liệu để ký tên";

        switch (type) {
            case TEXT_TYPE: {
                return this.asymmetricCipher.encryptText(data);
            }
            case FILE_TYPE: {
                String payload = Files.readString(Path.of(data), StandardCharsets.UTF_8);
                return this.asymmetricCipher.encryptPayload(payload);
            }
        }
        return null;
    }

    @Override
    public void inputTypeChanged(InputType type) {
        this.type = type;
    }

    @Override
    public String downloadSign(File des) throws IOException {
        String result = "Đã tải chữ ký cho bạn";
        if (!this.asymmetricCipher.downloadSign(des))
            result = "Không thể tải chữ ký cho bạn";
        return result;
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
