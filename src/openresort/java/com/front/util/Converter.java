/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class Converter {

    public static String getCurrentDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        return formatter.format(new Date());
    }

    public static Date parseDate(String date) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        try {
            if (date != null && date.length() != 0) {
                return formatter.parse(date);
            } else {
                return null;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();
            return null;
        }
    }

    public static Date parseTime(String time) {
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss", Locale.ENGLISH);
        try {
            if (time.length() < 8) {
                return formatter.parse(time + ":00");
            } else if (time.length() > 0 && time.length() < 8) {
                return formatter.parse(time);
            } else {
                return null;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block

            return null;
        }
    }

    public static java.sql.Date parseSQLDate(String date) {

        try {

            return java.sql.Date.valueOf(date);
        } catch (Exception e) {
            return null;
        }

    }

    public static java.sql.Time parseSQLTime(String time) {

        try {
            if(time.equals(null)|| (time.length()<5)) {
               
                java.util.Date today = new java.util.Date();
                
    
                return new java.sql.Time(today.getTime());
            }else {
               
                return java.sql.Time.valueOf(time);
            }

        } catch (Exception e) {
            return null;
        }

    }

    public static Double parseDouble(String money) {
        try {
            if(money.equals(""))
                money=DefaultValue.DUMMYINT;
            return Double.parseDouble(money);
        } catch (Exception e) {
            return null;
        }
    }

    public static Integer parseInt(String id) {
        try {
            return Integer.parseInt(id);
        } catch (Exception e) {
            return null;
        }
    }

    public static Boolean parseBoolean(String bool) {
        if (bool != null && bool.length() > 0) {
            if (bool.equals("t")) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static Boolean isEmpty(String obj) {
        if (obj == null || obj.equals("")) {
            return true;
        } else {
            return false;
        }
    }

    public static String parseToYesNo(String obj) {
        if (obj == null || obj.equals("")) {
            return "N";
        } else {
            return "Y";
        }
    }

    public static <T> void printFields(T t) {
        System.out.println("--------------------------");
        System.out.println(t.getClass().getName());

        for (Method m : t.getClass().getDeclaredMethods()) {

            try {
                if (m.getName().startsWith("get")) {
                    if (m.invoke(t, new Object[]{}) instanceof String || m.invoke(t, new Object[]{}) == null) {
                        System.out.println(m.getName() + " - " + m.invoke(t, new Object[]{}));
                    } else {
                        try {
                            printFields(m.invoke(t, new Object[]{}));
                        } catch (InvocationTargetException ex) {
                            ex.printStackTrace();
                        }
                        
                    }
                }
            } catch (IllegalArgumentException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

    }
}
