package controller.strategy;

import enums.InputType;

import java.io.File;
import java.io.IOException;

public interface CipherControllerStrategy {
    String encrypt(String data) throws Exception;
    void inputTypeChanged(InputType type);
    String downloadSign(File des) throws IOException;
}
