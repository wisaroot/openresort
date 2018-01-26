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
<%@page import="javax.swing.text.html.HTMLDocument.HTMLReader.PreAction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="com.comis.frontsystem.booking.BookingDetails"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<%!
    private void validate(BookingDetails bookingDetails, List errorList) {
        if (Converter.isEmpty(bookingDetails.getAccountId())) {
            errorList.add("accountId is empty");
        }
        if (Converter.isEmpty(bookingDetails.getDtl())) {
            errorList.add("dtl is empty");
        }
        if (Converter.isEmpty(bookingDetails.getRoomType())) {
            errorList.add("roomType is empty");
        }
        if (Converter.isEmpty(bookingDetails.getCompliment())) {
            errorList.add("compliment is emtpy");
        }
        if (Converter.isEmpty(bookingDetails.getRateCode())){
            errorList.add("ratecode is empty");
        }
    }

    private boolean addBookingDetails(String user1,String pw,String url,String driver,BookingDetails bookingDetails, String allotmentId, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;
        String insertBookingDetailsSQL = "INSERT INTO booking(b_accno, b_seq, b_adult, b_child, b_qty, b_arrdate, b_depdate, b_roomtypeno, b_bedtypeno, b_comp, b_rateno, b_chargeto, b_alotqty, b_room, b_service, b_tax, b_extrabed, b_extbedserv, b_extbedtax, b_abf, b_lunch, b_dinner, b_discount, b_total)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        String insertAllotmentSQL = "INSERT INTO allotmentuse(amu_accno, amu_dtlseq, amu_allotno, amu_acctype, amu_startdate, amu_enddate, amu_bookdate, amu_roomtypeno, amu_qty, amu_status, \"name\") VALUES (?, ?, ?, (select ga_acctype from gaccount where ga_accno=?), ?, ?, ?, ?, ?, (select ga_accstat from gaccount where ga_accno=?), (SELECT guestname.gn_titleno || ' ' ||guestname.gn_fname || ' ' ||guestname.gn_mname || ' ' || guestname.gn_lname FROM public.guestname, public.gaccount WHERE gaccount.ga_guestno = guestname.gn_guestno and ga_accno=?));";
        boolean isSave = false;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(insertBookingDetailsSQL);
            preparedStatementInsert.setInt(1, Converter.parseInt(bookingDetails.getAccountId()));
            preparedStatementInsert.setInt(2, Converter.parseInt(bookingDetails.getDtl()));
            preparedStatementInsert.setInt(3, Converter.parseInt(bookingDetails.getAdult()));
            preparedStatementInsert.setInt(4, Converter.parseInt(bookingDetails.getChild()));
            preparedStatementInsert.setInt(5, Converter.parseInt(bookingDetails.getQty()));
            preparedStatementInsert.setDate(6, Converter.parseSQLDate(bookingDetails.getArrival()));
            preparedStatementInsert.setDate(7, Converter.parseSQLDate(bookingDetails.getDeparture()));
            preparedStatementInsert.setString(8, bookingDetails.getRoomType());
            preparedStatementInsert.setString(9, bookingDetails.getBedType());
            preparedStatementInsert.setBoolean(10, Converter.parseBoolean(bookingDetails.getCompliment()));
            preparedStatementInsert.setString(11, bookingDetails.getRateCode());
            preparedStatementInsert.setString(12, bookingDetails.getChargeTo());
            preparedStatementInsert.setInt(13, Converter.parseInt(bookingDetails.getAllotmentQty()));
            preparedStatementInsert.setDouble(14, Converter.parseDouble(bookingDetails.getRoom()));
            preparedStatementInsert.setDouble(15, Converter.parseDouble(bookingDetails.getService()));
            preparedStatementInsert.setDouble(16, Converter.parseDouble(bookingDetails.getTax()));
            preparedStatementInsert.setDouble(17, Converter.parseDouble(bookingDetails.getExtraBed()));
            preparedStatementInsert.setDouble(18, Converter.parseDouble(bookingDetails.getExtBedService()));
            preparedStatementInsert.setDouble(19, Converter.parseDouble(bookingDetails.getExtBedTax()));
            preparedStatementInsert.setDouble(20, Converter.parseDouble(bookingDetails.getAbf()));
            preparedStatementInsert.setDouble(21, Converter.parseDouble(bookingDetails.getLunch()));
            preparedStatementInsert.setDouble(22, Converter.parseDouble(bookingDetails.getDinner()));
            preparedStatementInsert.setDouble(23, Converter.parseDouble(bookingDetails.getDiscount()));
            preparedStatementInsert.setDouble(24, Converter.parseDouble(bookingDetails.getTotal()));
            preparedStatementInsert.executeUpdate();

            if(!Converter.isEmpty(allotmentId)) {
                preparedStatementInsert = dbConnection.prepareStatement(insertAllotmentSQL);
                int i = 1;
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getAccountId()));
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getDtl()));
                preparedStatementInsert.setInt(i++, Converter.parseInt(allotmentId));
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getAccountId()));
                preparedStatementInsert.setDate(i++, Converter.parseSQLDate(bookingDetails.getArrival()));
                preparedStatementInsert.setDate(i++, Converter.parseSQLDate(bookingDetails.getDeparture()));
                preparedStatementInsert.setDate(i++, Converter.parseSQLDate(Converter.getCurrentDate()));
                preparedStatementInsert.setString(i++, bookingDetails.getRoomType());
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getAllotmentQty()));
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getAccountId()));
                preparedStatementInsert.setInt(i++, Converter.parseInt(bookingDetails.getAccountId()));
                preparedStatementInsert.executeUpdate();
            }
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
    BookingDetails bookingDetails = new BookingDetails(
            (String) request.getParameter("acc"),
            (String) request.getParameter("dtl"),
            (String) request.getParameter("adult"),
            (String) request.getParameter("child"),
            (String) request.getParameter("qty"),
            (String) request.getParameter("allotQty"),
            (String) request.getParameter("arrival"),
            (String) request.getParameter("departure"),
            (String) request.getParameter("roomType"),
            (String) request.getParameter("bedType"),
            (String) request.getParameter("rateCode"),
            (String) request.getParameter("compliment"),
            (String) request.getParameter("chargeTo"),
            (String) request.getParameter("room"),
            (String) request.getParameter("service"),
            (String) request.getParameter("tax"),
            (String) request.getParameter("extraBed"),
            (String) request.getParameter("extraBedService"),
            (String) request.getParameter("extraBedTax"),
            (String) request.getParameter("abf"),
            (String) request.getParameter("lunch"),
            (String) request.getParameter("dinner"),
            (String) request.getParameter("discount"),
            (String) request.getParameter("total"));
    validate(bookingDetails, errorList);
    if (errorList.size() > 0) {
        response.sendRedirect("newbookingdetails.jsp?acc=" + bookingDetails.getAccountId());
    } else {
        if (addBookingDetails(user1, pw, url, driver,bookingDetails, request.getParameter("allotmentId"), errorList)) {
            response.sendRedirect("../brequirementnote/newrequirementnote.jsp?acc=" + bookingDetails.getAccountId());
        } else {
            response.sendRedirect("newbookingdetails.jsp?acc=" + bookingDetails.getAccountId());
        }
    }
%>