package utils;

import javax.crypto.*;
import java.io.*;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class FileHelper {
    public static void exportKey(byte[] key, File des) throws IOException {
        String result = des.isDirectory() ? des.getPath() + "/key.txt" : des.getPath();
        PrintWriter out = new PrintWriter(result);
        out.write(Base64.getEncoder().encodeToString(key));
        out.flush();
        out.close();
    }

    public static PublicKey importPublicKey(File src, String algorithm) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        BufferedReader in = new BufferedReader(new FileReader(src));
        String key = in.readLine();
        in.close();

        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(key));
        KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
        return keyFactory.generatePublic(keySpec);
    }

    public static PrivateKey importPrivateKey(File src, String algorithm) throws IOException, InvalidKeySpecException, NoSuchAlgorithmException {
        BufferedReader in = new BufferedReader(new FileReader(src));
        String key = in.readLine();
        in.close();

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(key));
        KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
        return keyFactory.generatePrivate(keySpec);
    }
}
