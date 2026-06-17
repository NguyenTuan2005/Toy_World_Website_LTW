package view.top;

import controller.EncryptionController;
import controller.strategy.AsymmetricControllerStrategy;
import utils.Path;
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
        private JLabel lblPrivateKey, lblPublicKey, lblGenKey;
        private JTextField tfPrivateKey, tfPublicKey;
        private JButton btnImportPrivateKey, btnExportPrivateKey, btnImportPublicKey, btnExportPublicKey, btnGenKey;
        private JFileChooser fileChooser;

        public BasicPanel() {
            setLayout(new BoxLayout(BasicPanel.this, BoxLayout.Y_AXIS));
            setBackground(ColorView.THEME_COLOR);

            initKeyPair();
            addEvents();
        }

        private void addEvents() {
            fileChooser = new JFileChooser(Path.get());

            btnGenKey.addActionListener(e -> {
                try {
                    String[] keypair = controller.genKeyPair();
                    tfPublicKey.setText(keypair[0]);
                    tfPrivateKey.setText(keypair[1]);
                    BottomPanel.clear();
                } catch (Exception ex) {
                    BottomPanel.updateResult(ex.getMessage());
                }
            });

            btnExportPublicKey.addActionListener(e -> {
                int result = fileChooser.showSaveDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    Path.put(file.getParent());
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
                    Path.put(file.getParent());
                    try {
                        tfPublicKey.setText(controller.importPublicKey(file));
                    } catch (Exception ex) {
                        if (ex.getClass().equals(InvalidKeySpecException.class) ||
                            ex.getClass().equals(IllegalArgumentException.class)
                        )
                            BottomPanel.updateResultError("Không tìm thấy khóa");
                        else
                            BottomPanel.updateResultError(ex.getMessage());
                    }
                }
            });

            btnExportPrivateKey.addActionListener(e -> {
                int result = fileChooser.showSaveDialog(BasicPanel.this);
                if (result == JFileChooser.APPROVE_OPTION) {
                    File file = fileChooser.getSelectedFile();
                    Path.put(file.getParent());
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
                    Path.put(file.getParent());
                    try {
                        tfPrivateKey.setText(controller.importPrivateKey(file));
                        BottomPanel.clear();
                    } catch (Exception ex) {
                        if (ex.getClass().equals(InvalidKeySpecException.class) ||
                                ex.getClass().equals(IllegalArgumentException.class)
                        )
                            BottomPanel.updateResultError("Không tìm thấy khóa");
                        else
                            BottomPanel.updateResultError(ex.getMessage());
                    }
                }
            });
        }

        private void initKeyPair() {
            JPanel groupPanel = GeneratePanel.generateBorderPanel(5, 5);
            groupPanel.setPreferredSize(new Dimension(200, 50));
            groupPanel.setMaximumSize(new Dimension(200, 50));
            groupPanel.setBorder(BorderFactory.createTitledBorder(
                    BorderFactory.createLineBorder(ColorView.BORDER_COLOR),
                    "Tạo cặp khóa", TitledBorder.LEFT,TitledBorder.TOP));

            JPanel genKeyButtonPanel = GeneratePanel.generateBorderPanel(5, 5);
            btnGenKey = new JButton("Tạo");
            btnGenKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnGenKey.setForeground(ColorView.TEXT_COLOR);
            genKeyButtonPanel.add(btnGenKey, BorderLayout.CENTER);
            groupPanel.add(genKeyButtonPanel, BorderLayout.CENTER);
            add(groupPanel);

            groupPanel = GeneratePanel.generateBorderPanel(5, 5);
            groupPanel.setPreferredSize(new Dimension(200, 100));
            groupPanel.setMaximumSize(new Dimension(200, 100));
            groupPanel.setBorder(BorderFactory.createTitledBorder(
                    BorderFactory.createLineBorder(ColorView.BORDER_COLOR),
                    "Khóa công khai", TitledBorder.LEFT,TitledBorder.TOP));

            JPanel plubKeyInputPanel = GeneratePanel.generateBorderPanel(10, 0);
            lblPublicKey = new JLabel("Giá trị");
            tfPublicKey = new JTextField("");
            tfPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            tfPublicKey.setEditable(false);
            plubKeyInputPanel.add(lblPublicKey, BorderLayout.WEST);
            plubKeyInputPanel.add(tfPublicKey, BorderLayout.CENTER);
            groupPanel.add(plubKeyInputPanel, BorderLayout.CENTER);

            plubKeyInputPanel = GeneratePanel.generateFlowPanel(FlowLayout.RIGHT, 5, 5);
            btnImportPublicKey = new JButton("Chèn");
            btnImportPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnImportPublicKey.setForeground(ColorView.TEXT_COLOR);
            btnExportPublicKey = new JButton("Xuất");
            btnExportPublicKey.setBackground(ColorView.BACKGROUND_COLOR);
            btnExportPublicKey.setForeground(ColorView.TEXT_COLOR);
            plubKeyInputPanel.add(btnImportPublicKey);
            plubKeyInputPanel.add(btnExportPublicKey);
            groupPanel.add(plubKeyInputPanel, BorderLayout.SOUTH);
            add(groupPanel);

            groupPanel = GeneratePanel.generateBorderPanel(5, 5);
            groupPanel.setPreferredSize(new Dimension(200, 100));
            groupPanel.setMaximumSize(new Dimension(200, 100));
            groupPanel.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createLineBorder(ColorView.BORDER_COLOR),
                "Khóa riêng tư", TitledBorder.LEFT,TitledBorder.TOP));

            JPanel privKeyInputPanel = GeneratePanel.generateBorderPanel(10, 0);
            lblPrivateKey = new JLabel("Giá trị");
            tfPrivateKey = new JTextField("");
            tfPrivateKey.setBackground(ColorView.BACKGROUND_COLOR);
            tfPrivateKey.setEditable(false);
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
