package controller;

import controller.strategy.CipherControllerStrategy;
import enums.InputType;

import java.util.HashMap;
import java.util.Map;

public class EncryptionController {
    private static EncryptionController instance;
    private CipherControllerStrategy currentController;
    private Map<String, CipherControllerStrategy> controllers;

    private EncryptionController() {
        controllers = new HashMap<>();
    }

    public static synchronized EncryptionController getInstance() {
        if (instance == null)
            instance = new EncryptionController();
        return instance;
    }

    public String encrypt(String data) throws Exception {
        setCurrentController("Hash");
        String result = currentController.encrypt(data);
        setCurrentController("Asymmetric");
        return currentController.encrypt(result);
    }

    public void inputTypeChanged(InputType type) {
        for (CipherControllerStrategy controller : controllers.values()) {
            controller.inputTypeChanged(type);
        }
    }

    public void setCurrentController(String name) {
        this.currentController = controllers.get(name);
    }

    public void put(String name, CipherControllerStrategy controller) {
        this.controllers.put(name, controller);
    }

    public CipherControllerStrategy get(String name) {
        return this.controllers.get(name);
    }
}
