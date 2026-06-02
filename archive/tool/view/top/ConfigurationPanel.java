package view.top;

import javax.swing.*;
import java.awt.*;

public class ConfigurationPanel extends JPanel {
    private CardLayout layout;
    private AsymmetricCard asymmetricCard;
    private HashCard hashCard;

    public ConfigurationPanel() {
        layout = new CardLayout();
        setLayout(layout);


        asymmetricCard = new AsymmetricCard();
        hashCard = new HashCard();
        add(asymmetricCard, "ASYM");
        add(hashCard, "HASH");
    }

    public void showAsymmetric() {
        layout.show(this, "ASYM");
    }

    public void showHash() {
        layout.show(this, "HASH");
    }
}
