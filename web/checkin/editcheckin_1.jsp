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
  
<%@page import="com.comis.frontsystem.checkin.GFolio"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="com.comis.frontsystem.booking.BookingDetails"%>
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
    public GFolio getGFolio(String user1,String pw,String url,String driver,String gFolioId, List errorList)throws SQLException,Exception {
        GFolio gFolio=null;
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "SELECT  gf_accno, gf_bkaccno, gf_bookseq,  gf_roomno, gf_roomtypeno,  gf_comp, gf_compby,gf_adult, gf_child, gf_rateno, gf_room, gf_service, gf_tax, gf_extrabed, gf_extbedserv, gf_extbedtax, gf_abf, gf_lunch, gf_dinner, gf_discount, gf_discby, gf_total FROM gfolio WHERE gf_folno=?;";
        
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1, Converter.parseInt(gFolioId));
            
            ResultSet rs = preparedStatementSelect.executeQuery();

            while (rs.next()) {
                gFolio=new GFolio(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),  rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22));
            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        if(gFolio==null)
            throw new Exception("Can't load GFolio");
        return gFolio;
    }
%>
