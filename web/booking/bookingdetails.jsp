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
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking List</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Booking List</h1>
            </div>
            <div class="row">

                <div class="span15 columns offset1">
                    
                    <!-- content here -->
                    <%
                        int minPg = 1;
                         int j=0;
                        int maxPg = 10;
                        int pgInterval = 10;
                        int pgLimit = 5;
                        String pg = (String) request.getParameter("pg");
                        if (pg == null) {
                            pg = "1";
                        }
                        int iPg = Integer.parseInt(pg);
                    %>

                    <a class="btn primary" href="<%=request.getContextPath()%>/booking/newbookingdetails.jsp?acc=<%=request.getParameter("acc")%>">New Booking</a>
                    <br/>
                    <br/>
                    <table class="zebra-striped" id="tbRateCode">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Account</th>
                                <th>Quantity</th>
                                <th>Arrival</th>
                                <th>Departure</th>
                                <th>Edit Booking</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String query = (String) request.getParameter("q");
                                
                                List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());
                                errorList = new ArrayList<String>();
                                session.setAttribute("errors" + session.getId(), errorList);
                                Connection dbConnection = null;
                                PreparedStatement preparedStatementSelect = null;
                                String selectSQL = "SELECT b_seq,b_accno,b_qty,b_arrdate,b_depdate from booking" + (query != null && !query.equals("") ? " where b_arrdate = ('" + query + "') and " : " where ") + " b_accno=? " +" order by b_seq asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);
                                String maxRateSQL = "select count(*) from booking" + (query != null  && !query.equals("")? " where b_arrdate = ('" + query + "') and" : " where ") + " b_accno=?";
                               
                                try {
                                   dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver,errorList);
                                    preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                                    preparedStatementSelect.setInt(1, Converter.parseInt((String)request.getParameter("acc")));
                                    ResultSet rs = preparedStatementSelect.executeQuery();

                                    while (rs.next()) {  j=1;%>
                            <tr>
                                <td><%=rs.getString(1)%></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(4)%></td>
                                <td><%=rs.getString(5)%></td>
                                <td><a class="btn info" href="<%=request.getContextPath()%>/booking/editbookingdetails.jsp?acc=<%=rs.getString(2)%>&dtl=<%=rs.getString(1)%>">Edit</a>
                                </td>

                            </tr>
                            <%
                                    }
                                    preparedStatementSelect = dbConnection.prepareStatement(maxRateSQL);
                                    preparedStatementSelect.setInt(1, Converter.parseInt((String)request.getParameter("acc")));
                                    rs = preparedStatementSelect.executeQuery();

                                    while (rs.next()) {
                                        maxPg = (rs.getInt(1) / pgLimit) + (rs.getInt(1) % pgLimit > 0 ? 1 : 0);
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
                        </tbody>
                        <tfoot>
                            <tr><td colspan="4">
                                    <div class="pagination">

                                        <ul>
                                            <li class="prev <% if (pg == null || pg.equals("1")) {%> disabled<%}%>"><a href="<%=request.getContextPath() + "/booking/bookingdetails.jsp?pg=" + (pg != null ? Integer.parseInt(pg) - 1 : "1") + "&acc="+ (String)request.getParameter("acc")+(query != null ? "&q=" + query : "")%>">&larr; Previous</a></li>
                                            <%

                                                int start = minPg + (iPg % pgInterval > 0 && iPg < pgInterval ? (pgInterval * (iPg / pgInterval)) : (iPg % pgInterval > 0 && iPg > pgInterval ? pgInterval * (iPg / pgInterval) : pgInterval * ((iPg / pgInterval) - 1)));
                                                int end = start + pgInterval;
                                                if (end > maxPg) {
                                                    end = maxPg + 1;
                                                }
                                                for (int i = start; i < end; i++) {
                                            %>
                                            <li class="<% if (i == iPg) {%>active<% }%>"><a href="<%=request.getContextPath() + "/booking/bookingdetails.jsp?pg=" + i + "&acc="+ (String)request.getParameter("acc") + (query != null ? "&q=" + query : "")%>"><%=i%></a></li>
                                            <%
                                                }
                                            %>
                                            <li class="next <% if (iPg >= maxPg) {%> disabled <% }%>"><a href="<%=request.getContextPath() + "/booking/bookingdetails.jsp?pg=" + (pg != null ? Integer.parseInt(pg) + 1 : "2") + "&acc="+ (String)request.getParameter("acc") +(query != null ? "&q=" + query : "")%>">Next &rarr;</a></li>
                                        </ul>
                                    </div></td>
                                <td colspan="2">
                                    <div style="height:36px;margin:18px 0;"><ul style="float:left;margin:0;"><li style="display:inline;">
                                                <form action="<%=request.getContextPath() + "/booking/bookingdetails.jsp"%>">
                                                    <div class="inline-inputs">
                                                        <input type="text" name="q" value="" class="span3" />
                                                        <input type="hidden" name="acc" value="<%=(String)request.getParameter("acc")%>" />
                                                        <button class="btn primary" type="submit">Search</button>
                                                    </div>
                                                </form></li></ul></div></td>
                     <% if(j==1){       %>                     
                            <tr>  <td  colspan="6"  >  <div align="right">                              
                    <a class="btn info" href="<%=request.getContextPath()%>/guestinfo/individual.jsp">Home</a>
                                    </div>     </td>
                    </tr>                   
<%}%>
                            
                        </tfoot>
                    </table>

                    <% if (errorList != null && errorList.size() > 0) {%>	
                    <div class="alert-message block-message error offset1">
                        <p>
                            <%

                                if (errorList != null) {
                                    for (String error : errorList) {
                                        out.println(error + "<br/>");
                                    }
                                    errorList = new ArrayList<String>();
                                    session.setAttribute("errors" + session.getId(), errorList);
                                }
                            %>
                        </p>
                    </div>

                    <% }%>
                    
                </div>
            </div>
        </div>
    </body>
</html>
