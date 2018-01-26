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
    String roomType=(String)request.getParameter("rt");
    String bedType=(String)request.getParameter("bt");
    String location=(String)request.getParameter("lo");
    //String status=(String)request.getParameter("st");
    String exposure=(String)request.getParameter("ex");
    String arrival=(String)request.getParameter("arr");
    String departure=(String)request.getParameter("dep");
    
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    Connection dbConnection = null;
    PreparedStatement preparedStatementSelect = null;
    String selectSQL = "SELECT ri_room  from roominfo where  ri_location='"+location+"' and ri_location='"+exposure+"' and ri_bedtype ='"+bedType+"'";
    //String selectSQL = "SELECT   roominfo.ri_room FROM   public.roominfo LEFT JOIN    public.roomstatus ON (roominfo.ri_room = roomstatus.rs_roomno) LEFT JOIN  public.status  ON (roomstatus.rs_statusno = status.rs_id) LEFT JOIN  public.bedtype ON (roominfo.ri_bedtype = bedtype.bt_id) LEFT JOIN   public.exposure ON (roominfo.ri_exposure = exposure.e_id) LEFT JOIN   public.roomtype ON (roominfo.ri_type = roomtype.rt_id) LEFT JOIN   location ON (roominfo.ri_location = l_id) LEFT OUTER JOIN block ON (bl_roomno=ri_room) WHERE rt_id=? AND bt_id=? AND l_id=? AND e_id=? AND rs_id=? AND((bl_depdate < ? OR bl_arrdate > ? OR bl_arrdate IS NULL OR bl_depdate IS NULL) AND ? < ?) AND (? >= rs_available);";
    
    try {
        dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

        preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
     /*   preparedStatementSelect.setString(1, roomType);
        preparedStatementSelect.setString(2,bedType);
        preparedStatementSelect.setString(3,location);
        preparedStatementSelect.setString(4,exposure);
        
        preparedStatementSelect.setDate(6,Converter.parseSQLDate(arrival));
        preparedStatementSelect.setDate(7,Converter.parseSQLDate(departure));
        preparedStatementSelect.setDate(8,Converter.parseSQLDate(arrival));
        preparedStatementSelect.setDate(9,Converter.parseSQLDate(departure));
        preparedStatementSelect.setDate(10,Converter.parseSQLDate(arrival));
        */
        ResultSet rs = preparedStatementSelect.executeQuery();
        
        while (rs.next()) {
        out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
        
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