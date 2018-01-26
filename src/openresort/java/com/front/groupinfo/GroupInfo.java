/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.groupinfo;

/**
 *
 * @author V13
 */
public class GroupInfo {
    private String name;
    private String nationality;
    private String company;
    private String arrival;
    private String departure;
    private String agent;
    private String accountId;
    private String confirmNo;
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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getConfirmNo() {
        return confirmNo;
    }

    public void setConfirmNo(String confirmNo) {
        this.confirmNo = confirmNo;
    }
    
    public GroupInfo() {
    }

    public GroupInfo(String name, String nationality, String company, String arrival, String departure, String agent, String accountId, String confirmNo) {
        this.name = name;
        this.nationality = nationality;
        this.company = company;
        this.arrival = arrival;
        this.departure = departure;
        this.agent = agent;
        this.accountId = accountId;
        this.confirmNo = confirmNo;
    }

    
    
}
