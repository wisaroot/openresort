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
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.ratecode.RateCode"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%!
    private void validate(RateCode rateCode, List errorList) {
        if (Converter.isEmpty(rateCode.getRateCode())) {
            errorList.add("ratecode is empty");
        }
        if (Converter.isEmpty(rateCode.getChgDate())) {
            errorList.add("chgDate is empty");
        }
        
    }

    private boolean addUpdateBRateChange(String user1,String pw,String url,String driver,RateCode rateCode,WebUser user,List errorList)throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsertUpdate = null;
        String insertUpdateBRateChangeSQL = "update gratechange set grc_room=?, grc_service=?, grc_tax=?, grc_extrabed=?, grc_extbedserv=?, grc_extbedtax=?, grc_discount=?, grc_abf=?, grc_lunch=?, grc_dinner=?,grc_userno=? where grc_accno=? and grc_chgdate=?;insert into gratechange (grc_accno,grc_chgdate,grc_room,grc_service,grc_tax,grc_extrabed,grc_extbedserv,grc_extbedtax,grc_discount,grc_abf,grc_lunch,grc_dinner,grc_userno,grc_rateno) select ?,?,?,?,?,?,?,?,?,?,?,?,?,? where not exists (select 1 from gratechange where grc_accno=? and grc_chgdate=?);";
        boolean isSave = false;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsertUpdate = dbConnection.prepareStatement(insertUpdateBRateChangeSQL);
            preparedStatementInsertUpdate.setDouble(1, Converter.parseDouble(rateCode.getRoom()));
            preparedStatementInsertUpdate.setDouble(2, Converter.parseDouble(rateCode.getService()));
            preparedStatementInsertUpdate.setDouble(3, Converter.parseDouble(rateCode.getTax()));
            preparedStatementInsertUpdate.setDouble(4, Converter.parseDouble(rateCode.getExtraBed()));
            preparedStatementInsertUpdate.setDouble(5, Converter.parseDouble(rateCode.getExtraBedService()));
            preparedStatementInsertUpdate.setDouble(6, Converter.parseDouble(rateCode.getExtraBedTax()));
            preparedStatementInsertUpdate.setDouble(7, Converter.parseDouble(rateCode.getDiscount()));
            preparedStatementInsertUpdate.setDouble(8, Converter.parseDouble(rateCode.getAbf()));
            preparedStatementInsertUpdate.setDouble(9, Converter.parseDouble(rateCode.getLunch()));
            preparedStatementInsertUpdate.setDouble(10, Converter.parseDouble(rateCode.getDinner()));
            preparedStatementInsertUpdate.setString(11, user.getUsername());
            preparedStatementInsertUpdate.setInt(12, Converter.parseInt(rateCode.getAccountId()));
            preparedStatementInsertUpdate.setDate(13, Converter.parseSQLDate(rateCode.getChgDate()));
            
            preparedStatementInsertUpdate.setInt(14, Converter.parseInt(rateCode.getAccountId()));
            preparedStatementInsertUpdate.setDate(15, Converter.parseSQLDate(rateCode.getChgDate()));
            preparedStatementInsertUpdate.setDouble(16, Converter.parseDouble(rateCode.getRoom()));
            preparedStatementInsertUpdate.setDouble(17, Converter.parseDouble(rateCode.getService()));
            preparedStatementInsertUpdate.setDouble(18, Converter.parseDouble(rateCode.getTax()));
            preparedStatementInsertUpdate.setDouble(19, Converter.parseDouble(rateCode.getExtraBed()));
            preparedStatementInsertUpdate.setDouble(20, Converter.parseDouble(rateCode.getExtraBedService()));
            preparedStatementInsertUpdate.setDouble(21, Converter.parseDouble(rateCode.getExtraBedTax()));
            preparedStatementInsertUpdate.setDouble(22, Converter.parseDouble(rateCode.getDiscount()));
            preparedStatementInsertUpdate.setDouble(23, Converter.parseDouble(rateCode.getAbf()));
            preparedStatementInsertUpdate.setDouble(24, Converter.parseDouble(rateCode.getLunch()));
            preparedStatementInsertUpdate.setDouble(25, Converter.parseDouble(rateCode.getDinner()));
            preparedStatementInsertUpdate.setString(26, user.getUsername());
            
            preparedStatementInsertUpdate.setString(27,rateCode.getRateCode());
            preparedStatementInsertUpdate.setInt(28, Converter.parseInt(rateCode.getAccountId()));
            preparedStatementInsertUpdate.setDate(29, Converter.parseSQLDate(rateCode.getChgDate()));
            
            preparedStatementInsertUpdate.executeUpdate();
             
            dbConnection.commit();
            isSave = true;


        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementInsertUpdate.close();
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
        
        RateCode rateCode=new RateCode(
                (String)request.getParameter("accountId"),
                (String)request.getParameter("chgDate"),
                (String)request.getParameter("rateCode"),
                (String)request.getParameter("seq"),
                (String)request.getParameter("room"),
                (String)request.getParameter("service"),
                (String)request.getParameter("tax"),
                (String)request.getParameter("extraBed"),
                (String)request.getParameter("extraBedService"),
                (String)request.getParameter("extraBedTax"),
                (String)request.getParameter("abf"),
                (String)request.getParameter("lunch"),
                (String)request.getParameter("dinner"),
                (String)request.getParameter("discount"),
                (String)request.getParameter("total"));
	validate(rateCode,errorList);
        if(errorList.size()>0){
            out.println("failed");
        }else{
            WebUser user=(WebUser)session.getAttribute(""+session.getId());
            if(addUpdateBRateChange(user1, pw, url, driver,rateCode, user, errorList)){
                out.println("success");
            }else{
                out.println("failed");
            }
        }
%>
