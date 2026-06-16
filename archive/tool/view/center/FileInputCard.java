package view.center;

import view.utils.ColorView;
import view.utils.GeneratePanel;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.io.File;

public class FileInputCard extends JPanel {
    private JLabel lblFile;
    private JTextField tfFilePath;
    private JButton btnBrowseFile;
    private JFileChooser fileChooser;

    public FileInputCard(Runnable runnable) {
        setLayout(new BorderLayout());

        JPanel panel = GeneratePanel.generateBorderPanel();
        lblFile = new JLabel("  Thêm tệp để bắt đầu");
        panel.add(lblFile, BorderLayout.WEST);

        ButtonGroupPanel buttonGroupPanel = new ButtonGroupPanel();
        buttonGroupPanel.addActionRbText(runnable);
        panel.add(buttonGroupPanel, BorderLayout.EAST);
        add(panel, BorderLayout.NORTH);

        panel = GeneratePanel.generateGridBagPanel();
        GridBagConstraints gbc = new GridBagConstraints();

        btnBrowseFile = new JButton("Tìm kiếm");
        btnBrowseFile.setBackground(ColorView.BACKGROUND_COLOR);
        btnBrowseFile.setForeground(ColorView.TEXT_COLOR);
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.CENTER;
        gbc.insets = new Insets(10, 10, 10, 10);
        panel.add(btnBrowseFile, gbc);

        tfFilePath = new JTextField(30);
        tfFilePath.setEditable(false);
        tfFilePath.setBackground(ColorView.THEME_COLOR);
        gbc.gridy = 1;
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.weightx = 1.0;
        panel.add(tfFilePath, gbc);
        add(panel, BorderLayout.CENTER);
        addEvent();
    }

    private void addEvent() {
        fileChooser = new JFileChooser();

        FileNameExtensionFilter filter = new FileNameExtensionFilter("JSON files (*.json)", "json");
        fileChooser.setFileFilter(filter);

        btnBrowseFile.addActionListener(e -> {
            int result = fileChooser.showOpenDialog(FileInputCard.this);

            if (result == JFileChooser.APPROVE_OPTION) {
                File file = fileChooser.getSelectedFile();
                tfFilePath.setText(file.getPath());
            }
        });
    }

    public String getData() {
        return tfFilePath.getText();
    }
}
