/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.group;
import com.comis.frontsystem.util.DefaultValue;
/**
 *
 * @author i3
 */
public class Group {
    
    
    
    
    private String accountId=DefaultValue.DUMMYINT;
   
   
  
    
    
  
    private String entry;
    private String expire;
  
   
    private String grpname;
    private String issue;
   
 
   
    private String visaType;
    
  
    private String coa=DefaultValue.NO;
    private String vip=DefaultValue.PATTERN;
    private String reserveBy=DefaultValue.PATTERN;
    private String follioPattern=DefaultValue.PATTERN;
 
    private String origin=DefaultValue.PATTERN;
    private String bookBy=DefaultValue.DUMMY;
    private String agent=DefaultValue.DUMMYINT;
    private String nationality=DefaultValue.DUMMYINT;
  
    private String company=DefaultValue.DUMMY;
  
    private String creditLimit=DefaultValue.DUMMYINT;
  
    private String phone=DefaultValue.DUMMY;
    private String fax=DefaultValue.DUMMY;
    private String country=DefaultValue.DUMMYINT;
    private String email=DefaultValue.DUMMY;
 
    private String arrival=DefaultValue.MIN_DATE;
    private String arrTime=DefaultValue.MIN_TIME;
    private String arrFrom=DefaultValue.DUMMY;
    private String arrBy=DefaultValue.DUMMY;
    private String departure=DefaultValue.MIN_DATE;
    private String depTime=DefaultValue.MIN_TIME;
    private String depTo=DefaultValue.DUMMY;
    private String depBy=DefaultValue.DUMMY;

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
        if(agent==null)
            this.agent=DefaultValue.DUMMYINT;
        else
            this.agent = agent;
    }

    public String getArrBy() {
        return arrBy;
    }

    public void setArrBy(String arrBy) {
        
            this.arrBy = arrBy;
    }

    

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    public String getArrFrom() {
        return arrFrom;
    }

    public void setArrFrom(String arrFrom) {
        this.arrFrom = arrFrom;
    }

     public String getArrTime() {
        return arrTime;
    }

    public void setArrTime(String arrTime) {
        if(arrTime==null)
            this.arrTime=DefaultValue.MIN_TIME;
        else
            this.arrTime = arrTime;
    }
    public String getBookBy() {
        return bookBy;
    }

    public void setBookBy(String bookBy) {
       if(bookBy==null)
            this.bookBy=reserveBy;
        else
            this.bookBy = bookBy;
    }

    public String getCoa() {
        return coa;
    }

    public void setCoa(String coa) {
        this.coa = coa;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(String creditLimit) {
        this.creditLimit = creditLimit;
    }

    public String getDepBy() {
        return depBy;
    }

    public void setDepBy(String depBy) {
        this.depBy = depBy;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

     public String getDepTime() {
        return depTime;
    }

    public void setDepTime(String depTime) {
        if(depTime==null)
            this.depTime=DefaultValue.MIN_TIME;
        else
            this.depTime = depTime;
    }

    public String getDepTo() {
        return depTo;
    }

    public void setDepTo(String depTo) {
        this.depTo = depTo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEntry() {
        return entry;
    }

    public void setEntry(String entry) {
        this.entry = entry;
    }

    public String getExpire() {
        return expire;
    }

    public void setExpire(String expire) {
        this.expire = expire;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }
    
    public String getFollioPattern() {
        return follioPattern;
    }

    public void setFollioPattern(String follioPattern) {
        this.follioPattern = follioPattern;
    }
    public String getGrpname() {
        return grpname;
    }

    public void setGrpname(String grpname) {
        this.grpname = grpname;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getReserveBy() {
        return reserveBy;
    }

    public void setReserveBy(String reserveBy) {
        this.reserveBy = reserveBy;
    }

    public String getVip() {
        return vip;
    }

    public void setVip(String vip) {
        this.vip = vip;
    }

    public String getVisaType() {
        return visaType;
    }

    public void setVisaType(String visaType) {
        this.visaType = visaType;
    }

    public Group(String accountId, String agent, String arrBy, String arrival, String arrFrom, String arrTime, String bookBy, String coa, String company, String country, String creditLimit, String depBy, String departure, String depTime, String depTo, String email, String entry, String expire, String fax, String follioPattern, String grpname, String issue, String nationality, String origin, String phone, String reserveBy, String vip, String visaType) {
         setAccountId(accountId);
       setReserveBy(reserveBy);     
       setOrigin(origin);
       setBookBy(bookBy);
       setAgent(agent);
     
       setArrival(arrival);
       setArrTime(arrTime);
       setArrFrom(arrFrom);
       setArrBy(arrBy);
       setDeparture(departure);
       setDepTime(depTime);
       setDepTo(depTo);
       setDepBy(depBy);
        
        
     
        this.coa = coa;
        this.company = company;
        this.country = country;
        this.creditLimit = creditLimit;
     
        this.email = email;
        this.entry = entry;
        this.expire = expire;
        this.fax = fax;
        this.follioPattern = follioPattern;
        this.grpname = grpname;
        this.issue = issue;
        this.nationality = nationality;
     
        this.phone = phone;
       
        this.vip = vip;
        this.visaType = visaType;
    }

    
  
}
