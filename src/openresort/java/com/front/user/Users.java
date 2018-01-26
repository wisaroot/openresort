/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.user;

/**
 *
 * @author Administrator
 */
public class Users {
   private String username;
   private String passwords;
   private String name;
   private String usergroup;
   private String email;

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the passwords
     */
    public String getPasswords() {
        return passwords;
    }

    /**
     * @param passwords the passwords to set
     */
    public void setPasswords(String passwords) {
        this.passwords = passwords;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the usergroup
     */
    public String getUsergroup() {
        return usergroup;
    }

    /**
     * @param usergroup the usergroup to set
     */
    public void setUsergroup(String usergroup) {
        this.usergroup = usergroup;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
    public Users(){
        
    }
    public Users(String username,String passwords,String name,String usergroup,String email){
        this.username=username;
        this.passwords=passwords;
        this.name=name;
        this.usergroup=usergroup;
        this.email=email;
    }
}
