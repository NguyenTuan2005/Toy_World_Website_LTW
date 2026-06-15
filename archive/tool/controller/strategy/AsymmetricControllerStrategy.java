package controller.strategy;

import cipher.AsymmetricCipher;
import enums.AsymmetricAlgorithm;
import enums.InputType;
import view.bottom.BottomPanel;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.spec.InvalidKeySpecException;

public class AsymmetricControllerStrategy implements CipherControllerStrategy {
    private AsymmetricCipher asymmetricCipher;
    private InputType type = InputType.TEXT_TYPE;

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
                File file = new File(data);
                if (!file.isFile()) throw new Exception("Đường dẫn không phải là tệp");
                return this.asymmetricCipher.encryptFile(data);
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
