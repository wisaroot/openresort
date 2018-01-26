/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.blockroom;

/**
 *
 * @author i3
 */
public class BlockRoom {
    private String accountId;
    private String dtl;
    private String arrival;
    private String departure;
    private String room;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getDtl() {
        return dtl;
    }

    public void setDtl(String dtl) {
        this.dtl = dtl;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }
    
    public BlockRoom(String accountId, String dtl, String arrival, String departure, String room) {
        this.accountId = accountId;
        this.dtl = dtl;
        this.arrival = arrival;
        this.departure = departure;
        this.room = room;
    }
    
}
