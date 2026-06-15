package view.top;

import controller.EncryptionController;
import controller.strategy.AsymmetricControllerStrategy;
import view.bottom.BottomPanel;
import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import javax.swing.border.TitledBorder;
import java.awt.*;
import java.io.File;
import java.security.spec.InvalidKeySpecException;

public class AsymmetricCard extends JPanel {
    private CardLayout layout;
    private JPanel cardPanel;
    private BasicPanel basicPanel;
    private AsymmetricControllerStrategy controller = (AsymmetricControllerStrategy) EncryptionController.getInstance().get("Asymmetric");

    public AsymmetricCard() {
        setLayout(new BorderLayout());

        cardPanel = new JPanel();
        layout = new CardLayout();
        cardPanel.setLayout(layout);
        basicPanel = new BasicPanel();

        cardPanel.add(basicPanel, "BASIC");
        add(cardPanel, BorderLayout.CENTER);
    }

    public class BasicPanel extends JPanel {
        private JLabel lblPrivateKey;
        private JTextField tfPrivateKey;
        private JButton btnImportPrivateKey, btnExportPrivateKey;
        private JFileChooser fileChooser;

        public BasicPanel() {
            setLayout(new BoxLayout(BasicPanel.this, BoxLayout.Y_AXIS));
            setBackground(ColorView.THEME_COLOR);

            initKeyPair();
            addEvents();
        }

        private void addEvents() {
            fileChooser = new JFileChooser();

            btnExportPrivateKey.addActionListener(e -> {
                int result = fileChooser.showSaveDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    try {
                        controller.exportPrivateKey(file);
                        BottomPanel.clear();
                    } catch (Exception ex) {
                        BottomPanel.updateResult(ex.getMessage());
                    }
                }
            });

            btnImportPrivateKey.addActionListener(e -> {
                int result = fileChooser.showOpenDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    try {
                        tfPrivateKey.setText(controller.importPrivateKey(file));
                        BottomPanel.clear();
                    } catch (Exception ex) {
                        if (ex.getClass().equals(InvalidKeySpecException.class))
                            BottomPanel.updateResultError("Không tìm thấy khóa");
                        else
                            BottomPanel.updateResult(ex.getMessage());
                    }
                }
            });
        }

        private void initKeyPair() {
            JPanel groupPanel = GeneratePanel.generateBorderPanel(5, 5);
            groupPanel.setPreferredSize(new Dimension(200, 100));
            groupPanel.setMaximumSize(new Dimension(200, 100));
            groupPanel.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createLineBorder(ColorView.BORDER_COLOR),
                "Khóa riêng tư", TitledBorder.LEFT,TitledBorder.TOP));

            JPanel privKeyInputPanel = GeneratePanel.generateBorderPanel(10, 0);
            lblPrivateKey = new JLabel("Giá trị");
            tfPrivateKey = new JTextField("");
            tfPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            privKeyInputPanel.add(lblPrivateKey, BorderLayout.WEST);
            privKeyInputPanel.add(tfPrivateKey, BorderLayout.CENTER);
            groupPanel.add(privKeyInputPanel, BorderLayout.CENTER);

            JPanel privKeyButtonPanel = GeneratePanel.generateFlowPanel(FlowLayout.RIGHT, 5, 5);
            btnImportPrivateKey = new JButton("Chèn");
            btnImportPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnImportPrivateKey.setForeground(ColorView.TEXT_COLOR);
            btnExportPrivateKey = new JButton("Xuất");
            btnExportPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnExportPrivateKey.setForeground(ColorView.TEXT_COLOR);
            privKeyButtonPanel.add(btnImportPrivateKey);
            privKeyButtonPanel.add(btnExportPrivateKey);
            groupPanel.add(privKeyButtonPanel, BorderLayout.SOUTH);
            add(groupPanel);
        }
    }
}
