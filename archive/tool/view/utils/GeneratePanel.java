package view.utils;

import javax.swing.*;
import java.awt.*;

public class GeneratePanel {
    public static JPanel generateBorderPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBackground(ColorView.THEME_COLOR);
        return panel;
    }

    public static JPanel generateBorderPanel(int hgap, int vgap) {
        JPanel panel = new JPanel(new BorderLayout(hgap, vgap));
        panel.setBackground(ColorView.THEME_COLOR);
        return panel;
    }

    public static JPanel generateFlowPanel() {
        JPanel panel = new JPanel(new FlowLayout());
        panel.setBackground(ColorView.THEME_COLOR);
        return panel;
    }

    public static JPanel generateFlowPanel(int align, int hgap, int vgap) {
        JPanel panel = new JPanel(new FlowLayout(align, hgap, vgap));
        panel.setBackground(ColorView.THEME_COLOR);
        return panel;
    }

    public static JPanel generateGridBagPanel() {
        JPanel panel = new JPanel(new GridBagLayout());
        panel.setBackground(ColorView.THEME_COLOR);
        return panel;
    }
}
