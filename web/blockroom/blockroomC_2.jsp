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
<%@ include file ="../config.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%
    String accountId=(String)request.getParameter("bkacc");
    String dtl=(String)request.getParameter("dtl");
    String seq=(String)request.getParameter("seq");
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors"+session.getId(), errorList);
    Connection dbConnection = null;
    PreparedStatement preparedStatementDelete = null;
    String deleteSQL = "delete from block where bl_accno=? and bl_dtlseq=? and bl_seq=?";
    
    try {
       dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver,errorList);
        dbConnection.setAutoCommit(false);
        preparedStatementDelete = dbConnection.prepareStatement(deleteSQL);
        preparedStatementDelete.setInt(1, Converter.parseInt(accountId));
        preparedStatementDelete.setInt(2, Converter.parseInt(dtl));
        preparedStatementDelete.setInt(3, Converter.parseInt(seq));
        preparedStatementDelete.executeUpdate();
        dbConnection.commit();
        
    } catch (SQLException e) {
        errorList.add(e.getMessage());
        dbConnection.rollback();
    } finally {
        preparedStatementDelete.close();
        if (dbConnection != null) {
            dbConnection.close();
        }
    }
    response.sendRedirect("blockroomC.jsp?bkacc="+request.getParameter("bkacc")+"&dtl="+request.getParameter("dtl")+"&arr="+request.getParameter("arr")+"&dep="+request.getParameter("dep")+"&bt="+request.getParameter("bt")+"&qty="+request.getParameter("qty")+"&rt="+request.getParameter("rt")+"&seq="+request.getParameter("seq"));
%>