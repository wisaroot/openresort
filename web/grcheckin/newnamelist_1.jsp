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
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<%!
    private void validate(NameList nameList, List errorList) {
        
    }
    private boolean addNameList(String user1,String pw,String url,String driver,NameList nameList,WebUser user, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementUpdate = null;

        
        String updateNameListSQL = "UPDATE namelist   SET nl_accno=?, nl_dtlseq=?, nl_seq=?, nl_roomno=?, nl_adult=?, nl_child=?,        nl_arrdate=?, nl_depdate=?, nl_roomtypeno=?, nl_bedtypeno=?,        nl_comp=?, nl_rateno=?, nl_chargeto=?, nl_recdate=?,        nl_userno=?, nl_titleno=?, nl_fname=?, nl_lname=?, nl_mname=?,        nl_sex=?, nl_natno=?, nl_ownaccno=?,nl_passport=?, nl_pissue=?,        nl_pexpire=?, nl_visatypeno=?,        nl_entryno=?, nl_room=(select rc_room from ratecode where rc_id=?), nl_service=(select rc_service from ratecode where rc_id=?),        nl_tax=(select rc_tax from ratecode where rc_id=?), nl_extrabed=(select rc_extrabed from ratecode where rc_id=?),        nl_extbedserv=(select rc_extbedserv from ratecode where rc_id=?), nl_extbedtax=(select rc_extbedtax from ratecode where rc_id=?), nl_abf=(select rc_abf from ratecode where rc_id=?), nl_lunch=(select rc_lunch from ratecode where rc_id=?), nl_dinner=(select rc_dinner from ratecode where rc_id=?),        nl_discount=(select rc_discount from ratecode where rc_id=?), nl_total=(SELECT rc_room + rc_service+ rc_tax+ rc_extrabed+ rc_extbedserv+        rc_extbedtax+ rc_abf+ rc_lunch+ rc_dinner- rc_discount FROM ratecode where rc_id=?) WHERE nl_accno=? and nl_dtlseq=? and nl_seq=?;";
/*UPDATE Table1 SET (something = something) WHERE Column1='something' 

IF @@ROWCOUNT=0 

    INSERT INTO Table1 VALUES (something, something)
 * */
      
         int i=1;
        boolean isSave = false;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            


            preparedStatementUpdate = dbConnection.prepareStatement(updateNameListSQL);
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getBookingAccountId()));
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getDtl()));
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getSeq()));
            preparedStatementUpdate.setString(i++,nameList.getRoomNo());
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getAdult()));
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getChild()));
            preparedStatementUpdate.setDate(i++, Converter.parseSQLDate(nameList.getArrival()));
            preparedStatementUpdate.setDate(i++, Converter.parseSQLDate(nameList.getDeparture()));
            preparedStatementUpdate.setString(i++, nameList.getRoomType());
            preparedStatementUpdate.setString(i++, nameList.getBedType());
             preparedStatementUpdate.setBoolean(i++, Converter.parseBoolean(nameList.getCompliment()));
             preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getChargeTo());
            preparedStatementUpdate.setDate(i++, Converter.parseSQLDate(Converter.getCurrentDate()));
            preparedStatementUpdate.setString(i++, user.getUsername());
            preparedStatementUpdate.setString(i++, nameList.getTitleNo());
            preparedStatementUpdate.setString(i++, nameList.getFirstName());
            preparedStatementUpdate.setString(i++, nameList.getLastName());
            preparedStatementUpdate.setString(i++, nameList.getMiddleName());
            preparedStatementUpdate.setString(i++, nameList.getSex());
            preparedStatementUpdate.setString(i++, nameList.getNationality());
            preparedStatementUpdate.setInt(i++, Converter.parseInt(nameList.getAccountId()));
            preparedStatementUpdate.setString(i++, nameList.getPassport());
            preparedStatementUpdate.setDate(i++, Converter.parseSQLDate(nameList.getIssue()));
            preparedStatementUpdate.setDate(i++, Converter.parseSQLDate(nameList.getExpire()));
            preparedStatementUpdate.setString(i++, nameList.getVisaType());
            preparedStatementUpdate.setString(i++, nameList.getEntry());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());//room
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setString(i++, nameList.getRateNo());
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getBookingAccountId()));
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getDtl()));
            preparedStatementUpdate.setInt(i++,Converter.parseInt(nameList.getSeq()));
            System.out.println(preparedStatementUpdate.toString());
            preparedStatementUpdate.executeUpdate();

            dbConnection.commit();
            isSave = true;


        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementUpdate.close();
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
    NameList nameList = new NameList(request.getParameter("bkacc"), request.getParameter("dtl"), request.getParameter("seq"), request.getParameter("roomNo"), request.getParameter("adult"), request.getParameter("child"), request.getParameter("arrival"), request.getParameter("departure"), request.getParameter("roomType"), request.getParameter("bedType"), request.getParameter("compliment"), request.getParameter("rateCode"), request.getParameter("chargeTo"), request.getParameter("title"), request.getParameter("first"), request.getParameter("middle"), request.getParameter("last"), request.getParameter("sex"), request.getParameter("nationality"), request.getParameter("acc"), request.getParameter("passport"), request.getParameter("issue"), request.getParameter("expire"),request.getParameter("visa"),request.getParameter("entry"));
    validate(nameList, errorList);
   
    if (errorList.size() > 0) {
        response.sendRedirect("namelist.jsp?bkacc="+nameList.getBookingAccountId()+"&dtl="+nameList.getDtl());
    } else {
        WebUser user=(WebUser)session.getAttribute(""+session.getId());
        if (addNameList(user1, pw, url, driver,nameList,user, errorList)) {
            response.sendRedirect("namelist.jsp?bkacc="+nameList.getBookingAccountId()+"&dtl="+nameList.getDtl());
        } else {
            response.sendRedirect("namelist.jsp?bkacc="+nameList.getBookingAccountId()+"&dtl="+nameList.getDtl());
        }
    }
    
%>