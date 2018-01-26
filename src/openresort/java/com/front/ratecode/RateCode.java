/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.ratecode;

/**
 *
 * @author Administrator
 */
public class RateCode {
    private String accountId;
    private String chgDate;
    private String rateCode;
    private String seq;
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
    private String total;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getAbf() {
        return abf;
    }

    public void setAbf(String abf) {
        this.abf = abf;
    }

    public String getChgDate() {
        return chgDate;
    }

    public void setChgDate(String chgDate) {
        this.chgDate = chgDate;
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

    public String getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(String extraBed) {
        this.extraBed = extraBed;
    }

    public String getExtraBedService() {
        return extraBedService;
    }

    public void setExtraBedService(String extraBedService) {
        this.extraBedService = extraBedService;
    }

    public String getExtraBedTax() {
        return extraBedTax;
    }

    public void setExtraBedTax(String extraBedTax) {
        this.extraBedTax = extraBedTax;
    }

    public String getLunch() {
        return lunch;
    }

    public void setLunch(String lunch) {
        this.lunch = lunch;
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

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
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

    public RateCode() {
    }

    public RateCode(String accountId,String chgDate, String rateCode, String seq, String room, String service, String tax, String extraBed, String extraBedService, String extraBedTax, String abf, String lunch, String dinner, String discount, String total) {
        this.accountId = accountId;
        this.chgDate = chgDate;
        this.rateCode = rateCode;
        this.seq = seq;
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
        this.total = total;
    }
    
}
