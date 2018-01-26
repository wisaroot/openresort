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
<%@page import="com.comis.frontsystem.guestinfo.Individual"%>
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
        <title>GuestInfo - Individual</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript">
            function closeAndGo(url){
                var p=window.opener;
                p.location.href=url;
                self.close();
            }
        </script>
    </head>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Individual</h1>
            </div>
            <div class="row">

                <div class="span16 columns">
                    <%
                        List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());

                    %>	
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

                    <!-- content here -->
                    <%
                        int minPg = 1;
                        int maxPg = 10;
                        int pgInterval = 10;
                        int pgLimit = 5;
                        String pg = (String) request.getParameter("pg");
                        if (pg == null) {
                            pg = "1";
                        }
                        int iPg = Integer.parseInt(pg);
                    %>
                    <table class="zebra-striped" >
                        <thead>
                            <tr>
                                <th>Room</th>
                                <th>Arrival</th>
                                <th>Departure</th>
                                <th>Room Type</th>
                                <th>Bed Type</th>
                                <th>C/I</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Individual individual = (Individual) session.getAttribute("individual" + session.getId());
                                errorList = (ArrayList) session.getAttribute("errors" + session.getId());
                                errorList = new ArrayList<String>();
                                session.setAttribute("errors" + session.getId(), errorList);
                                Connection dbConnection = null;
                                PreparedStatement preparedStatementSelect = null;
                                String selectSQL = "select gf_accno,bcf_cfmno,gf_roomno,ga_accstat,t_id,gn_fname,gn_mname,gn_lname,gri_grpname,ga_arrival,ga_arrtime,ga_departure,ga_deptime,a_name,n_descr,gi_company,b_qty,b_inhqty,b_seq,gf_folno,rt_descr,bt_descr,gf_bkaccno from getdiffrows(?,?) " + " order by gf_accno asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);
                                String maxRateSQL = "select count(*) from getdiffrows(?,?);";
                                String accountId = (String) request.getParameter("acc");
                                String dtl = (String) request.getParameter("dtl");
                                if (accountId == null || dtl == null) {
                                    throw new Exception("id or dtl is null");
                                }
                                try {

                                    dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                                    preparedStatementSelect = dbConnection.prepareStatement(selectSQL);

                                    preparedStatementSelect.setInt(1, Converter.parseInt(accountId));
                                    preparedStatementSelect.setInt(2, Converter.parseInt(dtl));

                                    ResultSet rs = preparedStatementSelect.executeQuery();

                                    while (rs.next()) {%>
                            <tr>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(10)%>&nbsp;<%=rs.getString(11)%></td>
                                <td><%=rs.getString(12)%>&nbsp;<%=rs.getString(13)%></td>
                                <td><%=rs.getString(21)%></td>
                                <td><%=rs.getString(22)%></td>
                                <td><button onclick="closeAndGo('<%=request.getContextPath()+"/checkin/checkin.jsp?acc="+rs.getString(1)+"&bkacc="+rs.getString(23)+"&roomno="+rs.getString(3)+"&dtl="+rs.getString(19)+(rs.getString(20)==null?"":"&gf="+rs.getString(20))%>')" class="btn info"><%=rs.getString(18)%></button></td>
                            </tr>
                            <%
                                    }
                                    preparedStatementSelect = dbConnection.prepareStatement(maxRateSQL);

                                    preparedStatementSelect.setInt(1, Converter.parseInt(accountId));
                                    preparedStatementSelect.setInt(2, Converter.parseInt(dtl));


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
                            <tr>
                                <td colspan="18">
                                    <div class="pagination">

                                        <ul>
                                            <li class="prev <% if (pg == null || pg.equals("1")) {%> disabled<%}%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + (pg != null ? Integer.parseInt(pg) - 1 : "1")%>">&larr; Previous</a></li>
                                            <%

                                                int start = minPg + (iPg % pgInterval > 0 && iPg < pgInterval ? (pgInterval * (iPg / pgInterval)) : (iPg % pgInterval > 0 && iPg > pgInterval ? pgInterval * (iPg / pgInterval) : pgInterval * ((iPg / pgInterval) - 1)));
                                                int end = start + pgInterval;
                                                if (end > maxPg) {
                                                    end = maxPg + 1;
                                                }
                                                for (int i = start; i < end; i++) {
                                            %>
                                            <li class="<% if (i == iPg) {%>active<% }%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + i%>"><%=i%></a></li>
                                            <%
                                                }
                                            %>
                                            <li class="next <% if (iPg >= maxPg) {%> disabled <% }%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + (pg != null ? Integer.parseInt(pg) + 1 : "2")%>">Next &rarr;</a></li>
                                        </ul>
                                    </div>
                                </td>

                            </tr>
                        </tfoot>
                    </table>
                    <%!
                        public String extractData(Individual individual) {
                            String data = "";
                            if (!Converter.isEmpty(individual.getFirst())) {
                                extractStringField(data, "gn_fname");
                            }
                            if (!Converter.isEmpty(individual.getLast())) {
                                extractStringField(data, "gn_lname");
                            }
                            
                           
                            if (!Converter.isEmpty(individual.getNationality())) {
                                extractStringField(data, "n_id");
                            }
                            if (!Converter.isEmpty(individual.getArrival())) {
                                extractDateField(data, "ga_arrival");
                            }
                            if (!Converter.isEmpty(individual.getDeparture())) {
                                extractDateField(data, "ga_departure");
                            }
                          
                            if (!Converter.isEmpty(individual.getAgent())) {
                                extractIntegerField(data, "a_id");
                            }
                            if (!Converter.isEmpty(individual.getGroup())) {
                                extractStringField(data, "gri_grpname");
                            }
                            if (!Converter.isEmpty(individual.getRoomNo())) {
                                extractStringField(data, "gf_roomno");
                            }
                            if (!Converter.isEmpty(individual.getAccountId())) {
                                extractIntegerField(data, "gf_accno");
                            }
                            if (!Converter.isEmpty(individual.getStatus())) {
                                extractStringField(data, "ga_accstat");
                            }
                            return data;
                        }

                        public String extractStringField(String data, String fieldName) {
                            if (data.equals("")) {
                                data = " WHERE lower(" + fieldName + ") like lower(?) ";
                            } else {
                                data = " AND lower(" + fieldName + ") like lower(?) ";
                            }
                            return data;
                        }

                        public String extractIntegerField(String data, String fieldName) {
                            if (data.equals("")) {
                                data = " WHERE " + fieldName + " = ? ";
                            } else {
                                data = " AND " + fieldName + " = ? ";
                            }
                            return data;
                        }

                        public String extractDateField(String data, String fieldName) {
                            if (data.equals("")) {
                                data = " WHERE " + fieldName + " = ? ";
                            } else {
                                data = " AND " + fieldName + " = ? ";
                            }
                            return data;
                        }
                    %>                                   
                </div>
            </div>
        </div>
    </body>
</html>
