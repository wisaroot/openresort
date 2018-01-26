/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.group;

/**
 *
 * @author V13
 */
public class NameList {
    private String bookingAccountId;//
    private String dtl;//
    private String seq;
    private String roomNo;//
    private String adult;//
    private String child;//
    private String arrival;//
    private String departure;//
    private String roomType;//
    private String bedType;//
    private String compliment;//
    private String rateNo;//
    private String chargeTo;//
    private String titleNo;//
    private String firstName;//
    private String middleName;//
    private String lastName;//
    private String sex;//
    private String nationality;//
    private String accountId;//
    private String passport;//
    private String issue;//
    private String expire;//
    private String visaType;//
    private String entry;//

    public String getEntry() {
        return entry;
    }

    public void setEntry(String entry) {
        this.entry = entry;
    }
    public String getVisaType() {
        return visaType;
    }

    public void setVisaType(String visaType) {
        this.visaType = visaType;
    }
    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getAdult() {
        return adult;
    }

    public void setAdult(String adult) {
        this.adult = adult;
    }

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    public String getBedType() {
        return bedType;
    }

    public void setBedType(String bedType) {
        this.bedType = bedType;
    }

    public String getBookingAccountId() {
        return bookingAccountId;
    }

    public void setBookingAccountId(String bookingAccountId) {
        this.bookingAccountId = bookingAccountId;
    }

    public String getChargeTo() {
        return chargeTo;
    }

    public void setChargeTo(String chargeTo) {
        this.chargeTo = chargeTo;
    }

    public String getChild() {
        return child;
    }

    public void setChild(String child) {
        this.child = child;
    }

    public String getCompliment() {
        return compliment;
    }

    public void setCompliment(String compliment) {
        this.compliment = compliment;
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

    public String getExpire() {
        return expire;
    }

    public void setExpire(String expire) {
        this.expire = expire;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public String getRateNo() {
        return rateNo;
    }

    public void setRateNo(String rateNo) {
        this.rateNo = rateNo;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTitleNo() {
        return titleNo;
    }

    public void setTitleNo(String titleNo) {
        this.titleNo = titleNo;
    }

    public NameList(String bookingAccountId, String dtl, String seq, String roomNo, String adult, String child, String arrival, String departure, String roomType, String bedType, String compliment, String rateNo, String chargeTo, String titleNo, String firstName, String middleName, String lastName, String sex, String nationality, String accountId, String passport, String issue, String expire,String visaType,String entry) {
        this.bookingAccountId = bookingAccountId;
        this.dtl = dtl;
        this.seq = seq;
        this.roomNo = roomNo;
        this.adult = adult;
        this.child = child;
        this.arrival = arrival;
        this.departure = departure;
        this.roomType = roomType;
        this.bedType = bedType;
        this.compliment = compliment;
        this.rateNo = rateNo;
        this.chargeTo = chargeTo;
        this.titleNo = titleNo;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.sex = sex;
        this.nationality = nationality;
        this.accountId = accountId;
        this.passport = passport;
        this.issue = issue;
        this.expire = expire;
        this.visaType=visaType;
        this.entry=entry;
    }
    public NameList(){
    
    }
}
