import controller.EncryptionController;
import controller.strategy.AsymmetricControllerStrategy;
import view.EncryptApplication;

public class Main {
    public static void main(String[] args) {
        EncryptionController controller = EncryptionController.getInstance();
        controller.put("Asymmetric", new AsymmetricControllerStrategy());

        controller.setCurrentController("Hash");

        EncryptApplication encryptApplication = new EncryptApplication();
        encryptApplication.showApp();
    }
}
