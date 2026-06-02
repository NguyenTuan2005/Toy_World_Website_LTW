package view.bottom;

import controller.EncryptionController;
import view.center.CenterPanel;
import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import java.awt.*;

public class BottomPanel extends JPanel {
    private JLabel lblResult;
    private JButton btnSign;
    private static JTextArea txtResult;
    private JScrollPane scrollPane;
    private CenterPanel centerPanel;
    private static JPanel cipherPanel;
    private EncryptionController controller = EncryptionController.getInstance();

    public BottomPanel(CenterPanel centerPanel) {
        this.centerPanel = centerPanel;
        setLayout(new BorderLayout());

        cipherPanel = GeneratePanel.generateBorderPanel();
        lblResult = new JLabel("  Kết quả:");
        cipherPanel.add(lblResult, BorderLayout.WEST);

        btnSign = new JButton("Ký tên");
        btnSign.setBackground(ColorView.BACKGROUND_COLOR);
        btnSign.setForeground(ColorView.TEXT_COLOR);
        cipherPanel.add(btnSign, BorderLayout.EAST);
        add(cipherPanel, BorderLayout.NORTH);

        txtResult = new JTextArea();
        txtResult.setBackground(ColorView.BACKGROUND_COLOR);
        txtResult.setPreferredSize(new Dimension(100, 100));
        txtResult.setEditable(false);

        scrollPane = new JScrollPane();
        scrollPane.setViewportView(txtResult);
        add(scrollPane, BorderLayout.CENTER);

        addEvent();
    }

    private void addEvent() {
        btnSign.addActionListener(e -> {
            try {
                String data = centerPanel.getData();
                updateResult(controller.encrypt(data));
            } catch (Exception ex) {
                txtResult.setText(ex.getMessage());
            }
        });
    }

    public static void updateResult(String text) {
        txtResult.setText(text);
    }
}
