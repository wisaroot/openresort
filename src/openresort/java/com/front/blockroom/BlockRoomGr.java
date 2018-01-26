/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.blockroom;

/**
 *
 * @author i3
 */
public class BlockRoomGr {
    private String accountId;
    private String dtl;
    private String arrival;
    private String departure;
    private String room;
    private String seq;
    private String rt;
    private String bt;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }
 public String getDtl() {
        return dtl;
    }

    public void setDtl(String dtl) {
        this.dtl = dtl;
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

   
     

    public String getRoom() {
        return room;
    }
 public void setRoom(String room) {
        this.room = room;
    }
  public String getseq() {
        return seq;
    }

    public void setseq(String seq) {
        this.seq = seq;
    }
    public void setrt(String rt) {
        this.rt = rt;
    }
     public String getrt() {
        return rt;
    }
      public void setbt(String bt) {
        this.bt = bt;
    }
     public String getbt() {
        return bt;
    }

   
    public BlockRoomGr(){
        
    }
    public BlockRoomGr(String accountId, String dtl, String arrival, String departure, String room,String seq,String rt,String bt) {
        this.accountId = accountId;
       this.dtl = dtl;
        this.arrival = arrival;
        this.departure = departure;
        this.room = room;
          this.seq = seq;
           this.rt = rt;
            this.bt = bt;
      
    }
    
}
