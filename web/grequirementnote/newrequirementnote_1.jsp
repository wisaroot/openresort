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
<%@page import="java.sql.Statement"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="com.comis.frontsystem.booking.RequirementNote"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
  
<%!
String cg=null;

    private void validate(RequirementNote requirementNote, List errorList) {
       
        if (Converter.isEmpty(requirementNote.getAccountId())) {
            errorList.add("accountId is empty");
        }
        if (Converter.isEmpty(requirementNote.getRequirement())) {
            errorList.add("requirement is empty");
        }
        if (Converter.isEmpty(requirementNote.getFromDate())) {
            errorList.add("From date is empty");
        }
         if (Converter.isEmpty(requirementNote.getCharge())) {
              //errorList.add("charge empty");
            cg="N";
        }
    }
 

    private boolean addRequirementNote(String user1,String pw,String url,String driver,RequirementNote requirementNote, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;

        String insertRequirementSQL = "UPDATE grequire SET  gr_eventtime=?, gr_enddate=?, gr_chargeflag=?, gr_deptno=?, gr_amount=?, gr_chargetype=?, gr_remark=? WHERE gr_accno=? and gr_reqno=? and gr_fromdate=?;INSERT INTO grequire(gr_accno, gr_reqno, gr_fromdate, gr_eventtime, gr_enddate, gr_chargeflag, gr_deptno, gr_amount, gr_chargetype, gr_remark) select ?, ?, ?, ?, ?, ?, ?, ?, ?, ? where not exists (select 1 from grequire where gr_accno=? and gr_reqno=? and gr_fromdate=?);";
        String insertNoteSQL = "UPDATE gnote SET gn_accno=?, gn_note=? WHERE gn_accno=?;INSERT INTO gnote(gn_accno, gn_note) select ?, ? where not exists (select 1 from gnote where gn_accno=?);";

    //    if (requirementNote.getCharge().equals("Y")){cg ="Y";} else {    cg="N"; };
        boolean isSave = false;
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            if (!Converter.isEmpty(requirementNote.getRequirement())) {
                preparedStatementInsert = dbConnection.prepareStatement(insertRequirementSQL);
                preparedStatementInsert.setTime(1, Converter.parseSQLTime(requirementNote.getEventTime()));
                preparedStatementInsert.setDate(2, Converter.parseSQLDate(requirementNote.getEndDate()));
                preparedStatementInsert.setString(3, requirementNote.getCharge());
                preparedStatementInsert.setString(4, requirementNote.getDepartment());
                preparedStatementInsert.setDouble(5, Converter.parseDouble(requirementNote.getAmount()));
                preparedStatementInsert.setString(6, requirementNote.getChargeType());
                preparedStatementInsert.setString(7, requirementNote.getRemark());
                preparedStatementInsert.setInt(8, Converter.parseInt(requirementNote.getAccountId()));
                preparedStatementInsert.setString(9, requirementNote.getRequirement());
                preparedStatementInsert.setDate(10, Converter.parseSQLDate(requirementNote.getFromDate()));
                preparedStatementInsert.setInt(11, Converter.parseInt(requirementNote.getAccountId()));
                preparedStatementInsert.setString(12, requirementNote.getRequirement());
                preparedStatementInsert.setDate(13, Converter.parseSQLDate(requirementNote.getFromDate()));
                preparedStatementInsert.setTime(14, Converter.parseSQLTime(requirementNote.getEventTime()));
                preparedStatementInsert.setDate(15, Converter.parseSQLDate(requirementNote.getEndDate()));
                preparedStatementInsert.setString(16, requirementNote.getCharge());
                preparedStatementInsert.setString(17, requirementNote.getDepartment());
                preparedStatementInsert.setDouble(18, Converter.parseDouble(requirementNote.getAmount()));
                preparedStatementInsert.setString(19, requirementNote.getChargeType());
                preparedStatementInsert.setString(20, requirementNote.getRemark());
                preparedStatementInsert.setInt(21, Converter.parseInt(requirementNote.getAccountId()));
                preparedStatementInsert.setString(22, requirementNote.getRequirement());
                preparedStatementInsert.setDate(23, Converter.parseSQLDate(requirementNote.getFromDate()));
                preparedStatementInsert.executeUpdate();
            }


            preparedStatementInsert = dbConnection.prepareStatement(insertNoteSQL);
            preparedStatementInsert.setInt(1, Converter.parseInt(requirementNote.getAccountId()));
            preparedStatementInsert.setString(2, requirementNote.getNote());
            preparedStatementInsert.setInt(3, Converter.parseInt(requirementNote.getAccountId()));
            preparedStatementInsert.setInt(4, Converter.parseInt(requirementNote.getAccountId()));
            preparedStatementInsert.setString(5, requirementNote.getNote());
            preparedStatementInsert.setInt(6, Converter.parseInt(requirementNote.getAccountId()));
            preparedStatementInsert.executeUpdate();

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
    RequirementNote requirementNote = new RequirementNote((String) request.getParameter("amount"), (String) request.getParameter("charge"), (String) request.getParameter("chgType"), (String) request.getParameter("department"), (String) request.getParameter("endDate"), (String) request.getParameter("eventTime"), (String) request.getParameter("fromDate"), (String) request.getParameter("note"), (String) request.getParameter("remark"), (String) request.getParameter("requirement"), (String) request.getParameter("accountId"));
    validate(requirementNote, errorList);
    if (errorList.size() > 0) {
        response.sendRedirect("newrequirementnote.jsp?acc=" + requirementNote.getAccountId());
    } else {
        if (addRequirementNote(user1, pw, url, driver,requirementNote, errorList)) {
          //  response.sendRedirect("../guestinfo/individual.jsp");
            response.sendRedirect("newrequirementnote.jsp?acc=" + requirementNote.getAccountId());
        } else {
            response.sendRedirect("newrequirementnote.jsp?acc=" + requirementNote.getAccountId());
        }
    }
%></body>