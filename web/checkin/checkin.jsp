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

<%@page import="com.comis.frontsystem.checkin.CheckIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>

<%@page import="java.sql.ResultSet"%>
 <%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@include file="checkin_1.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    Connection dbConnection = null;
    int inh = 0, qty = 0;
  //  List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());
    PreparedStatement preparedStatementSelect = null;
    CheckIn checkIn = null;
   
    
    dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

    checkIn = new CheckIn(request.getParameter("acc"), request.getParameter("roomno"));
    String booking = "", seq = "";
    preparedStatementSelect = dbConnection.prepareStatement("SELECT b_inhqty,b_qty FROM booking where b_accno= " + checkIn.getAccountId() + ";");
    ResultSet rs = preparedStatementSelect.executeQuery();

    while (rs.next()) {
        inh = rs.getInt(1);
        qty = rs.getInt(2);
    }
%>  <table><tr><td><%=inh%><%=qty%></td></tr></table>  <%
    int aa = 0;

    try {
        dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);


        preparedStatementSelect = dbConnection.prepareStatement("SELECT count(b_accno) FROM booking where b_accno= " + checkIn.getAccountId() + ";");
        rs = preparedStatementSelect.executeQuery();

        while (rs.next()) {
            aa = rs.getInt(1);
        }

    } catch (SQLException e) {
        errorList.add(e.getMessage());
    } finally {
        preparedStatementSelect.close();
        if (dbConnection != null) {
            dbConnection.close();
        }
    }
    if (aa == 1) {
        booking = checkIn.getAccountId();
        seq = "0";
    }
    if (request.getParameter("gf") == null || (inh < qty)) {

//select gaccount.accno,booking.accno,seq,guestno,grpno,gfolio.bkaccno from booking inner join gaccount on booking.accno=gaccount.accno inner join  gfolio   on gfolio.accno=  gaccount.accno




        if (aa == 0) {
            response.sendRedirect(request.getContextPath() + "/booking/newdetails.jsp?acc=" + checkIn.getAccountId());

        }

        errorList = new ArrayList<String>();
        session.setAttribute("errors" + session.getId(), errorList);
        // copyBRequire(checkIn.getAccountId(), booking, errorList);
        // copyBRateChange(checkIn.getAccountId(), booking, "1", errorList);
        // copyBNote(checkIn.getAccountId(), booking, errorList);
        if (errorList.size() > 0) {
            throw new Exception();
        }
        session.setAttribute("checkIn" + session.getId(), checkIn);
        if (qty == 1) {
            response.sendRedirect("newcheckin.jsp?acc=" + checkIn.getAccountId() + "&bkacc=" + booking + "&dtl=" + seq + "&seq=" + seq + "&roomno=" + checkIn.getRoomNo());
        } else if (qty > 1) {
            response.sendRedirect("CheckinSeq.jsp?acc=" + checkIn.getAccountId() + "&bkacc=" + booking + "&dtl=" + seq + "&seq=" + seq + "&roomno=" + checkIn.getRoomNo() + "&qty=" + qty);
        }
    } else if ((qty > 1) && (qty > inh)) {
        response.sendRedirect("CheckinSeq.jsp?acc=" + checkIn.getAccountId() + "&bkacc=" + checkIn.getAccountId() + "&dtl=" + seq + "&seq=" + seq + "&roomno=" + checkIn.getRoomNo() + "&qty=" + qty);
    } else {
        //   response.sendRedirect("editcheckin.jsp?gf=" + request.getParameter("gf"));
        response.sendRedirect("allcheckin.jsp?bkacc=" + checkIn.getAccountId());

    }
%>