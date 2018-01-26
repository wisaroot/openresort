/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.booking;

/**
 *
 * @author i3
 */
public class BookingDetailsCK {
    private String accountId;
     private String bkacc;
    private String dtl;
    private String adult;
    private String child;
    private String qty;
    private String allotmentQty;
    private String arrival;
    private String departure;
    private String roomType;
    private String bedType;
    private String rateCode;
    private String compliment;
    private String chargeTo;
    private String room;
    private String service;
    private String tax;
    private String extraBed;
    private String extBedService;
    private String extBedTax;
    private String abf;
    private String lunch;
    private String dinner;
    private String discount;
    private String total;

    public String getAbf() {
        return abf;
    }

    public void setAbf(String abf) {
        this.abf = abf;
    }
     public String getbkacc() {
        return bkacc;
    }

    public void setbkacc(String bkacc) {
        this.bkacc = bkacc;
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

    public String getAllotmentQty() {
        return allotmentQty;
    }

    public void setAllotmentQty(String allotmentQty) {
        this.allotmentQty = allotmentQty;
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

    public String getDinner() {
        return dinner;
    }

    public void setDinner(String dinner) {
        this.dinner = dinner;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getDtl() {
        return dtl;
    }

    public void setSeq(String dtl) {
        this.dtl = dtl;
    }

    public String getExtBedService() {
        return extBedService;
    }

    public void setExtBedService(String extBedService) {
        this.extBedService = extBedService;
    }

    public String getExtBedTax() {
        return extBedTax;
    }

    public void setExtBedTax(String extBedTax) {
        this.extBedTax = extBedTax;
    }

    public String getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(String extraBed) {
        this.extraBed = extraBed;
    }

    public String getLunch() {
        return lunch;
    }

    public void setLunch(String lunch) {
        this.lunch = lunch;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getRateCode() {
        return rateCode;
    }

    public void setRateCode(String rateCode) {
        this.rateCode = rateCode;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getTax() {
        return tax;
    }

    public void setTax(String tax) {
        this.tax = tax;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    public BookingDetailsCK(){
        
    }

    public BookingDetailsCK(String accountId, String dtl,String bkacc, String adult, String child, String qty, String allotmentQty, String arrival, String departure, String roomType, String bedType, String rateCode, String compliment, String chargeTo, String room, String service, String tax, String extraBed, String extBedService, String extBedTax, String abf, String lunch, String dinner, String discount, String total) {
        this.accountId = accountId;
        this.dtl = dtl;
        this.bkacc = bkacc;
        this.adult = adult;
        this.child = child;
        this.qty = qty;
        this.allotmentQty = allotmentQty;
        this.arrival = arrival;
        this.departure = departure;
        this.roomType = roomType;
        this.bedType = bedType;
        this.rateCode = rateCode;
        this.compliment = compliment;
        this.chargeTo = chargeTo;
        this.room = room;
        this.service = service;
        this.tax = tax;
        this.extraBed = extraBed;
        this.extBedService = extBedService;
        this.extBedTax = extBedTax;
        this.abf = abf;
        this.lunch = lunch;
        this.dinner = dinner;
        this.discount = discount;
        this.total = total;
    }
    
}
