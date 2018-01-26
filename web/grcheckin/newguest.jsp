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

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javazoom.upload.*"%>
<%@page import="com.comis.frontsystem.util.DefaultValue"%>
<%@page import="com.comis.frontsystem.util.Converter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ include file ="../config.jsp"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Guest</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/flick/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#arrival").datepicker({dateFormat : 'yy-mm-dd'});
                $("#departure").datepicker({dateFormat : 'yy-mm-dd'});
                $("#birthDate").datepicker({dateFormat : 'yy-mm-dd', yearRange: '1950:2070' ,changeMonth: true, changeYear: true})
            });
            function closeWindow(isClose){
                if(isClose){
                    var p=window.opener;                   
                    if(p.$('#details')!==null){
                        p.$('#details').load("newnamelist.jsp?acc="+<%=request.getParameter("acc")%>+"&bkacc="+<%=request.getParameter("bkacc")%>+"&dtl="+<%=request.getParameter("dtl")%>+"&seqq="+<%=request.getParameter("seqq")%>);
                        window.close();
                    }
                }
            }
        </script>
        <SCRIPT TYPE="text/javascript">
            $(document).ready(function() {
                $("#arrival").datepicker({dateFormat : 'yy-mm-dd'});
                $("#departure").datepicker({dateFormat : 'yy-mm-dd'});
                $("#birthDate").datepicker({dateFormat : 'yy-mm-dd', yearRange: '1950:2070' ,changeMonth: true, changeYear: true})
            });
            function submitAndClose() {
       
                window.opener.location.href="namelist.jsp?bkacc="+<%=request.getParameter("bkacc")%>+"&dtl="+<%=request.getParameter("dtl")%>;

                window.close();
              
            }
        </SCRIPT>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body onload="closeWindow(<%=request.getParameter("x")%>)">
        <div class="content">
            <div class="page-header offset1">
                <h1>New Guest</h1>
            </div>
            <div class="row">

                <div class="span16 columns">

                    <%
                        WebUser user = (WebUser) session.getAttribute("" + session.getId());
  List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());
                         
                         errorList = (ArrayList) session.getAttribute("errors" + session.getId());
                        errorList = new ArrayList<String>();
                        session.setAttribute("errors" + session.getId(), errorList);
                        
                        Connection dbConnection = null;
                       dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                        
                       
                        PreparedStatement preparedStatementSelect = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                       
                        Vector errors = new Vector();
                       
                        String fname = "", adate = "", ddate = "", agent = "", origin = "";
                        String dtl = request.getParameter("dtl");
                        String bkacc = request.getParameter("bkacc");
                        String seqq = request.getParameter("seqq");

                        if (request.getParameter("submit") != null) {
                            // MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);

                            //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
                            //String title, String last, String first, String middle, String sex, String origin, String bookBy,
                            //String agent, String nationality, String birthDate, String company, String position, String creditCard,
                            //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
                            //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
                            //String arrBy, String departure, String depTime, String depTo, String depBy




                            dbConnection.setAutoCommit(false);

                            String bkacc1 = request.getParameter("bkacc");
                            String bkacc11 = new String(bkacc1.getBytes("ISO8859_1"), "utf-8");

                            String dtl1 = request.getParameter("dtl");
                            String dtl11 = new String(dtl1.getBytes("ISO8859_1"), "utf-8");
                            String seqq1 = request.getParameter("seqq");
                            String seqq11 = new String(seqq1.getBytes("ISO8859_1"), "utf-8");
                            // String accountId1 = mrequest.getParameter("accountId");
                            // String accountId = new String(accountId1.getBytes("ISO8859_1"), "utf-8");
                            String confidential1 = request.getParameter("confidential");
                            if (confidential1 == null) {

                                confidential1 = DefaultValue.NO;
                            }
                            String confidential = new String(confidential1.getBytes("ISO8859_1"), "utf-8");
                            if (bkacc11 == null) {

                                bkacc11 = DefaultValue.DUMMYINT;

                            }
                            String coa1 = request.getParameter("coa");

                            if (coa1 == null) {

                                coa1 = DefaultValue.NO;
                            }
                            String coa = new String(coa1.getBytes("ISO8859_1"), "utf-8");

                            String vip1 = request.getParameter("vip");

                            if (vip1 == null) {

                                vip1 = DefaultValue.PATTERN;
                            }
                            String vip = new String(vip1.getBytes("ISO8859_1"), "utf-8");
                            String reserveBy1 = request.getParameter("reserveBy");
                            if (reserveBy1 == null) {

                                reserveBy1 = DefaultValue.PATTERN;
                            }
                            String reserveBy = new String(reserveBy1.getBytes("ISO8859_1"), "utf-8");

                            String follioPattern1 = request.getParameter("follioPattern");
                            if (follioPattern1 == null) {

                                follioPattern1 = DefaultValue.PATTERN;
                            }
                            String follioPattern = new String(follioPattern1.getBytes("ISO8859_1"), "utf-8");

                            String title1 = request.getParameter("title");
                            if (title1 == null) {

                                title1 = DefaultValue.PATTERN;
                            }
                            String title = new String(title1.getBytes("ISO8859_1"), "utf-8");

                            String last1 = request.getParameter("last");
                            if (last1 == null) {

                                last1 = DefaultValue.DUMMY;
                            }
                            String last = new String(last1.getBytes("ISO8859_1"), "utf-8");

                            String first1 = request.getParameter("first");
                            String first = new String(first1.getBytes("ISO8859_1"), "utf-8");
                            String middle1 = request.getParameter("middle");
                            if (middle1 == null) {
                                middle1 = DefaultValue.DUMMY;
                            }
                            String middle = new String(middle1.getBytes("ISO8859_1"), "utf-8");

                            String sex1 = request.getParameter("sex");
                            String sex = new String(sex1.getBytes("ISO8859_1"), "utf-8");

                            String origin1 = request.getParameter("origin");
                            String origin11 = new String(origin1.getBytes("ISO8859_1"), "utf-8");

                            String bookBy1 = request.getParameter("bookBy");
                            String bookBy = new String(bookBy1.getBytes("ISO8859_1"), "utf-8");

                            String agent1 = request.getParameter("agent");
                            String agent11 = new String(agent1.getBytes("ISO8859_1"), "utf-8");

                            String nationality1 = request.getParameter("nationality");
                            String nationality = new String(nationality1.getBytes("ISO8859_1"), "utf-8");

                            String birthDate1 = request.getParameter("birthDate");
                            String birthDate = new String(birthDate1.getBytes("ISO8859_1"), "utf-8");

                            String company1 = request.getParameter("company");
                            String company = new String(company1.getBytes("ISO8859_1"), "utf-8");

                            String position1 = request.getParameter("position");
                            String position = new String(position1.getBytes("ISO8859_1"), "utf-8");

                            String creditCard1 = request.getParameter("creditCard");
                            String creditCard = new String(creditCard1.getBytes("ISO8859_1"), "utf-8");

                            String cardNo1 = request.getParameter("cardNo");
                            String cardNo = new String(cardNo1.getBytes("ISO8859_1"), "utf-8");

                            String creditLimit1 = request.getParameter("creditLimit");
                            String creditLimit = new String(creditLimit1.getBytes("ISO8859_1"), "utf-8");

                            String address11 = request.getParameter("address1");
                            String address1 = new String(address11.getBytes("ISO8859_1"), "utf-8");

                            String address21 = request.getParameter("address2");
                            String address2 = new String(address21.getBytes("ISO8859_1"), "utf-8");

                            String phone1 = request.getParameter("phone");
                            String phone = new String(phone1.getBytes("ISO8859_1"), "utf-8");

                            String fax1 = request.getParameter("fax");
                            String fax = new String(fax1.getBytes("ISO8859_1"), "utf-8");

                            String country1 = request.getParameter("country");
                            String country = new String(country1.getBytes("ISO8859_1"), "utf-8");

                            String email1 = request.getParameter("email");
                            String email = new String(email1.getBytes("ISO8859_1"), "utf-8");

                            String passport1 = request.getParameter("passport");
                            String passport = new String(passport1.getBytes("ISO8859_1"), "utf-8");

                            String arrival1 = request.getParameter("arrival");
                            String arrival = new String(arrival1.getBytes("ISO8859_1"), "utf-8");

                            String arrTime1 = request.getParameter("arrTime");
                            String arrTime = new String(arrTime1.getBytes("ISO8859_1"), "utf-8");

                            String arrFrom1 = request.getParameter("arrFrom");
                            String arrFrom = new String(arrFrom1.getBytes("ISO8859_1"), "utf-8");

                            String arrBy1 = request.getParameter("arrBy");
                            String arrBy = new String(arrBy1.getBytes("ISO8859_1"), "utf-8");

                            String departure1 = request.getParameter("departure");
                            String departure = new String(departure1.getBytes("ISO8859_1"), "utf-8");

                            String depTime1 = request.getParameter("depTime");
                            String depTime = new String(depTime1.getBytes("ISO8859_1"), "utf-8");

                            String depTo1 = request.getParameter("depTo");
                            String depTo = new String(depTo1.getBytes("ISO8859_1"), "utf-8");

                            String depBy1 = request.getParameter("depBy");
                            String depBy = new String(depBy1.getBytes("ISO8859_1"), "utf-8");









                            if (sex == null) {
                                sex = DefaultValue.DUMMYINT;
                            }
                            if (origin == null) {
                                origin = DefaultValue.PATTERN;
                            }
                            if (bookBy == null) {
                                bookBy = DefaultValue.DUMMY;
                            }
                            if (agent11 == null) {
                                agent11 = DefaultValue.DUMMYINT;
                            }
                            if (nationality == null) {
                                nationality = DefaultValue.DUMMYINT;
                            }
                            if (birthDate == null) {
                                birthDate = DefaultValue.MIN_DATE;
                            }
                            if (company == null) {
                                company = DefaultValue.DUMMY;
                            }
                            if (position == null) {
                                position = DefaultValue.DUMMY;
                            }
                            if (creditCard == null) {
                                creditCard = DefaultValue.PATTERN;
                            }
                            if (cardNo == null) {
                                cardNo = DefaultValue.DUMMY;
                            }
                            if (creditLimit == null) {
                                creditLimit = DefaultValue.DUMMYINT;
                            }
                            if (address1 == null) {
                                address1 = DefaultValue.DUMMYINT;
                            }
                            if (address2 == null) {
                                address2 = address2;
                            }
                            if (phone == null) {
                                phone = DefaultValue.DUMMY;
                            }
                            if (fax == null) {
                                fax = DefaultValue.DUMMY;
                            }
                            if (country == null) {
                                country = DefaultValue.DUMMYINT;
                            }
                            if (email == null) {
                                email = DefaultValue.DUMMY;
                            }
                            if (passport == null) {
                                passport = DefaultValue.DUMMY;
                            }
                            if (arrival == null) {
                                arrival = DefaultValue.DUMMY;
                            }
                            if (arrTime == null) {
                                arrTime = DefaultValue.MIN_TIME;
                            }
                            if (arrFrom == null) {
                                arrFrom = DefaultValue.DUMMY;
                            }
                            if (arrBy == null) {
                                arrBy = DefaultValue.DUMMY;
                            }
                            if (departure == null) {
                                departure = DefaultValue.MIN_DATE;
                            }
                            if (depTime == null) {
                                depTime = DefaultValue.MIN_TIME;
                            }
                            if (depTo == null) {
                                depTo = DefaultValue.DUMMY;
                            }
                            if (depBy == null) {
                                depBy = DefaultValue.DUMMY;
                            }

                            if (errors.size() > 0) {
                                out.println(errors);
                                //    response.sendRedirect("newguestrr.jsp?bkacc=" + bkacc11 + "&dtl=" + dtl11 + "&seqq=" + seqq11 + "");
                            } else {
                                int bqty = 0,bseq=0;
                                try {
                                    PreparedStatement preparedStatementInsert = null;

                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT b_qty from booking where b_accno= " + bkacc11 + " and b_seq  = " + dtl11 + " ;");
                                    rs = preparedStatementSelect.executeQuery();
                                    while (rs.next()) {
                                        bqty = rs.getInt(1);
                                    }
 preparedStatementSelect = dbConnection.prepareStatement("SELECT count(b_seq) from booking where b_accno= " + bkacc11 + "  ;");
                                    rs = preparedStatementSelect.executeQuery();
                                    while (rs.next()) {
                                        bseq = rs.getInt(1);
                                    }
                                    String insertGuestInfoSQL = "INSERT INTO guestinfo(gi_sex, gi_natno, gi_crcard, gi_cardno, gi_vipno, gi_crlimit, gi_birthdate, gi_homeaddr1, gi_homeaddr2, gi_ctno, gi_telno, gi_faxno, gi_email, gi_company, gi_positions, gi_passport, gi_ptype, gi_confflag ,gi_visatypeno)VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (select vs_descr from visatype where vs_id='02'), ?, '02');";
                                    String insertGuestNameSQL = "INSERT INTO guestname(gn_guestno, gn_titleno, gn_fname, gn_lname, gn_mname)VALUES (?, ?, ?, ?, ?);";
                                    String insertGAccountSQL = "INSERT INTO gaccount(ga_accstat, ga_gsttype, ga_rsvtypeno, ga_bookby, ga_acctype, ga_walkin, ga_guestno,ga_agentno, ga_orino, ga_arrival, ga_arrtime, ga_arrfrom, ga_arrby, ga_departure, ga_deptime, ga_depto, ga_depby, ga_fpatno, ga_recdate, ga_userno, ga_coa)VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
                                    //String insertNamelistSQL = "update namelist set nl_titleno=?,nl_fname=?,nl_lname=?,nl_mname=?, nl_ownaccno=?,  nl_arrdate=?, nl_depdate=?, nl_natno=? where nl_accno=" + bkacc + " and nl_dtlseq=" + dtl + " and nl_seq=" + seq + ";";
                                    String insertNamelistSQL = "update namelist set nl_titleno=?,nl_fname=?,nl_lname=?,nl_mname=?, nl_ownaccno=?,  nl_arrdate=?, nl_depdate=?, nl_natno=?  where nl_accno=? and nl_dtlseq=? and nl_seq=? ;";

                                    ResultSet generatedKeys = null;
                                    boolean isSave = false;
                                    preparedStatementInsert = dbConnection.prepareStatement(insertGuestInfoSQL, Statement.RETURN_GENERATED_KEYS);

                                    preparedStatementInsert.setString(1, sex);
                                    preparedStatementInsert.setString(2, nationality);
                                    preparedStatementInsert.setString(3, creditCard);
                                    preparedStatementInsert.setString(4, cardNo);
                                    preparedStatementInsert.setString(5, vip);
                                    preparedStatementInsert.setDouble(6, Converter.parseDouble(creditLimit));
                                    preparedStatementInsert.setDate(7, Converter.parseSQLDate(birthDate));
                                    preparedStatementInsert.setString(8, address1);
                                    preparedStatementInsert.setString(9, address2);
                                    preparedStatementInsert.setString(10, country);
                                    preparedStatementInsert.setString(11, phone);
                                    preparedStatementInsert.setString(12, fax);
                                    preparedStatementInsert.setString(13, email);
                                    preparedStatementInsert.setString(14, company);
                                    preparedStatementInsert.setString(15, position);
                                    preparedStatementInsert.setString(16, passport);
                                    preparedStatementInsert.setString(17, Converter.parseToYesNo(confidential));
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
                                    preparedStatementInsert.setString(2, title);
                                    preparedStatementInsert.setString(3, first);
                                    preparedStatementInsert.setString(4, last);
                                    preparedStatementInsert.setString(5, middle);
                                    preparedStatementInsert.executeUpdate();

                                    preparedStatementInsert = dbConnection.prepareStatement(insertGAccountSQL, Statement.RETURN_GENERATED_KEYS);
                                    //ga_accstat,
                                    preparedStatementInsert.setString(1, "R");
                                    //ga_gsttype, 
                                    preparedStatementInsert.setString(2, "D");
                                    //ga_rsvtypeno,
                                    preparedStatementInsert.setString(3, reserveBy);
                                    //ga_bookby,
                                    preparedStatementInsert.setString(4, bookBy);
                                    //ga_acctype,
                                    preparedStatementInsert.setString(5, "I");
                                    //ga_walkin,
                                    preparedStatementInsert.setString(6, "N");
                                    //ga_guestno,
                                    preparedStatementInsert.setInt(7, guestInfoId);
                                    //ga_agentno,
                                    preparedStatementInsert.setInt(8, Converter.parseInt(agent11));
                                    //ga_orino,
                                    preparedStatementInsert.setString(9, origin11);
                                    //ga_arrival,
                                    preparedStatementInsert.setDate(10, Converter.parseSQLDate(arrival));
                                    //ga_arrtime,
                                    preparedStatementInsert.setTime(11, Converter.parseSQLTime(arrTime));
                                    //ga_arrfrom, 
                                    preparedStatementInsert.setString(12, arrFrom);
                                    //ga_arrby, 
                                    preparedStatementInsert.setString(13, arrBy);
                                    //ga_departure, 
                                    preparedStatementInsert.setDate(14, Converter.parseSQLDate(departure));
                                    //ga_deptime, 
                                    preparedStatementInsert.setTime(15, Converter.parseSQLTime(depTime));
                                    //ga_depto,
                                    preparedStatementInsert.setString(16, depTo);
                                    //ga_depby,
                                    preparedStatementInsert.setString(17, depBy);
                                    //ga_fpatno,
                                    preparedStatementInsert.setString(18, follioPattern);
                                    //ga_recdate,
                                    preparedStatementInsert.setDate(19, Converter.parseSQLDate(Converter.getCurrentDate()));
                                    //ga_userno,
                                    preparedStatementInsert.setString(20, user.getUsername());
                                    //ga_coa
                                    preparedStatementInsert.setString(21, Converter.parseToYesNo(coa));
                                    preparedStatementInsert.executeUpdate();
                                    generatedKeys = preparedStatementInsert.getGeneratedKeys();
                                    int gAccountId;



                                    if (generatedKeys.next()) {
                                        gAccountId = generatedKeys.getInt(1);

                                    } else {
                                        throw new SQLException("Can't create gaccount");
                                    }
                                    if (bqty == 1 && bseq==1) {
                                        gAccountId = Converter.parseInt(bkacc11);
                                    }
                                    preparedStatementInsert = dbConnection.prepareStatement(insertNamelistSQL);

                                    preparedStatementInsert.setString(1, title);
                                    preparedStatementInsert.setString(2, first);
                                    preparedStatementInsert.setString(3, last);
                                    preparedStatementInsert.setString(4, middle);
                                    preparedStatementInsert.setInt(5, gAccountId);
                                    preparedStatementInsert.setDate(6, Converter.parseSQLDate(arrival));
                                    preparedStatementInsert.setDate(7, Converter.parseSQLDate(departure));
                                    preparedStatementInsert.setString(8, nationality);
                                    preparedStatementInsert.setInt(9, Converter.parseInt(bkacc11));
                                    preparedStatementInsert.setInt(10, Converter.parseInt(dtl11));
                                    preparedStatementInsert.setInt(11, Converter.parseInt(seqq11));
                                    preparedStatementInsert.executeUpdate();

                                    dbConnection.commit();
                                    isSave = true;





                                } catch (SQLException e) {
                                    errors.add(e.getMessage());
                                    dbConnection.rollback();
                                } finally {
                                    // preparedStatementInsert.close();
                                    if (dbConnection != null) {
                                        dbConnection.close();
                                    }
                                }







                    %>
                    <script type="text/javascript" language="JavaScript">
                        submitAndClose();
                    </script>


                    <%
                            //response.sendRedirect("clip.jsp");
                        }
                    } else if ((request.getParameter("submit") == null)) {
                        try {

                    %>
                    <form  method="post"  action="newguest.jsp?bkacc=<%=bkacc%>&dtl=<%=dtl%>&seqq=<%=seqq%> ">
                        <fieldset>
                            <legend>Guest Form</legend>
                            <input type="hidden" name="accountId" value=""/>
                            <input type="hidden" name="bkacc" value="<%=bkacc%>" />  
                            <input type="hidden" name="dtl" value="<%=dtl%>" />
                            <input type="hidden" name="seqq" value="<%=seqq%>" />

                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    # <span class="uneditable-input span2">&lt;AUTO GEN&gt;</span> &nbsp; 
                                    <input type="checkbox" name="confidential" value="Y"/> <span><strong>Confidential?</strong></span>
                                    &nbsp; <input type="checkbox" name="coa" value="Y"/> <span><strong>Cash On Available(COA)?</strong></span>
                                </div>
                            </div>    
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    VIP <select class="span3" name="vip">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT v_id, v_descr, v_keepday FROM vip;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; Reserved By <select name="reserveBy" class="span3">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT rsvtypeno, \"name\" FROM resvtype;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Follio Pattern <select class="span3" name="follioPattern">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT fp_id, fp_descr FROM folpattern;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Title <select class="span2" name="title">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT t_id, t_descr, t_sex FROM title;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT nl_fname,nl_arrdate,nl_depdate  FROM namelist WHERE nl_status not in ('I','O') and nl_accno=" + bkacc + " and nl_dtlseq=" + dtl + "and nl_seq=" + seqq + " ;");
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                                fname = rs.getString(1);
                                                adate = rs.getString(2);
                                                ddate = rs.getString(3);
                                            }
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT ga_agentno,ga_orino  FROM gaccount WHERE  ga_accno=" + bkacc + ";");
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                                agent = rs.getString(1);
                                                origin = rs.getString(2);
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Last <input type="text" class="span3" name="last"  /> &nbsp; 
                                    First <input type="text" class="span3" name="first" value="<%=fname%>"/> &nbsp; 
                                    Middle <input type="text" class="span3" name="middle"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Sex <select class="span2" name="sex">
                                        <option value="0">Not specify</option>
                                        <option value="1">Male</option>
                                        <option value="2">Female</option>
                                    </select> &nbsp; 
                                    Origin <select class="span3" onchange="getAgent(this.value)" name="origin"  >
                                        <option value=""></option>
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT o_id, o_descr || ' - ' || o_id as o_descr FROM origin;");
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"<%if (origin.equals(rs.getString(1))) {
                                                out.println("selected");
                                            }%> ><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp;
                                    Book By <input type="text" class="span2" name="bookBy"/> &nbsp; 



                                    <script>
                                        function getAgent(a){
                                            $.ajax( '<%=request.getContextPath()%>/guest/getagent.jsp?oid='+a ).done(function(data) { 
                                                $('#agent').children().remove();
                                                $('#agent').append(data);
                                            })
                                        }
                                    </script>
                                    Agent <select class="span4" name="agent" id="agent">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT a_id, a_name FROM agent where a_id=" + agent + ";");

                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%if (agent.equals(rs.getString(1))) {
                                                out.println("selected");
                                            }%> ><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp;   
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Nationality <select class="span3" name="nationality">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Birthdate <input type="text" class="span2" name="birthDate" id="birthDate"/> &nbsp; 
                                    Company <input type="text" class="span2" name="company"/> &nbsp; 
                                    Position <input type="text" class="span2" name="position"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Credit Card <select class="span3" name="creditCard">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT m_id,m_descr FROM media where m_grp='23';");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Card No <input type="text" class="span3" name="cardNo"/> &nbsp; 
                                    Credit Limit <input type="text" class="span2" name="creditLimit"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Address <input type="text" class="span6" name="address1"/> &nbsp; 
                                    <input type="text" class="span6" name="address2"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Phone <input type="text" class="span3" name="phone"/> &nbsp; 
                                    Fax   <input type="text" class="span3" name="fax"/> &nbsp; 
                                    Country <select class="span3" name="country">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT ct_id, ct_descr FROM country;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Email <input type="text" class="span3" name="email"/> &nbsp; 
                                    Passport <input type="text" class="span3" name="passport"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Arrival Date <input type="text" class="span2" name="arrival" value="<%=adate%>" id="arrival"/> &nbsp; 
                                    Time <input type="text" class="span2" name="arrTime"/> &nbsp;
                                    From <input type="text" class="span3" name="arrFrom"/> &nbsp; 
                                    By <input type="text" class="span3" name="arrBy"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>

                                <div class="inline-inputs">
                                    Departure Date <input type="text" class="span2" name="departure" value="<%=adate%>" id="departure"/> &nbsp; 
                                    Time <input type="text" class="span2" name="depTime"/> &nbsp;
                                    To <input type="text" class="span3" name="depTo"/> &nbsp; 
                                    By <input type="text" class="span3" name="depBy"/> &nbsp; 
                                </div>
                            </div>
                            <%

                                } catch (SQLException e) {
                                    errors.add(e.getMessage());
                                }
                            %>
                        </fieldset>

                        <div class="actions">  <input type="submit" value="Next" name="submit" class="btn primary offset-two-thirds" ></div>
                    </form>
                    <%}%>
                </div>
            </div>
        </div>
    </body>
</html>
