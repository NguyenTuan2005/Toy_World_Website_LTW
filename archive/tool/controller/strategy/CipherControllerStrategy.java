package controller.strategy;

import enums.InputType;

public interface CipherControllerStrategy {
    String encrypt(String data) throws Exception;
    void inputTypeChanged(InputType type);
}
