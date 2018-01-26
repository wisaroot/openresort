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
<%@page import="com.comis.frontsystem.guest.Guest"%>
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

<%!
    public NameList getNameList(String user1,String pw,String url,String driver,String accountId,String bookingAccountId,String dtl,String seq, List errorList)throws SQLException,Exception {
        NameList nameList=null;
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "SELECT nl_accno, nl_dtlseq, nl_seq, nl_roomno, nl_adult, nl_child, nl_arrdate,        nl_depdate, nl_roomtypeno, nl_bedtypeno, nl_comp, nl_rateno,        nl_chargeto,nl_titleno, nl_fname,        nl_mname,nl_lname,  nl_sex, nl_natno, nl_ownaccno,nl_passport, nl_pissue, nl_pexpire, nl_visatypeno,        nl_entryno  FROM namelist WHERE nl_ownaccno=? and nl_accno=? and nl_dtlseq=? and nl_seq=?;";
        int i=1;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(i++, Converter.parseInt(accountId));
            preparedStatementSelect.setInt(i++, Converter.parseInt(bookingAccountId));
            preparedStatementSelect.setInt(i++, Converter.parseInt(dtl));
            preparedStatementSelect.setInt(i++, Converter.parseInt(seq));
            ResultSet rs = preparedStatementSelect.executeQuery();
            
            while (rs.next()) {
                i=1;
                nameList=new NameList(rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++),rs.getString(i++));
            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        if(nameList==null)
            nameList=new NameList("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        return nameList;
    }
%>
