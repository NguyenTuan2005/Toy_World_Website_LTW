package view.top;

import view.center.CenterPanel;

import javax.swing.*;
import java.awt.*;

public class TopPanel extends JPanel {
    private ConfigurationPanel configPanel;

    public TopPanel(CenterPanel centerPanel) {
        setLayout(new BorderLayout());

        configPanel = new ConfigurationPanel();
        add(configPanel, BorderLayout.CENTER);
    }
}
