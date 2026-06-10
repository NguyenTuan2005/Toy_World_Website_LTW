package view.top;

import controller.EncryptionController;
import controller.strategy.HashControllerStrategy;
import view.utils.ColorView;

import javax.swing.*;
import java.awt.*;

public class HashCard extends JPanel {
    private JLabel lblAlgorithm;
    private JComboBox<String> cbAlgorithm;
    private HashControllerStrategy controller = (HashControllerStrategy) EncryptionController.getInstance().get("Hash");

    public HashCard() {
        setLayout(new FlowLayout(FlowLayout.LEFT));
        setBackground(ColorView.THEME_COLOR);

        lblAlgorithm = new JLabel("Giải thuật băm");
        lblAlgorithm.setPreferredSize(new Dimension(100, 20));

        cbAlgorithm = new JComboBox<>(controller.getAlgorithms());
        cbAlgorithm.setBackground(ColorView.BACKGROUND_COLOR);
        add(lblAlgorithm);
        add(cbAlgorithm);

        addEvent();
    }

    private void addEvent() {
        cbAlgorithm.addActionListener(e -> {
            String selected = (String) cbAlgorithm.getSelectedItem();

            controller.setHashCipher(selected);
        });
    }
}
