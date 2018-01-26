
package com.comis.frontsystem.util;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Utils {
	public static String encode(byte b[]){
		String hash=null;
		MessageDigest digest=null;
		try {
			digest = java.security.MessageDigest.getInstance("MD5");
			digest.reset();
			digest.update(b);
			byte[] messageDigest=digest.digest();
                        StringBuffer sb = new StringBuffer();
                        for (int i = 0; i < messageDigest.length; ++i) {
                            sb.append(Integer.toHexString((messageDigest[i] & 0xFF) | 0x100).substring(1,3));
                        }
                        hash=sb.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hash;
	}
	
}
