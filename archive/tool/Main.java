import controller.EncryptionController;
import controller.strategy.AsymmetricControllerStrategy;
import controller.strategy.HashControllerStrategy;
import view.EncryptApplication;

public class Main {
    public static void main(String[] args) {
        EncryptionController controller = EncryptionController.getInstance();
        controller.put("Asymmetric", new AsymmetricControllerStrategy());
        controller.put("Hash", new HashControllerStrategy());

        controller.setCurrentController("Hash");

        EncryptApplication encryptApplication = new EncryptApplication();
        encryptApplication.showApp();
    }
}
