package view.top;

import javax.swing.*;
import java.awt.*;

public class TopPanel extends JPanel {
    private AsymmetricCard configPanel;

    public TopPanel() {
        setLayout(new BorderLayout());

        configPanel = new AsymmetricCard();
        add(configPanel, BorderLayout.CENTER);
    }
}
