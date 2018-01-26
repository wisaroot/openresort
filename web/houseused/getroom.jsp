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
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%
 List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    Connection dbConnection = null;
    PreparedStatement preparedStatementSelect = null;
    String selectSQL = "SELECT bl_roomno FROM block WHERE bl_accno=? and bl_dtlseq=? and bl_arrdate=? and bl_depdate=?;";
    
    try {
        dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
        preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
        preparedStatementSelect.setInt(1,Converter.parseInt(request.getParameter("acc")));
        preparedStatementSelect.setInt(2,Converter.parseInt(request.getParameter("dtl")));
        preparedStatementSelect.setDate(3, Converter.parseSQLDate(request.getParameter("arr")));
        preparedStatementSelect.setDate(4, Converter.parseSQLDate(request.getParameter("dep")));
        ResultSet rs = preparedStatementSelect.executeQuery();
        
        while (rs.next()) {
            out.println(rs.getString(1));
        
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