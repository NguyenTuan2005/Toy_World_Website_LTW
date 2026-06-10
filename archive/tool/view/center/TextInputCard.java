package view.center;

import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import java.awt.*;

public class TextInputCard extends JPanel {
    private JLabel lblText;
    private JTextArea txtInput;
    private JScrollPane scrollPane;
    private ButtonGroupPanel buttonGroupPanel;

    public TextInputCard(Runnable runnable) {
        setLayout(new BorderLayout());

        JPanel panel = GeneratePanel.generateBorderPanel();
        lblText = new JLabel("  Nhập văn bản");
        panel.add(lblText, BorderLayout.WEST);

        buttonGroupPanel = new ButtonGroupPanel();
        buttonGroupPanel.addActionRbFile(runnable);
        panel.add(buttonGroupPanel, BorderLayout.EAST);
        add(panel, BorderLayout.NORTH);

        txtInput = new JTextArea();
        txtInput.setBackground(ColorView.BACKGROUND_COLOR);
        txtInput.setPreferredSize(new Dimension(100, 100));

        scrollPane = new JScrollPane();
        scrollPane.setViewportView(txtInput);
        add(scrollPane, BorderLayout.CENTER);
    }

    public String getData() {
        return txtInput.getText();
    }
}
