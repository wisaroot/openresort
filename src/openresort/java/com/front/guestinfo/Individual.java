/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.guestinfo;

/**
 *
 * @author i3
 */
public class Individual {
    private String first;
    private String last;
  
    
    private String nationality;
    private String arrival;
    private String departure;
 
    private String agent;
    private String group;
    private String roomNo;
    private String accountId;
    private String comfirmNo;
    private String status;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getAgent() {
        return agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    public String getComfirmNo() {
        return comfirmNo;
    }

    public void setComfirmNo(String comfirmNo) {
        this.comfirmNo = comfirmNo;
    }

  
    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        this.first = first;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getLast() {
        return last;
    }

    public void setLast(String last) {
        this.last = last;
    }

   

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

  

    public Individual(String first, String last,   String nationality, String arrival, String departure,  String agent, String group, String roomNo, String accountId, String comfirmNo, String status) {
        this.first = first;
        this.last = last;
      
        this.nationality = nationality;
        this.arrival = arrival;
        this.departure = departure;
       
        this.agent = agent;
        this.group = group;
        this.roomNo = roomNo;
        this.accountId = accountId;
        this.comfirmNo = comfirmNo;
        this.status = status;
    }
    
}
