<%--
 * OpenResort PMS is a Web Application Properties Management (PMS) System that captures
 * all the essential functionalities required for any Front Office Hospitality.
 * Copyright (C) 2012 Holidays Network Co.,Ltd., http://www.openresort.net
 *
 * OpenResort PMS is free software; you can redistribute it and/or modify it under the terms of
 * GNU General Public License version 3.0 (GPLv3)
 * , or (at your option) any later version.
 *
 * OpenResort PMS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program;
 * if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA
 *
  --%>

<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
 <%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@ include file ="config.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.comis.frontsystem.guest.Guest"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>

<%!
    private void validate(Guest guest, List errorList) {
        String confidential = guest.getConfidential(),
                coa = guest.getCoa(),
                vip = guest.getVip(),
                reserveBy = guest.getReserveBy(),
                follioPattern = guest.getFollioPattern(),
                title = guest.getTitle(),
                last = guest.getLast(),
                first = guest.getFirst(),
                middle = guest.getMiddle(),
                sex = guest.getSex(),
                origin = guest.getOrigin(),
                bookBy = guest.getBookBy(),
                agent = guest.getAgent(),
                nationality = guest.getNationality(),
                birthDate = guest.getBirthDate(),
                company = guest.getCompany(),
                position = guest.getPosition(),
                creditCard = guest.getCreditCard(),
                cardNo = guest.getCardNo(),
                creditLimit = guest.getCreditLimit(),
                address1 = guest.getAddress1(),
                address2 = guest.getAddress2(),
                phone = guest.getPhone(),
                fax = guest.getFax(),
                country = guest.getCountry(),
                email = guest.getEmail(),
                passport = guest.getPassport(),
                arrival = guest.getArrival(),
                arrTime = guest.getArrTime(),
                arrFrom = guest.getArrFrom(),
                arrBy = guest.getArrBy(),
                departure = guest.getDeparture(),
                depTime = guest.getDepTime(),
                depTo = guest.getDepTo(),
               depBy = guest.getDepBy(),
                voucher = guest.getVoucher();
        
        //not null in db table gaccount
        if (Converter.isEmpty(arrival)) {
            errorList.add("arrival date is empty");
        }
        if (Converter.isEmpty(departure)) {
            errorList.add("departure date is empty");
        }
        if (Converter.isEmpty(follioPattern)) {
            errorList.add("follio pattern is empty");
        }
        //not null in db table guestname
        if (Converter.isEmpty(title)) {
            errorList.add("title is empty");
        }
        if (Converter.isEmpty(first)) {
            errorList.add("First name is empty");
        }
        //not null in db table guestinfo
        if (Converter.isEmpty(sex)) {
            errorList.add("sex is empty");
        }
        if (Converter.isEmpty(nationality)) {
            errorList.add("nationality is empty");
        }

    }

    private boolean saveGuest(Guest guest,WebUser user, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;
        String updateGuestInfoSQL = "UPDATE guestinfo SET gi_sex=?, gi_natno=?, gi_crcard=?, gi_cardno=?, gi_vipno=?, gi_crlimit=?, gi_birthdate=?, gi_homeaddr1=?, gi_homeaddr2=?, gi_ctno=?, gi_telno=?, gi_faxno=?, gi_email=?, gi_company=?, gi_positions=?, gi_passport=?, gi_confflag=? WHERE gi_guestno=(select ga_guestno from gaccount where ga_accno=?);";
        String updateGuestNameSQL = "UPDATE guestname SET  gn_titleno=?, gn_fname=?, gn_lname=?, gn_mname=? WHERE gn_guestno=(select ga_guestno from gaccount where ga_accno=?);";
        String updateGAccountSQL = "UPDATE gaccount SET  ga_gsttype=?, ga_rsvtypeno=?, ga_bookby=?, ga_acctype=?, ga_walkin=?,  ga_agentno=?, ga_orino=?, ga_arrival=?, ga_arrtime=?, ga_arrfrom=?, ga_arrby=?, ga_departure=?, ga_deptime=?, ga_depto=?, ga_depby=?, ga_fpatno=?, ga_recdate=?, ga_userno=?, ga_coa=? WHERE ga_accno=?;";
        
        boolean isSave = false;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(updateGuestInfoSQL);
            preparedStatementInsert.setString(1,guest.getSex());
            preparedStatementInsert.setString(2,guest.getNationality());
            preparedStatementInsert.setString(3,guest.getCreditCard());
            preparedStatementInsert.setString(4,guest.getCardNo());
            preparedStatementInsert.setString(5,guest.getVip());
            preparedStatementInsert.setDouble(6,Converter.parseDouble(guest.getCreditLimit()));
            preparedStatementInsert.setDate(7,Converter.parseSQLDate(guest.getBirthDate()));
            preparedStatementInsert.setString(8,guest.getAddress1());
            preparedStatementInsert.setString(9,guest.getAddress2());
            preparedStatementInsert.setString(10,guest.getCountry());
            preparedStatementInsert.setString(11,guest.getPhone());
            preparedStatementInsert.setString(12,guest.getFax());
            preparedStatementInsert.setString(13,guest.getEmail());
            preparedStatementInsert.setString(14,guest.getCompany());
            preparedStatementInsert.setString(15,guest.getPosition());
            preparedStatementInsert.setString(16,guest.getPassport());
            preparedStatementInsert.setString(17,Converter.parseToYesNo(guest.getConfidential()));
            preparedStatementInsert.setInt(18,Converter.parseInt(guest.getAccountId()));
            preparedStatementInsert.executeUpdate();
            

            preparedStatementInsert = dbConnection.prepareStatement(updateGuestNameSQL);
            
            preparedStatementInsert.setString(1,guest.getTitle());
            preparedStatementInsert.setString(2,guest.getFirst());
            preparedStatementInsert.setString(3,guest.getLast());
            preparedStatementInsert.setString(4,guest.getMiddle());
            preparedStatementInsert.setInt(5, Converter.parseInt(guest.getAccountId()));
            preparedStatementInsert.executeUpdate();
            
            preparedStatementInsert = dbConnection.prepareStatement(updateGAccountSQL);
            //ga_accstat,
           // preparedStatementInsert.setString(1,"I");
            //ga_gsttype, 
            preparedStatementInsert.setString(1,"D");
            //ga_rsvtypeno,
            preparedStatementInsert.setString(2,guest.getReserveBy());
            //ga_bookby,
            preparedStatementInsert.setString(3,guest.getBookBy());
            //ga_acctype,
            preparedStatementInsert.setString(4,"H");
            //ga_walkin,
            preparedStatementInsert.setString(5,"N");
            //ga_guestno,
            
            //ga_agentno,
            preparedStatementInsert.setInt(6,Converter.parseInt(guest.getAgent()));
            //ga_orino,
            preparedStatementInsert.setString(7,guest.getOrigin());
            //ga_arrival,
            preparedStatementInsert.setDate(8,Converter.parseSQLDate(guest.getArrival()));
            //ga_arrtime,
            preparedStatementInsert.setTime(9,Converter.parseSQLTime(guest.getArrTime()));
            //ga_arrfrom, 
            preparedStatementInsert.setString(10,guest.getArrFrom());
            //ga_arrby, 
            preparedStatementInsert.setString(11,guest.getArrBy());
            //ga_departure, 
            preparedStatementInsert.setDate(12,Converter.parseSQLDate(guest.getDeparture()));
            //ga_deptime, 
            preparedStatementInsert.setTime(13,Converter.parseSQLTime(guest.getDepTime()));
            //ga_depto,
            preparedStatementInsert.setString(14,guest.getDepTo());
            //ga_depby,
            preparedStatementInsert.setString(15,guest.getDepBy());
            //ga_fpatno,
            preparedStatementInsert.setString(16,guest.getFollioPattern());
            //ga_recdate,
            preparedStatementInsert.setDate(17,Converter.parseSQLDate(Converter.getCurrentDate()));
            //ga_userno,
            preparedStatementInsert.setString(18,user.getUsername());
            //ga_coa
            preparedStatementInsert.setString(19,Converter.parseToYesNo(guest.getCoa()));
            preparedStatementInsert.setInt(20,Converter.parseInt(guest.getAccountId()));
            preparedStatementInsert.executeUpdate();
            
            dbConnection.commit();
            isSave = true;
            

        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementInsert.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        return isSave;
    }
%>
<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors"+session.getId(), errorList);
    //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
    //String title, String last, String first, String middle, String sex, String origin, String bookBy,
    //String agent, String nationality, String birthDate, String company, String position, String creditCard,
    //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
    //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
    //String arrBy, String departure, String depTime, String depTo, String depBy
    Guest guest = new Guest(
            (String) request.getParameter("accountId"),
            (String) request.getParameter("confidential"),
            (String) request.getParameter("coa"),
            (String) request.getParameter("vip"),
            (String) request.getParameter("reserveBy"),
            (String) request.getParameter("follioPattern"),
            (String) request.getParameter("title"),
            (String) request.getParameter("last"),
            (String) request.getParameter("first"),
            (String) request.getParameter("middle"),
            (String) request.getParameter("sex"),
            (String) request.getParameter("origin"),
            (String) request.getParameter("bookBy"),
            (String) request.getParameter("agent"),
            (String) request.getParameter("nationality"),
            (String) request.getParameter("birthDate"),
            (String) request.getParameter("company"),
            (String) request.getParameter("position"),
            (String) request.getParameter("creditCard"),
            (String) request.getParameter("cardNo"),
            (String) request.getParameter("creditLimit"),
            (String) request.getParameter("address1"),
            (String) request.getParameter("address2"),
            (String) request.getParameter("phone"),
            (String) request.getParameter("fax"),
            (String) request.getParameter("country"),
            (String) request.getParameter("email"),
            (String) request.getParameter("passport"),
            (String) request.getParameter("arrival"),
            (String) request.getParameter("arrTime"),
            (String) request.getParameter("arrFrom"),
            (String) request.getParameter("arrBy"),
            (String) request.getParameter("departure"),
            (String) request.getParameter("depTime"),
            (String) request.getParameter("depTo"),
            (String) request.getParameter("depBy"));
    
    WebUser user=(WebUser)session.getAttribute(""+session.getId());
    validate(guest, errorList);
    if (errorList.size() > 0) {
        
        response.sendRedirect("editguest.jsp?acc="+guest.getAccountId());
    } else {
        if (saveGuest(guest,user, errorList)) {
            response.sendRedirect("guest.jsp");
        } else {
            
            response.sendRedirect("editguest.jsp?acc="+guest.getAccountId());
        }
    }
%>