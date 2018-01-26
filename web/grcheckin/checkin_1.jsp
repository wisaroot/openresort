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
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>

<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);
  //  Connection dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

%>
<%!
    public boolean createNameList(String user1,String pw,String url,String driver,String accountId, String dtl, WebUser user, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "select \"createNameList\"(?,?,?)";
        boolean isCreate = false;

        try {
            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);
            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            int i = 1;
            int count = 0;
            preparedStatementSelect.setInt(i++, Converter.parseInt(accountId));
            preparedStatementSelect.setInt(i++, Converter.parseInt(dtl));
            preparedStatementSelect.setString(i++, user.getUsername());
            ResultSet rs = preparedStatementSelect.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
            if (count > 0) {
                isCreate = true;
            }

        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        return isCreate;
    }

    public boolean isCreateNotCheckIn(String user1,String pw,String url,String driver,String accountId, String dtl, List errorList) throws SQLException {
        boolean isCreate = true;
        int k = 0;
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "select count(*) from namelist where nl_accno=? and  nl_dtlseq = ? ";

        try {
            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            int i = 1;
            preparedStatementSelect.setInt(i++, Converter.parseInt(accountId));
            preparedStatementSelect.setInt(i++, Converter.parseInt(dtl));
            //  preparedStatementSelect.setInt(i++,Converter.parseInt(dtl));
            ResultSet rs = preparedStatementSelect.executeQuery();
            while (rs.next()) {
                k = rs.getInt(1);

            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        if (k == 0) {
            isCreate = false;
        }
        return isCreate;
    }

    public boolean isCreateAndCheckIn(String user1,String pw,String url,String driver,String accountId, String dtl, List errorList) throws SQLException {
        boolean isCreate = true;
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "select count(*) from namelist where nl_accno=? and (? is null or nl_dtlseq = ?) and nl_status in ('I','O');";

        try {
            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            int i = 1;
            preparedStatementSelect.setInt(i++, Converter.parseInt(accountId));
            preparedStatementSelect.setInt(i++, Converter.parseInt(dtl));
            preparedStatementSelect.setInt(i++, Converter.parseInt(dtl));
            ResultSet rs = preparedStatementSelect.executeQuery();
            while (rs.next()) {
                if (rs.getInt(1) == 0) {
                    isCreate = false;
                }
            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        return isCreate;
    }
%>
