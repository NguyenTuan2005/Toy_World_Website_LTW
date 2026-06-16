package view.bottom;

import controller.EncryptionController;
import view.center.CenterPanel;
import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.io.File;
import java.security.InvalidKeyException;

public class BottomPanel extends JPanel {
    private JLabel lblResult;
    private JButton btnSign, btnCopy, btnDownload;
    private static JTextArea txtResult;
    private JScrollPane scrollPane;
    private CenterPanel centerPanel;
    private JFileChooser fileChooser;
    private EncryptionController controller = EncryptionController.getInstance();

    public BottomPanel(CenterPanel centerPanel) {
        this.centerPanel = centerPanel;
        setLayout(new BorderLayout());

        JPanel cipherPanel = GeneratePanel.generateBorderPanel();
        lblResult = new JLabel("  Kết quả:");
        cipherPanel.add(lblResult, BorderLayout.WEST);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 5, 0));
        buttonPanel.setBackground(ColorView.THEME_COLOR);

        btnDownload = new JButton("Tải về");
        btnDownload.setBackground(ColorView.BACKGROUND_COLOR);
        btnDownload.setForeground(ColorView.TEXT_COLOR);
        buttonPanel.add(btnDownload);

        btnCopy = new JButton("Sao chép");
        btnCopy.setBackground(ColorView.BACKGROUND_COLOR);
        btnCopy.setForeground(ColorView.TEXT_COLOR);
        buttonPanel.add(btnCopy);

        btnSign = new JButton("Ký tên");
        btnSign.setBackground(ColorView.BACKGROUND_COLOR);
        btnSign.setForeground(ColorView.TEXT_COLOR);
        buttonPanel.add(btnSign);

        cipherPanel.add(buttonPanel, BorderLayout.EAST);
        add(cipherPanel, BorderLayout.NORTH);

        txtResult = new JTextArea();
        txtResult.setBackground(ColorView.BACKGROUND_COLOR);
        txtResult.setPreferredSize(new Dimension(100, 100));
        txtResult.setEditable(false);
        txtResult.setLineWrap(true);
        txtResult.setWrapStyleWord(true);

        scrollPane = new JScrollPane();
        scrollPane.setViewportView(txtResult);
        add(scrollPane, BorderLayout.CENTER);

        addEvent();
    }

    private void addEvent() {
        fileChooser = new JFileChooser();

        btnSign.addActionListener(e -> {
            try {
                String data = centerPanel.getData();
                updateResult(controller.encrypt(data));
            } catch (Exception ex) {
                if (ex.getClass().equals(InvalidKeyException.class)) {
                    updateResultError("Khóa của bạn không hợp lệ");
                }
                else
                    updateResultError(ex.getMessage());
            }
        });

        btnCopy.addActionListener(e -> copyToClipboard());

        btnDownload.addActionListener(e ->  {
            int result = fileChooser.showSaveDialog(this);
            if (result == JFileChooser.APPROVE_OPTION) {
                File file = fileChooser.getSelectedFile();
                try {
                    updateResult(controller.downloadSign(file));
                } catch (Exception ex) {
                    BottomPanel.updateResult(ex.getMessage());
                }
            }
        });
    }

    private void copyToClipboard() {
        String text = txtResult.getText();
        if (text == null || text.isEmpty()) {
            updateResultError("Không có gì để sao chép");
            return;
        }
        StringSelection stringSelection = new StringSelection(text);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
        updateResultSuccess("Đã sao chép vào clipboard!");
    }

    public static void updateResult(String text) {
        txtResult.setText(text);
        txtResult.setForeground(ColorView.TEXT_COLOR);
    }

    public static void updateResultSuccess(String text) {
        txtResult.setText(text);
        txtResult.setForeground(ColorView.SUCCESS_COLOR);
    }

    public static void updateResultError(String text) {
        txtResult.setText(text);
        txtResult.setForeground(ColorView.ERROR_COLOR);
    }

    public static void clear() {
        txtResult.setText("");
    }
}
