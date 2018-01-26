/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.booking;

/**
 *
 * @author i3
 */
public class RequirementNote {
    private String amount;
    private String charge;
    private String chargeType;
    private String department;
    private String endDate;
    private String eventTime;
    private String fromDate;
    private String note;
    private String remark;
    private String requirement;
    private String accountId;
    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCharge() {
        //System.out.print("kk"+charge+"llllllllllllllllllllllllllllllllllllllllllllllllll");
     //   if (charge.equals("Y")){}else{ charge ="N";}
       //     else {charge=null;};
        if (charge!=null){} else charge="N";;
        return charge;
    }

    public void setCharge(String charge) {
        //if (charge!="Y")charge="N";
        this.charge = charge;
    }

    public String getChargeType() {
        return chargeType;
    }

    public void setChargeType(String chargeType) {
        this.chargeType = chargeType;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public RequirementNote(String amount, String charge, String chargeType, String department, String endDate, String eventTime, String fromDate, String note, String remark, String requirement, String accountId) {
        this.amount = amount;
        this.charge = charge;
        this.chargeType = chargeType;
        this.department = department;
        this.endDate = endDate;
        this.eventTime = eventTime;
        this.fromDate = fromDate;
        this.note = note;
        this.remark = remark;
        this.requirement = requirement;
        this.accountId = accountId;
    }

    
    
}
