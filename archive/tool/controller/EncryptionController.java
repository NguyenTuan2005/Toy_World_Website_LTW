package controller;

import controller.strategy.CipherControllerStrategy;
import enums.InputType;

import java.io.File;
import java.io.IOException;
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
        return currentController.encrypt(data);
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

    public String downloadSign(File des) throws IOException {
        return this.currentController.downloadSign(des);
    }
}
