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
<%@page errorPage="../errorPage.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<% 
List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);

%>
<%!
    public void copyBRequire(String user1,String pw,String url,String driver,String accountId,String oldAccountId,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO grequire(gr_accno, gr_reqno, gr_fromdate, gr_eventtime, gr_enddate, gr_chargeflag, gr_deptno, gr_amount, gr_chargetype, gr_remark) SELECT ?, brq_reqno, brq_fromdate, brq_eventtime, brq_enddate, brq_chargeflag, brq_deptno, brq_amount, brq_chargetype, brq_remark FROM brequire WHERE brq_accno=? and not exists (select 1 from grequire where gr_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(accountId));
            preparedStatementSelect.executeUpdate();
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
    public void copyBRateChange(String user1,String pw,String url,String driver,String accountId,String oldAccountId,String dtl,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO gratechange(grc_accno, grc_chgdate, grc_room, grc_service, grc_tax, grc_extrabed, grc_extbedserv, grc_extbedtax, grc_discount, grc_abf, grc_lunch, grc_dinner, grc_userno, grc_rateno, grc_orino)SELECT ?, brc_chgdate, brc_room, brc_service, brc_tax, brc_extrabed, brc_extbedserv, brc_extbedtax, brc_discount, brc_abf, brc_lunch, brc_dinner, brc_userno,brc_rateno,brc_orino from bratechange where brc_accno=? and brc_seq=? and not exists (select 1 from gratechange where grc_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(dtl));
            preparedStatementSelect.setInt(4,Converter.parseInt(accountId));
            
            preparedStatementSelect.executeUpdate();
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
    public void copyBNote(String user1,String pw,String url,String driver,String accountId,String oldAccountId,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO gnote(gn_accno, gn_note) SELECT ?, bn_note FROM bnote WHERE bn_accno=? and not exists (select 1 from gnote where gn_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(accountId));
            preparedStatementSelect.executeUpdate();
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
%>