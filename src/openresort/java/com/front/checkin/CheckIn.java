/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.checkin;

/**
 *
 * @author i3
 */
public class CheckIn {
    private String accountId;
    private String bookingAccountId;
    private String roomNo;
    private String dtl;

    public String getAccountId() {
        return accountId.trim();
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getBookingAccountId() {
        return bookingAccountId.trim();
    }

    public void setBookingAccountId(String bookingAccountId) {
        this.bookingAccountId = bookingAccountId;
    }

    public String getDtl() {
        return dtl.trim();
    }

    public void setDtl(String dtl) {
        this.dtl = dtl;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public CheckIn() {
    }
    
   // public CheckIn(String accountId, String bookingAccountId, String roomNo, String dtl) {
   public CheckIn(String accountId, String roomNo) {
        
    this.accountId = accountId;
     this.roomNo = roomNo;
        this.bookingAccountId = bookingAccountId;
       
        this.dtl = dtl;
    }
    
}
