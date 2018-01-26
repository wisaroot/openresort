/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.comis.frontsystem.guest;

import com.comis.frontsystem.util.DefaultValue;

/**
 *
 * @author Administrator
 */
public class GuestGr {
    private String accountId=DefaultValue.DUMMYINT;
    private String confidential=DefaultValue.NO;
    private String coa=DefaultValue.NO;
    private String vip=DefaultValue.PATTERN;
    private String reserveBy=DefaultValue.PATTERN;
    private String follioPattern=DefaultValue.PATTERN;
    private String title=DefaultValue.PATTERN;
    private String last=DefaultValue.DUMMY;
    private String first=DefaultValue.DUMMY;
    private String middle=DefaultValue.DUMMY;
    private String sex=DefaultValue.DUMMYINT;
    private String origin=DefaultValue.PATTERN;
    private String bookBy=DefaultValue.DUMMY;
    private String agent=DefaultValue.DUMMYINT;
    private String nationality=DefaultValue.DUMMYINT;
    private String birthDate=DefaultValue.MIN_DATE;
    private String company=DefaultValue.DUMMY;
    private String position=DefaultValue.DUMMY;
    private String creditCard=DefaultValue.PATTERN;
    private String cardNo=DefaultValue.DUMMY;
    private String creditLimit=DefaultValue.DUMMYINT;
    private String address1=DefaultValue.DUMMY;
    private String address2=DefaultValue.DUMMY;
    private String phone=DefaultValue.DUMMY;
    private String fax=DefaultValue.DUMMY;
    private String country=DefaultValue.DUMMYINT;
    private String email=DefaultValue.DUMMY;
    private String passport=DefaultValue.DUMMY;
    private String arrival=DefaultValue.MIN_DATE;
    private String arrTime=DefaultValue.MIN_TIME;
    private String arrFrom=DefaultValue.DUMMY;
    private String arrBy=DefaultValue.DUMMY;
    private String departure=DefaultValue.MIN_DATE;
    private String depTime=DefaultValue.MIN_TIME;
    private String depTo=DefaultValue.DUMMY;
    private String depBy=DefaultValue.DUMMY;
    private String bkacc;
   private String dtl;
   private String seqq;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        if(accountId==null)
            this.accountId=DefaultValue.DUMMYINT;
        else
            this.accountId = accountId;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        if(address1==null)
            this.address1=DefaultValue.DUMMYINT;
        else
            this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        if(address2==null)
            this.address2 = address2;
        else
            this.address2=address2;
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
        if(arrBy==null)
            this.arrBy=DefaultValue.DUMMY;
        else
            this.arrBy = arrBy;
    }

    public String getArrFrom() {
        return arrFrom;
    }

    public void setArrFrom(String arrFrom) {
        if(arrFrom==null)
            this.arrFrom=DefaultValue.DUMMY;
        else
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

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        if(arrival==null)
            this.arrival=DefaultValue.DUMMY;
        else
            this.arrival = arrival;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        if(birthDate==null)
            this.birthDate=DefaultValue.MIN_DATE;
        else
            this.birthDate = birthDate;
    }

    public String getBookBy() {
        return bookBy;
    }

    public void setBookBy(String bookBy) {
        if(bookBy==null)
            this.bookBy=DefaultValue.DUMMY;
        else
            this.bookBy = bookBy;
    }
     public String getdtl() {
        return dtl;
    }

    public void setdtl(String dtl) {
       
            this.dtl = dtl;
    }
     
    
      public String getbkacc() {
        return bkacc;
    }

    public void setbkacc(String bkacc) {
       
            this.bkacc = bkacc;
    }

      public String getseqq() {
        return seqq;
    }

    public void setseqq(String seqq) {
       
            this.seqq = seqq;
    }
    
    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        if(cardNo==null)
            this.cardNo=DefaultValue.DUMMY;
        else
            this.cardNo = cardNo;
    }

    public String getCoa() {
        return coa;
    }

    public void setCoa(String coa) {
        if(coa==null)
            this.coa=DefaultValue.NO;
        else
            this.coa = coa;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        if(company==null)
            this.company=DefaultValue.DUMMY;
        else
            this.company = company;
    }

    public String getConfidential() {
        return confidential;
    }

    public void setConfidential(String confidential) {
        if(confidential==null)
            this.confidential=DefaultValue.NO;
        else
            this.confidential = confidential;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        if(country==null)
            this.country=DefaultValue.DUMMYINT;
        else
            this.country = country;
    }

    public String getCreditCard() {
        return creditCard;
    }

    public void setCreditCard(String creditCard) {
        if(creditCard==null)
            this.creditCard=DefaultValue.PATTERN;
        else
            this.creditCard = creditCard;
    }

    public String getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(String creditLimit) {
        if(creditLimit==null)
            this.creditLimit=DefaultValue.DUMMYINT;
        else
            this.creditLimit = creditLimit;
    }

    public String getDepBy() {
        return depBy;
    }

    public void setDepBy(String depBy) {
        if(depBy==null)
            this.depBy=DefaultValue.DUMMY;
        else
            this.depBy = depBy;
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
        if(depTo==null)
            this.depTo=DefaultValue.DUMMY;
        else
            this.depTo = depTo;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        if(departure==null)
            this.departure=DefaultValue.MIN_DATE;
        else
            this.departure = departure;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if(email==null)
            this.email=DefaultValue.DUMMY;
        else
            this.email = email;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        if(fax==null)
            this.fax=DefaultValue.DUMMY;
        else
            this.fax = fax;
    }

    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        if(first==null)
            this.first=DefaultValue.DUMMY;
        else
            this.first = first;
    }

    public String getFollioPattern() {
        return follioPattern;
    }

    public void setFollioPattern(String follioPattern) {
        if(follioPattern==null)
            this.follioPattern=DefaultValue.PATTERN;
        else
            this.follioPattern = follioPattern;
    }

    public String getLast() {
        return last;
    }

    public void setLast(String last) {
        if(last==null)
            this.last=DefaultValue.DUMMY;
        else
            this.last = last;
    }

    public String getMiddle() {
        return middle;
    }

    public void setMiddle(String middle) {
        if(middle==null)
            this.middle=DefaultValue.DUMMY;
        else
            this.middle = middle;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        if(nationality==null)
            this.nationality=DefaultValue.DUMMYINT;
        else
            this.nationality = nationality;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        if(origin==null)
            this.origin=DefaultValue.PATTERN;
        else
            this.origin = origin;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        if(passport==null)
            this.passport=DefaultValue.DUMMY;
        else
            this.passport = passport;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        if(phone==null)
            this.phone=DefaultValue.DUMMY;
        else
            this.phone = phone;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        if(position==null)
            this.position=DefaultValue.DUMMY;
        else
            this.position = position;
    }

    public String getReserveBy() {
        return reserveBy;
    }

    public void setReserveBy(String reserveBy) {
        if(reserveBy==null)
            this.reserveBy=DefaultValue.PATTERN;
        else
            this.reserveBy = reserveBy;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        if(sex==null)
            this.sex=DefaultValue.DUMMYINT;
        else
            this.sex = sex;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        if(title==null)
            this.title=DefaultValue.PATTERN;
        else
            this.title = title;
    }

    public String getVip() {
        return vip;
    }

    public void setVip(String vip) {
        if(vip==null)
            this.vip=DefaultValue.PATTERN;
        else
            this.vip = vip;
    }
     public GuestGr(){
    
    }

    public GuestGr(String accountId,String bkacc,String dtl,String seqq,String confidential,String coa, String vip, String reserveBy, String follioPattern, String title, 
            String last, 
            String first, 
            String middle, 
            String sex, 
            String origin, 
            String bookBy, 
            String agent, 
            String nationality, 
            String birthDate, 
            String company, 
            String position, 
            String creditCard, 
            String cardNo, 
            String creditLimit, 
            String address1, 
            String address2, 
            String phone, 
            String fax, 
            String country, 
            String email, 
            String passport, 
            String arrival, 
            String arrTime, 
            String arrFrom, 
            String arrBy, 
            String departure, 
            String depTime, 
            String depTo, 
            String depBy) {
        
         
        setAccountId(accountId);
        setbkacc(bkacc);
         setdtl(dtl);
         setseqq(seqq);
       setConfidential(confidential);
       setCoa(coa);
       setVip(vip);
       setReserveBy(reserveBy);
       setFollioPattern(follioPattern);
       setTitle(title);
       setFirst(first);   //edit
       setLast(last);
       setMiddle(middle);
       setSex(sex);
       setOrigin(origin);
       setBookBy(bookBy);
       setAgent(agent);
       setNationality(nationality);
       setBirthDate(birthDate);
       setCompany(company);
       setPosition(position);
       setCreditCard(creditCard);
       setCardNo(cardNo);
       setCreditLimit(creditLimit);
       setAddress1(address1);
       setAddress2(address2);
       setPhone(phone);
       setFax(fax);
       setCountry(country);
       setEmail(email);
       setPassport(passport);
       setArrival(arrival);
       setArrTime(arrTime);
       setArrFrom(arrFrom);
       setArrBy(arrBy);
       setDeparture(departure);
       setDepTime(depTime);
       setDepTo(depTo);
       setDepBy(depBy);
       
       
    }
    
}
