/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.checkin;

/**
 *
 * @author i3
 */
public class GFolio {

    private String accountId;
    private String bookAccountId;
    private String dtl;
    private String roomNo;
    private String roomType;
    private String compliment;
    private String compBy;
    
    private String adult;
    private String child;
    private String rateCode;
    private String room;
    private String service;
    private String tax;
    private String extraBed;
    private String extraBedService;
    private String extraBedTax;
    private String abf;
    private String lunch;
    private String dinner;
    private String discount;
    private String discountBy;
    private String total;
    private String gFolioId;

    public String getgFolioId() {
        return gFolioId.trim();
    }

    public void setgFolioId(String gFolioId) {
        this.gFolioId = gFolioId;
    }
    public String getAbf() {
        return abf.trim();
    }

    public void setAbf(String abf) {
        this.abf = abf;
    }

    public String getAccountId() {
        return accountId.trim();
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getAdult() {
        return adult.trim();
    }

    public void setAdult(String adult) {
        this.adult = adult;
    }

    public String getBookAccountId() {
        return bookAccountId.trim();
    }

    public void setBookAccountId(String bookAccountId) {
        this.bookAccountId = bookAccountId;
    }

    public String getChild() {
        return child.trim();
    }

    public void setChild(String child) {
        this.child = child;
    }

    public String getCompBy() {
        return compBy.trim();
    }

    public void setCompBy(String compBy) {
        this.compBy = compBy;
    }

    public String getCompliment() {
        return compliment;
    }

    public void setCompliment(String compliment) {
        this.compliment = compliment;
    }

    public String getDinner() {
        return dinner.trim();
    }

    public void setDinner(String dinner) {
        this.dinner = dinner;
    }

    public String getDiscount() {
        return discount.trim();
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getDiscountBy() {
        return discountBy.trim();
    }

    public void setDiscountBy(String discountBy) {
        this.discountBy = discountBy;
    }

    public String getDtl() {
        return dtl.trim();
    }

    public void setDtl(String dtl) {
        this.dtl = dtl;
    }

    public String getExtraBed() {
        return extraBed.trim();
    }

    public void setExtraBed(String extraBed) {
        this.extraBed = extraBed;
    }

    public String getExtraBedService() {
        return extraBedService.trim();
    }

    public void setExtraBedService(String extraBedService) {
        this.extraBedService = extraBedService;
    }

    public String getExtraBedTax() {
        return extraBedTax.trim();
    }

    public void setExtraBedTax(String extraBedTax) {
        this.extraBedTax = extraBedTax;
    }

    public String getLunch() {
        return lunch.trim();
    }

    public void setLunch(String lunch) {
        this.lunch = lunch;
    }

    public String getRateCode() {
        return rateCode.trim();
    }

    public void setRateCode(String rateCode) {
        this.rateCode = rateCode;
    }

    public String getRoom() {
        return room.trim();
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public String getRoomNo() {
        return roomNo.trim();
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public String getRoomType() {
        return roomType.trim();
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getService() {
        return service.trim();
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getTax() {
        return tax.trim();
    }

    public void setTax(String tax) {
        this.tax = tax;
    }

    public String getTotal() {
        return total.trim();
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public GFolio() {
    }

    public GFolio(String accountId, String bookAccountId, String dtl, String roomNo, String roomType, String compliment, String compBy,  String adult, String child, String rateCode, String room, String service, String tax, String extraBed, String extraBedService, String extraBedTax, String abf, String lunch, String dinner, String discount, String discountBy, String total) {
        this.accountId = accountId;
        this.bookAccountId = bookAccountId;
        this.dtl = dtl;
        this.roomNo = roomNo;
        this.roomType = roomType;
        this.compliment = compliment;
        this.compBy = compBy;
        
        this.adult = adult;
        this.child = child;
        this.rateCode = rateCode;
        this.room = room;
        this.service = service;
        this.tax = tax;
        this.extraBed = extraBed;
        this.extraBedService = extraBedService;
        this.extraBedTax = extraBedTax;
        this.abf = abf;
        this.lunch = lunch;
        this.dinner = dinner;
        this.discount = discount;
        this.discountBy = discountBy;
        this.total = total;
    }
}
