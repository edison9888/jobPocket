/**
 * 
 */
package com.chinatelecom.clientservice.utility;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
/**
 * 标准des加解密工具类
 * 
 * @author xdm
 * 
 */
public class Des3Util {
	private static final String ALGORITHM = "DESede";

	// 转换成十六进制字符串

	public static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";

		for (int n = 0; n < b.length; n++) {
			stmp = (Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;

		}
		return hs.toUpperCase();
	}

	public static byte[] hexToByte(String s) throws IOException {
		int i = s.length() / 2;
		byte abyte0[] = new byte[i];
		int j = 0;
		if (s.length() % 2 != 0)
			throw new IOException(
					"hexadecimal string with odd number of characters");
		for (int k = 0; k < i; k++) {
			char c = s.charAt(j++);
			int l = "0123456789abcdef0123456789ABCDEF".indexOf(c);
			if (l == -1)
				throw new IOException(
						"hexadecimal string contains non hex character");
			int i1 = (l & 0xf) << 4;
			c = s.charAt(j++);
			l = "0123456789abcdef0123456789ABCDEF".indexOf(c);
			i1 += l & 0xf;
			abyte0[k] = (byte) i1;
		}

		return abyte0;
	}

	/**
	 * des加密，注意，其中key的长度为32位
	 * 
	 * @param para
	 * @param key
	 *            :
	 */
	public static String encode(String para, String key) throws Exception {
		byte[] text = para.getBytes("UTF-8"); // 待加/解密的数据
		// 密钥数据
		byte[] keyData = build3DesKey(key);
		String fullAlg = ALGORITHM + "/CBC/PKCS5Padding";
		Cipher cipher = Cipher.getInstance(fullAlg);
		int blockSize = cipher.getBlockSize();
		byte[] iv = new byte[blockSize];
		for (int i = 0; i < blockSize; ++i) {
			iv[i] = 0;
		}
		SecretKey secretKey = new SecretKeySpec(keyData, ALGORITHM);
		IvParameterSpec ivSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivSpec);
		byte[] cipherBytes = cipher.doFinal(text);
		return byte2hex(cipherBytes);
	}

    /**
     * 构造3DES加解密方法key
     * 
     * @param keyStr
     * @return
     * @throws Exception
     */
    private static byte[] build3DesKey(String keyStr) throws Exception {
        byte[] key = new byte[24];
        byte[] temp = keyStr.getBytes("UTF-8");
        if (key.length > temp.length) {
            System.arraycopy(temp, 0, key, 0, temp.length);
        } else {
            System.arraycopy(temp, 0, key, 0, key.length);
        }
        
        return key;
    }
	
	/**
	 * 对字符串进行解密
	 * 
	 * @param para
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String decode(String para, String key) throws Exception {
		byte[] text = hexToByte(para); // 待加/解密的数据
		// 密钥数据
//		byte[] keyData = Base64.encode(key.getBytes("UTF-8"), Base64.DEFAULT);
		byte[] keyData = build3DesKey(key);
		String fullAlg = ALGORITHM + "/CBC/PKCS5Padding";
		Cipher cipher = Cipher.getInstance(fullAlg);
		int blockSize = cipher.getBlockSize();
		byte[] iv = new byte[blockSize];
		for (int i = 0; i < blockSize; ++i) {
			iv[i] = 0;
		}
		SecretKey secretKey = new SecretKeySpec(keyData, ALGORITHM);
		IvParameterSpec ivSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.DECRYPT_MODE, secretKey, ivSpec);
		return new String(cipher.doFinal(text));
	}

	public static void main(String arge[]) throws Exception {
		String para = "13439583395";
		String key = "1234567`90koiuyhgtfr0de";
		 System.out.println(encode("0", key));
        System.out.println(decode("D5C5D77D1B8961577F10E4AB2B56", key));
	}
}
