package view.top;

import controller.EncryptionController;
import controller.strategy.AsymmetricControllerStrategy;
import view.bottom.BottomPanel;
import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import java.awt.*;
import java.io.File;

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
        private JLabel lblKeyPair, lblPublicKey, lblPrivateKey;
        private JTextField tfPublicKey, tfPrivateKey;
        private JButton btnGenKeyPair, btnImportPublicKey, btnExportPublicKey, btnImportPrivateKey, btnExportPrivateKey;
        private JFileChooser fileChooser;

        public BasicPanel() {
            setLayout(new BoxLayout(BasicPanel.this, BoxLayout.Y_AXIS));
            setBackground(ColorView.THEME_COLOR);

            initKeyPair();
            addEvents();
        }

        private void addEvents() {
            fileChooser = new JFileChooser();

            btnGenKeyPair.addActionListener(e -> {
                try {
                    String[] keypair = controller.genKeyPair();
                    tfPublicKey.setText(keypair[0]);
                    tfPrivateKey.setText(keypair[1]);
                } catch (Exception ex) {
                    BottomPanel.updateResult(ex.getMessage());
                }
            });

            btnExportPublicKey.addActionListener(e -> {
                int result = fileChooser.showSaveDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    try {
                        controller.exportPublicKey(file);
                    } catch (Exception ex) {
                        BottomPanel.updateResult(ex.getMessage());
                    }
                }
            });

            btnImportPublicKey.addActionListener(e -> {
                int result = fileChooser.showOpenDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    try {
                        tfPublicKey.setText(controller.importPublicKey(file));
                    } catch (Exception ex) {
                        BottomPanel.updateResult(ex.getMessage());
                    }
                }
            });

            btnExportPrivateKey.addActionListener(e -> {
                int result = fileChooser.showSaveDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    try {
                        controller.exportPrivateKey(file);
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
                    } catch (Exception ex) {
                        BottomPanel.updateResult(ex.getMessage());
                    }
                }
            });
        }

        private void initKeyPair() {
            JPanel groupPanel = GeneratePanel.generateFlowPanel(FlowLayout.LEFT, 5, 5);
            lblKeyPair = new JLabel("Cặp khóa");
            lblKeyPair.setPreferredSize(new Dimension(100, 20));

            btnGenKeyPair = new JButton("Tạo cặp khóa");
            btnGenKeyPair.setBackground(ColorView.BACKGROUND_COLOR);
            btnGenKeyPair.setForeground(ColorView.TEXT_COLOR);
            groupPanel.add(lblKeyPair);
            groupPanel.add(btnGenKeyPair);
            add(groupPanel);

            groupPanel = GeneratePanel.generateBorderPanel(10,0);
            Dimension d = groupPanel.getPreferredSize();
            groupPanel.setPreferredSize(new Dimension((int) d.getWidth(), 25));
            groupPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, 25));
            lblPublicKey = new JLabel("  Khóa công khai");
            lblPublicKey.setPreferredSize(new Dimension(100, 20));

            tfPublicKey = new JTextField("");
            tfPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            tfPublicKey.setEditable(false);
            groupPanel.add(lblPublicKey, BorderLayout.WEST);
            groupPanel.add(tfPublicKey, BorderLayout.CENTER);
            add(groupPanel);

            groupPanel = GeneratePanel.generateFlowPanel(FlowLayout.LEFT, 5, 5);
            groupPanel.add(Box.createHorizontalStrut(100));
            btnImportPublicKey = new JButton("Chèn");
            btnImportPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnImportPublicKey.setForeground(ColorView.TEXT_COLOR);
            btnExportPublicKey = new JButton("Xuất");
            btnExportPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnExportPublicKey.setForeground(ColorView.TEXT_COLOR);
            groupPanel.add(btnImportPublicKey);
            groupPanel.add(btnExportPublicKey);
            add(groupPanel);

            groupPanel = GeneratePanel.generateBorderPanel(10, 0);
            d = groupPanel.getPreferredSize();
            groupPanel.setPreferredSize(new Dimension((int) d.getWidth(), 25));
            groupPanel.setMaximumSize(new Dimension(Integer.MAX_VALUE, 25));
            lblPrivateKey = new JLabel("  Khóa riêng tư");
            lblPrivateKey.setPreferredSize(new Dimension(100, 20));

            tfPrivateKey = new JTextField("");
            tfPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            tfPrivateKey.setEditable(false);
            groupPanel.add(lblPrivateKey, BorderLayout.WEST);
            groupPanel.add(tfPrivateKey, BorderLayout.CENTER);
            add(groupPanel);

            groupPanel = GeneratePanel.generateFlowPanel(FlowLayout.LEFT, 5, 5);
            groupPanel.add(Box.createHorizontalStrut(100));
            btnImportPrivateKey = new JButton("Chèn");
            btnImportPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnImportPrivateKey.setForeground(ColorView.TEXT_COLOR);
            btnExportPrivateKey = new JButton("Xuất");
            btnExportPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnExportPrivateKey.setForeground(ColorView.TEXT_COLOR);
            groupPanel.add(btnImportPrivateKey);
            groupPanel.add(btnExportPrivateKey);
            add(groupPanel);
        }
    }
}
