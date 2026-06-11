package view.center;

import controller.EncryptionController;
import enums.InputType;
import view.utils.ColorView;

import javax.swing.*;
import java.awt.*;

public class ButtonGroupPanel extends JPanel {
    private JRadioButton rbText, rbFile;
    private ButtonGroup bgInputType;
    private EncryptionController controller = EncryptionController.getInstance();

    public ButtonGroupPanel() {
        setLayout(new FlowLayout());
        setBackground(ColorView.THEME_COLOR);
        rbText = new JRadioButton("Văn bản");
        rbText.setBackground(ColorView.THEME_COLOR);
        rbFile = new JRadioButton("Tệp");
        rbFile.setBackground(ColorView.THEME_COLOR);
        bgInputType = new ButtonGroup();

        bgInputType.add(rbText);
        bgInputType.add(rbFile);
        add(rbText);
        add(rbFile);
    }

    public void addActionRbText(Runnable runnable) {
        rbFile.setSelected(true);
        this.rbText.addActionListener((e) -> {
            rbFile.setSelected(true);
            controller.inputTypeChanged(InputType.TEXT_TYPE);
            runnable.run();
        });
    }

    public void addActionRbFile(Runnable runnable) {
        rbText.setSelected(true);
        this.rbFile.addActionListener((e) -> {
            rbText.setSelected(true);
            controller.inputTypeChanged(InputType.FILE_TYPE);
            runnable.run();
        });
    }
}
