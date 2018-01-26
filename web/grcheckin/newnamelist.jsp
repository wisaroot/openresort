now(<%--
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
<%@page import="com.comis.frontsystem.guest.Guest"%>
<%@page import="com.comis.frontsystem.checkin.CheckIn"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="newguest_2.jsp" %>
<%@ include file="newnamelist_2.jsp" %>
<%@ include file ="../config.jsp"%>

<%
    List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());

%>	
<% if (errorList != null && errorList.size() > 0) {%>	
<div class="alert-message block-message error offset1">
    <p>
        <%

            if (errorList != null) {
                for (String error : errorList) {
                    out.println(error + "<br/>");
                }
                errorList = new ArrayList<String>();
                session.setAttribute("errors" + session.getId(), errorList);
            }
        %>
    </p>
</div>

<% }%>
<%
    if (Converter.isEmpty(request.getParameter("acc"))) {
        NameList nameList = new NameList(request.getParameter("bkacc"), request.getParameter("dtl"), request.getParameter("seq"), request.getParameter("roomNo"), null, null, null, null, null, null, null, request.getParameter("rateNo"), null, null, null, null, null, null, null, request.getParameter("acc"), null, null, null, null, null);
        session.setAttribute("nameList", nameList);
        ResultSet rs, rs1;
        int room = 0;
        Statement stmt = null;
        String accountId = request.getParameter("bkacc"), dtl = request.getParameter("dtl");
        Connection dbConnection = null;

        dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

        PreparedStatement preparedStatementSelect = null, preparedStatementSelect1 = null;
        preparedStatementSelect = dbConnection.prepareStatement("SELECT b_qty  from booking bk  where b_accno= " + request.getParameter("bkacc") + " and b_seq = " + request.getParameter("dtl") + " ;");
        rs = preparedStatementSelect.executeQuery();
        while (rs.next()) {
            room = rs.getInt("b_qty");
        }
        int i = 0;
        String h, sql;

        while (i < room) {
            h = Integer.toString(i);
            stmt = dbConnection.createStatement();

            sql = ("insert into namelist(nl_accno,nl_dtlseq,nl_seq,nl_status,nl_sex,nl_recdate,nl_fname ,nl_adult,nl_child, nl_arrdate, nl_depdate,nl_roomtypeno, nl_bedtypeno, "
                    + "  nl_comp, nl_rateno, nl_chargeto, nl_userno, nl_visatypeno, nl_entryno, "
                    + "   nl_natno, nl_pissue, nl_pexpire, nl_room, nl_service, nl_tax, nl_extrabed, "
                    + "     nl_extbedserv, nl_extbedtax, nl_abf, nl_lunch, nl_dinner, nl_discount) "
                    + " select b_accno,b_seq, " + h + " ,'L',1,NOW(),gri_grpname||" + h + ", b_adult, b_child, b_arrdate, b_depdate, b_roomtypeno, b_bedtypeno, "
                    + "      b_comp, b_rateno, b_chargeto, ga_userno, gri_visatypeno, gri_entryno, "
                    + "      gri_natno, gri_pissue, gri_pexpire,  b_room, b_service, b_tax, b_extrabed, "
                    + "     b_extbedserv, b_extbedtax, b_abf, b_lunch, b_dinner, b_discount  from booking bk inner join gaccount ac "
                    + "      on b_accno = ga_accno inner join groupinfo   on gri_grpno = ga_grpno where  b_accno= " + request.getParameter("bkacc") + " and b_seq = " + request.getParameter("dtl") + " ;");

            stmt.executeUpdate(sql);
            i++;
        }
        int check = 0;
        preparedStatementSelect = dbConnection.prepareStatement(" select brq_accno from brequire where brq_accno = " + request.getParameter("bkacc") + " ;");
        rs = preparedStatementSelect.executeQuery();
        while (rs.next()) {
            check = 1;
        }
        if (check == 1) {
    //        String insertGrequire = "INSERT INTO grequire( gr_accno, gr_reqno, gr_fromdate, gr_eventtime,gr_enddate,gr_chargeflag,gr_deptno,gr_amount,gr_chargetype, gr_remark) select brq_accno, brq_reqno, brq_fromdate, brq_eventtime,brq_enddate,brq_chargeflag,brq_deptno,brq_amount,brq_chargetype, brq_remark from brequire where brq_accno = " + request.getParameter("bkacc") + " and b_seq = " + request.getParameter("dtl") + " ;";
  String insertGrequire = "INSERT INTO grequire( gr_accno, gr_reqno, gr_fromdate, gr_eventtime,gr_enddate,gr_chargeflag,gr_deptno,gr_amount,gr_chargetype, gr_remark) select brq_accno, brq_reqno, brq_fromdate, brq_eventtime,brq_enddate,brq_chargeflag,brq_deptno,brq_amount,brq_chargetype, brq_remark from brequire where brq_accno = " + request.getParameter("bkacc") + "  ;";
                   
             stmt.executeUpdate(insertGrequire);
        }
        if (i == room && (i > 0)) {
            response.sendRedirect("namelist.jsp?bkacc=" + accountId + "&dtl=" + dtl);
        }

        preparedStatementSelect1 = dbConnection.prepareStatement("SELECT b_qty  from booking bk  where b_accno= " + request.getParameter("bkacc") + " and b_seq = " + request.getParameter("dtl") + " ;");
        rs1 = preparedStatementSelect1.executeQuery();

        while (rs1.next()) {
            room = rs1.getInt("b_qty");

        }


%> 

<button class="btn info" onclick="window.open('newguest.jsp?bkacc=<%=accountId%>&dtl=<%=dtl%>', '_blank', 'scrollbars=1,height=700, width=1000');return false;">New Guest</button>
<button class="btn info" onclick="window.open('guest.jsp', '_blank', 'scrollbars=1,height=700, width=1000');return false;">Choose Guest</button>
<%
} else {
%>
<%

    errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);
    Guest guest = getGuest(user1, pw, url, driver, (String) request.getParameter("acc"), errorList);
    NameList nameList = getNameList(user1, pw, url, driver, request.getParameter("acc"), request.getParameter("bkacc"), request.getParameter("dtl"), request.getParameter("seq"), errorList);
    Connection dbConnection = null;
    PreparedStatement preparedStatementSelect = null;


    try {
        dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

        //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
        //String title, String last, String first, String middle, String sex, String origin, String bookBy,
        //String agent, String nationality, String birthDate, String company, String position, String creditCard,
        //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
        //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
        //String arrBy, String departure, String depTime, String depTo, String depBy
%>
<form method="post" action="newnamelist_1.jsp" name="a">
    <fieldset>
        <div class="clearfix">
            <label>#ACC <%=request.getParameter("acc")%></label>
        </div>
        <div class="clearfix">
            <input type="hidden"  name="acc" value='<%=request.getParameter("acc")%>'/>
            <input type="hidden"  name="bkacc" value='<%=request.getParameter("bkacc")%>'/>
            <input type="hidden"  name="dtl" value='<%=request.getParameter("dtl")%>' />
            <input type="hidden"  name="seq" value='<%=request.getParameter("seq")%>' />
            <label>Room Type</label>
            <div class="input">
                <select name="roomType" class="span3">
                    <%
                        preparedStatementSelect = dbConnection.prepareStatement("SELECT rt_id, rt_descr FROM roomtype;");
                        ResultSet rs = preparedStatementSelect.executeQuery();
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString(1)%>" <%=(rs.getString(1).equals(nameList.getRoomType()) ? "SELECTED" : "")%>><%=rs.getString(2)%></option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="clearfix">
            <label>Bed Type</label>
            <div class="input">
                <select name="bedType" class="span3">
                    <%
                        preparedStatementSelect = dbConnection.prepareStatement("SELECT bt_id, bt_descr FROM bedtype;");
                        rs = preparedStatementSelect.executeQuery();
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString(1)%>" <%=(rs.getString(1).equals(nameList.getBedType()) ? "SELECTED" : "")%>><%=rs.getString(2)%></option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="clearfix">
            <label>Arrival</label>
            <div class="input">
                <div class="inline-inputs">
                    <input type="text" name="arrival" id="arrival" class="span2" value='<%=(guest != null ? guest.getArrival() : "")%>' /> &nbsp; Departure
                    <input type="text" name="departure" id="departure" class="span2" value=<%=(guest != null ? guest.getDeparture() : "")%> /> 
                </div>
            </div>
        </div>
        <div class="clearfix">
            <label>Room</label>
            <div class="input">
                <input type="text" name="roomNo" id="roomNo" class="span2" value="<%=(Converter.isEmpty(request.getParameter("roomNo")) ? "" : request.getParameter("roomNo"))%>"/>
                <button class="btn info"  onclick="window.open('../blockroom/blockroom.jsp?acc='+a.bkacc.value+'&bt='+a.bedType.value+'&rt='+a.roomType.value+'&arr='+a.arrival.value+'&dep='+a.departure.value+'&dtl='+a.dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
            </div>
        </div>
        <div class="clearfix">
            <label>Title</label>
            <div class="input">
                <div class="inline-inputs">
                    <select name="title" class="span2">
                        <%
                            preparedStatementSelect = dbConnection.prepareStatement("SELECT t_id, t_descr, t_sex FROM title;");
                            rs = preparedStatementSelect.executeQuery();
                            while (rs.next()) {
                        %>
                        <option value="<%=rs.getString(1)%>" <%=(rs.getString(1).equals(guest.getTitle()) ? "SELECTED" : "")%> ><%=rs.getString(2)%></option>
                        <%
                            }
                        %>
                    </select>&nbsp; Sex
                    <select name="sex" id="sex" class="span2"><option value="0">Not specify</option>
                        <option value="1" <%=("1".equals(guest.getSex()) ? "SELECTED" : "")%>>Male</option>
                        <option value="2" <%=("2".equals(guest.getSex()) ? "SELECTED" : "")%>>Female</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="clearfix">
            <label>Last</label>
            <div class="input">
                <div class="inline-inputs">
                    <input type="text" name="last" id="last" class="span3" value="<%=guest.getLast()%>" /> &nbsp;Middle 
                    <input type="text" name="middle" id="middle" class="span2" value="<%=nameList.getMiddleName()%>" /> &nbsp;
                </div>
            </div>
        </div>
        <div class="clearfix">
            <label>First</label>
            <div class="input">
                <input type="text" name="first" id="first" class="span3" value="<%=guest.getFirst()%>" />
            </div>
        </div>
        <div class="clearfix">
            <label>Rate</label>
            <div class="input">
                <input type="text" name="rateCode" id="rateCode" class="span2" value="<%=(Converter.isEmpty(request.getParameter("rateNo")) ? "" : request.getParameter("rateNo"))%>"/>
                <button id="rateCodeBt" class="btn info" onclick="window.open('../ratecode/ratecode.jsp', '_blank', 'height=700, width=1000');return false;">...</button>
            </div>
        </div>
        <div class="clearfix">
            <label>Adult</label>
            <div class="input">
                <div class="inline-inputs">
                    <input type="text" name="adult" class="span1" value="<%=nameList.getAdult()%>"/> &nbsp; Child
                    <input type="text" name="child" class="span1" value="<%=nameList.getChild()%>"> 
                </div>
            </div>
        </div>

        <div class="clearfix">
            <label>Nationality</label>
            <div class="input">
                <select name="nationality" id="nationality" class="span3">
                    <%
                        preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                        rs = preparedStatementSelect.executeQuery();
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString(1)%>"  <%=(rs.getString(1).trim().equals(guest.getNationality().trim()) ? "SELECTED" : "")%>><%=rs.getString(2)%></option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="clearfix">
            <label>Passport</label>
            <div class="input">
                <input type="text" name="passport" id="passport" class="span3" value="<%=guest.getPassport()%>"/>
            </div>
        </div>
        <div class="clearfix">
            <label>Issue</label>
            <div class="input">
                <div class="inline-inputs">
                    <input type="text" name="issue" class="span2" value="<%=nameList.getIssue()%>"/> &nbsp; Expire
                    <input type="text" name="expire" class="span2" value="<%=nameList.getExpire()%>"> 
                </div>
            </div>
        </div>
        <input type="hidden" name="visa" value="02"/>
        <div class="clearfix">
            <label>Entry Point</label>
            <div class="input">
                <select name="entry" class="span3">
                    <%
                        preparedStatementSelect = dbConnection.prepareStatement("SELECT e_id, e_descr FROM entrypoint;");
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
        <div class="clearfix">
            <label>Charge to</label>
            <div class="input">
                <select name="chargeTo" class="span3"><option value="B">Booking Account</option><option value="O">Own Account</option></select>
            </div>
        </div>
        <div class="clearfix">
            <label><input type="checkbox" name="compliment" value="t" <%=(nameList.getCompliment().equalsIgnoreCase("t") ? "checked=\"checked\"" : "")%>/> </label>
            <div class="input">
                <ul class="inputs-list">
                    <li><label><span>Complimentary?</span></label></li>
                </ul>
            </div>
        </div>
        <%

            } catch (SQLException e) {
                errorList.add(e.getMessage());
            } finally {
                preparedStatementSelect.close();
                if (dbConnection != null) {
                    dbConnection.close();
                }
            }
        %>
    </fieldset>
    <div class="actions">
        <input type="submit" class="btn primary" value="Save"/> &nbsp;
        <input type="reset" class="btn" value="Reset"/> &nbsp;
    </div>
</form>
<% }%>