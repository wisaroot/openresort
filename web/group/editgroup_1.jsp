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
<%@page import="com.comis.frontsystem.group.Group"%>
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
    public Group getGroup(String user1,String pw,String url,String driver,String accountId, List errorList)throws SQLException,Exception {
        Group group=null;
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "SELECT   gaccount.ga_accno,   gaccount.ga_agentno,   gaccount.ga_arrby,   gaccount.ga_arrival,   gaccount.ga_arrfrom,   gaccount.ga_arrtime,   gaccount.ga_bookby,   gaccount.ga_coa,   groupinfo.gri_company,   groupinfo.gri_ctno,   groupinfo.gri_crlimit,   gaccount.ga_depby,   gaccount.ga_departure,   gaccount.ga_deptime,   gaccount.ga_depto,   groupinfo.gri_email,   groupinfo.gri_entryno,   groupinfo.gri_pexpire,   groupinfo.gri_faxno,   gaccount.ga_fpatno,   groupinfo.gri_grpname,   groupinfo.gri_pissue,   groupinfo.gri_natno,   gaccount.ga_orino,   groupinfo.gri_telno,   gaccount.ga_rsvtypeno,   groupinfo.gri_vipno,   groupinfo.gri_visatypeno FROM   public.groupinfo,   public.gaccount WHERE   groupinfo.gri_grpno = gaccount.ga_grpno and ga_accno=?;";
        
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1, Converter.parseInt(accountId));
            ResultSet rs = preparedStatementSelect.executeQuery();

            while (rs.next()) {
                group=new Group(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getString(25), rs.getString(26), rs.getString(27), rs.getString(28));
            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        if(group==null)
            throw new Exception("Can't load Group");
        return group;
    }
%>
