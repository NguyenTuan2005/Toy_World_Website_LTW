package utils;

import java.util.prefs.Preferences;

public class Path {
    private static final Preferences preferences = Preferences.userNodeForPackage(Path.class);
    private static final String DEFAULT_PATH = System.getProperty("user.home");

    public static String get() {
        return preferences.get("path", DEFAULT_PATH);
    }

    public static void put(String value) {
        preferences.put("path", value);
    }
}
