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
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%
    String accountId=request.getParameter("acc");
    String requestNo=request.getParameter("req");
    String fromDate=request.getParameter("from");
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors"+session.getId(), errorList);
    Connection dbConnection = null;
    PreparedStatement preparedStatementSelect = null;
    String selectSQL = "DELETE FROM brequire WHERE brq_accno=? AND brq_reqno=? AND brq_fromdate=?;";
    
    try {
        dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
        preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
        preparedStatementSelect.setInt(1, Converter.parseInt(accountId));
        preparedStatementSelect.setString(2, requestNo);
        preparedStatementSelect.setDate(3, Converter.parseSQLDate(fromDate));
        preparedStatementSelect.executeUpdate();
        
        
    } catch (SQLException e) {
        errorList.add(e.getMessage());
        
    } finally {
        preparedStatementSelect.close();
        if (dbConnection != null) {
            dbConnection.close();
        }
    }
      response.sendRedirect("newrequirementnote.jsp?acc="+request.getParameter("acc"));

%>
