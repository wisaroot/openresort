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

<%@page import="com.comis.frontsystem.group.NameList"%>
<%--
<%@page import="com.comis.frontsystem.checkin.CheckIn"%>
--%>
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.comis.frontsystem.guest.GuestGr"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%--
<%@include file="checkin_1.jsp"%>
--%>
<%!


    private void validate(GuestGr guest, List errorList) {
        String confidential = guest.getConfidential(),
                bkacc = guest.getbkacc(),
                dtl = guest.getdtl(),
                seqq = guest.getseqq(),
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
                depBy = guest.getDepBy();

        //not null in db table gaccount
        if (Converter.isEmpty(bkacc)) {
            errorList.add("bkacc date is empty");
        }
        if (Converter.isEmpty(dtl)) {
            errorList.add("dtl date is empty");
        }
        if (Converter.isEmpty(seqq)) {
            errorList.add("seqq date is empty");
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

    private boolean saveBooking(String user1,String pw,String url,String driver,
GuestGr guest, WebUser user, List errorList) throws SQLException {
        Connection dbConnection = null;
         
       
        PreparedStatement preparedStatementInsert = null;
        String insertGuestInfoSQL = "INSERT INTO guestinfo(gi_sex, gi_natno, gi_crcard, gi_cardno, gi_vipno, gi_crlimit, gi_birthdate, gi_homeaddr1, gi_homeaddr2, gi_ctno, gi_telno, gi_faxno, gi_email, gi_company, gi_positions, gi_passport, gi_ptype, gi_confflag ,gi_visatypeno)VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (select vs_descr from visatype where vs_id='02'), ?, '02');";
        String insertGuestNameSQL = "INSERT INTO guestname(gn_guestno, gn_titleno, gn_fname, gn_lname, gn_mname)VALUES (?, ?, ?, ?, ?);";
        String insertGAccountSQL = "INSERT INTO gaccount(ga_accstat, ga_gsttype, ga_rsvtypeno, ga_bookby, ga_acctype, ga_walkin, ga_guestno,ga_agentno, ga_orino, ga_arrival, ga_arrtime, ga_arrfrom, ga_arrby, ga_departure, ga_deptime, ga_depto, ga_depby, ga_fpatno, ga_recdate, ga_userno, ga_coa)VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        //String insertNamelistSQL = "update namelist set nl_titleno=?,nl_fname=?,nl_lname=?,nl_mname=?, nl_ownaccno=?,  nl_arrdate=?, nl_depdate=?, nl_natno=? where nl_accno=" + bkacc + " and nl_dtlseq=" + dtl + " and nl_seq=" + seq + ";";
   String insertNamelistSQL = "update namelist set nl_titleno=?,nl_fname=?,nl_lname=?,nl_mname=?, nl_ownaccno=?,  nl_arrdate=?, nl_depdate=?, nl_natno=? where nl_accno=? and nl_dtlseq=? and nl_seq=? ;";

        ResultSet generatedKeys = null;
        boolean isSave = false;
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(insertGuestInfoSQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatementInsert.setString(1, guest.getSex());
            preparedStatementInsert.setString(2, guest.getNationality());
            preparedStatementInsert.setString(3, guest.getCreditCard());
            preparedStatementInsert.setString(4, guest.getCardNo());
            preparedStatementInsert.setString(5, guest.getVip());
            preparedStatementInsert.setDouble(6, Converter.parseDouble(guest.getCreditLimit()));
            preparedStatementInsert.setDate(7, Converter.parseSQLDate(guest.getBirthDate()));
            preparedStatementInsert.setString(8, guest.getAddress1());
            preparedStatementInsert.setString(9, guest.getAddress2());
            preparedStatementInsert.setString(10, guest.getCountry());
            preparedStatementInsert.setString(11, guest.getPhone());
            preparedStatementInsert.setString(12, guest.getFax());
            preparedStatementInsert.setString(13, guest.getEmail());
            preparedStatementInsert.setString(14, guest.getCompany());
            preparedStatementInsert.setString(15, guest.getPosition());
            preparedStatementInsert.setString(16, guest.getPassport());
            preparedStatementInsert.setString(17, Converter.parseToYesNo(guest.getConfidential()));
            preparedStatementInsert.executeUpdate();
            generatedKeys = preparedStatementInsert.getGeneratedKeys();
            int guestInfoId;
            if (generatedKeys.next()) {
                guestInfoId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Can't create guestinfo");
            }

            preparedStatementInsert = dbConnection.prepareStatement(insertGuestNameSQL);
            preparedStatementInsert.setInt(1, guestInfoId);
            preparedStatementInsert.setString(2, guest.getTitle());
            preparedStatementInsert.setString(3, guest.getFirst());
            preparedStatementInsert.setString(4, guest.getLast());
            preparedStatementInsert.setString(5, guest.getMiddle());
            preparedStatementInsert.executeUpdate();

            preparedStatementInsert = dbConnection.prepareStatement(insertGAccountSQL, Statement.RETURN_GENERATED_KEYS);
            //ga_accstat,
            preparedStatementInsert.setString(1, "R");
            //ga_gsttype, 
            preparedStatementInsert.setString(2, "D");
            //ga_rsvtypeno,
            preparedStatementInsert.setString(3, guest.getReserveBy());
            //ga_bookby,
            preparedStatementInsert.setString(4, guest.getBookBy());
            //ga_acctype,
            preparedStatementInsert.setString(5, "I");
            //ga_walkin,
            preparedStatementInsert.setString(6, "N");
            //ga_guestno,
            preparedStatementInsert.setInt(7, guestInfoId);
            //ga_agentno,
            preparedStatementInsert.setInt(8, Converter.parseInt(guest.getAgent()));
            //ga_orino,
            preparedStatementInsert.setString(9, guest.getOrigin());
            //ga_arrival,
            preparedStatementInsert.setDate(10, Converter.parseSQLDate(guest.getArrival()));
            //ga_arrtime,
            preparedStatementInsert.setTime(11, Converter.parseSQLTime(guest.getArrTime()));
            //ga_arrfrom, 
            preparedStatementInsert.setString(12, guest.getArrFrom());
            //ga_arrby, 
            preparedStatementInsert.setString(13, guest.getArrBy());
            //ga_departure, 
            preparedStatementInsert.setDate(14, Converter.parseSQLDate(guest.getDeparture()));
            //ga_deptime, 
            preparedStatementInsert.setTime(15, Converter.parseSQLTime(guest.getDepTime()));
            //ga_depto,
            preparedStatementInsert.setString(16, guest.getDepTo());
            //ga_depby,
            preparedStatementInsert.setString(17, guest.getDepBy());
            //ga_fpatno,
            preparedStatementInsert.setString(18, guest.getFollioPattern());
            //ga_recdate,
            preparedStatementInsert.setDate(19, Converter.parseSQLDate(Converter.getCurrentDate()));
            //ga_userno,
            preparedStatementInsert.setString(20, user.getUsername());
            //ga_coa
            preparedStatementInsert.setString(21, Converter.parseToYesNo(guest.getCoa()));
            preparedStatementInsert.executeUpdate();
            generatedKeys = preparedStatementInsert.getGeneratedKeys();
            int gAccountId;
             
         

            if (generatedKeys.next()) {
                gAccountId = generatedKeys.getInt(1);
                guest.setAccountId("" + gAccountId);
            } else {
                throw new SQLException("Can't create gaccount");
            }
           
 preparedStatementInsert = dbConnection.prepareStatement(insertNamelistSQL);

            preparedStatementInsert.setString(1, guest.getTitle());
            preparedStatementInsert.setString(2, guest.getFirst());
            preparedStatementInsert.setString(3, guest.getLast());
            preparedStatementInsert.setString(4, guest.getMiddle());
            preparedStatementInsert.setInt(5, gAccountId);
            preparedStatementInsert.setDate(6, Converter.parseSQLDate(guest.getArrival()));
            preparedStatementInsert.setDate(7, Converter.parseSQLDate(guest.getDeparture()));
            preparedStatementInsert.setString(8, guest.getNationality());
             preparedStatementInsert.setInt(9, Converter.parseInt(guest.getbkacc()));
              preparedStatementInsert.setInt(10, Converter.parseInt(guest.getdtl()));
               preparedStatementInsert.setInt(11, Converter.parseInt(guest.getseqq()));
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
    session.setAttribute("errors" + session.getId(), errorList);
    //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
    //String title, String last, String first, String middle, String sex, String origin, String bookBy,
    //String agent, String nationality, String birthDate, String company, String position, String creditCard,
    //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
    //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
    //String arrBy, String departure, String depTime, String depTo, String depBy
    GuestGr guest = new GuestGr(
            (String) request.getParameter("bkacc"),
            (String) request.getParameter("dtl"),
            (String) request.getParameter("seqq"),
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

    WebUser user = (WebUser) session.getAttribute("" + session.getId());
    validate(guest, errorList);
    if (errorList.size() > 0) {

        response.sendRedirect("newguest.jsp?bkacc=" + guest.getbkacc() +"&dtl=" + guest.getdtl() +"&seqq=" + guest.getseqq() +"");
    } else {
        if (saveBooking(user1, pw, url, driver,guest, user, errorList)) {
            NameList nameList = (NameList) session.getAttribute("nameList");
            nameList.setAccountId(guest.getAccountId());
            session.setAttribute("nameList", nameList);
          
       
          
            response.sendRedirect("newguest.jsp?acc=" + guest.getAccountId() + "&bkacc=" + nameList.getBookingAccountId() + "&dtl=" + nameList.getDtl() + "&x=true");
        } else {

            response.sendRedirect("newguest.jsp?bkacc=" + guest.getbkacc() +"&dtl=" + guest.getdtl() +"&seqq=" + guest.getseqq() +"");
        }
    }
%>