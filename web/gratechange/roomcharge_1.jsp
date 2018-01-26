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
  
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%
    String bChgDate = (String) request.getParameter("bd");
    String accountId = (String) request.getParameter("acc");
    
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);
    Connection dbConnection = null;
    PreparedStatement preparedStatementSelect = null;
    String selectBRateChangeSQL = "SELECT grc_room, grc_service, grc_tax, grc_extrabed, grc_extbedserv, grc_extbedtax, grc_discount, grc_abf, grc_lunch, grc_dinner,(grc_room+grc_service+grc_tax+grc_extrabed+grc_extbedserv+grc_extbedtax-grc_discount+grc_abf+grc_lunch+grc_dinner)as grc_total, grc_chgdate FROM gratechange where grc_chgdate=? and grc_accno=?;";
    
    try {
        dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
        preparedStatementSelect = dbConnection.prepareStatement(selectBRateChangeSQL);
        preparedStatementSelect.setDate(1, Converter.parseSQLDate(bChgDate));
        preparedStatementSelect.setInt(2,Converter.parseInt(accountId));
       
        ResultSet rs = preparedStatementSelect.executeQuery();

         while (rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("room", rs.getString(1));
            obj.put("service", rs.getString(2));
            obj.put("tax", rs.getString(3));
            obj.put("extraBed", rs.getString(4));
            obj.put("extraBedService", rs.getString(5));
            obj.put("extraBedTax", rs.getString(6));
            obj.put("discount", rs.getString(7));
            obj.put("abf", rs.getString(8));
            obj.put("lunch", rs.getString(9));
            obj.put("dinner", rs.getString(10));
            obj.put("total", rs.getString(11));
            obj.put("chgDate", rs.getString(12));
            out.print(obj);
            out.flush();
        }
       

    } catch (SQLException e) {
        errorList.add(e.getMessage());
    } finally {
        preparedStatementSelect.close();
        if (dbConnection != null) {
            dbConnection.close();
        }
    }
%>

