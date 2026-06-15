package view.center;

import javax.swing.*;
import java.awt.*;

public class CenterPanel extends JPanel {
    private CardLayout layout;
    private TextInputCard textInputCard;
    private FileInputCard fileInputCard;
    private String currentCard = "FILE";

    public CenterPanel() {
        layout = new CardLayout();
        setLayout(layout);

        textInputCard = new TextInputCard(this::showFile);
        fileInputCard = new FileInputCard(this::showText);

        add(fileInputCard, "FILE");
        add(textInputCard, "TEXT");
    }

    public void showText() {
        layout.show(this, "TEXT");
        currentCard = "TEXT";
    }

    public void showFile() {
        layout.show(this, "FILE");
        currentCard = "FILE";
    }

    public String getData() {
        switch (currentCard) {
            case "TEXT":
                return textInputCard.getData();
            case "FILE":
                return fileInputCard.getData();
        }
        return null;
    }
}
