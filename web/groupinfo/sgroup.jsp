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
<%@page import="com.comis.frontsystem.groupinfo.GroupInfo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.guestinfo.Individual"%>
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
        <title>GuestInfo - Group</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/flick/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
		$("#arrival").datepicker({dateFormat : 'yy-mm-dd'});
               $("#departure").datepicker({dateFormat : 'yy-mm-dd'});
            });
        </script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Group</h1>
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
                    <%

                        errorList = (ArrayList) session.getAttribute("errors" + session.getId());
                        errorList = new ArrayList<String>();
                        session.setAttribute("errors" + session.getId(), errorList);
                        Connection dbConnection = null;
                        PreparedStatement preparedStatementSelect = null;


                        try {
                           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

                            //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
                            //String title, String last, String first, String middle, String sex, String origin, String bookBy,
                            //String agent, String nationality, String birthDate, String company, String position, String creditCard,
                            //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
                            //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
                            //String arrBy, String departure, String depTime, String depTo, String depBy
                    %>
                    <!-- content here -->
                    <form method="post"
                          action="">
                        <fieldset>
                            <legend>Group Information</legend>
                            <div class="clearfix">
                                <div class="span5 columns">
                                    <label>Group Name</label>
                                    <div class="input">
                                        <input class="span3" name="grpname" />
                                    </div>
                                </div>
                                <div class="span6 columns">
                                    <label>Confirm No.</label>
                                    <div class="input">
                                        <input class="span3" name="confirmNo" id="confirmNo"/>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix">
                                
                                <div class="span5 columns">
                                    <label>Nationality</label>
                                    <div class="input">
                                        <select class="span3" name="nationality">
                                            <%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                                                ResultSet rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="span6 columns">
                                    <label>Date</label>
                                    <div class="input">
                                        <div class="inline-inputs">
                                            <input class="mini" name="arrival" id="arrival"/>
                                            to
                                            <input class="mini" name="departure" id="departure"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix">
                                <div class="span5 columns">
                                    <label>Company</label>
                                    <div class="input">
                                        <input class="span3" name="company" />
                                    </div>
                                </div>
                                <div class="span5 columns">
                                    <label>Agent</label>
                                    <div class="input">
                                        <select name="agent" class="span3" >
                                            <%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT a_id, a_name FROM agent;");
                                                rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                            <%
                                                }
                                            %>
                                            <select>
                                                </div>
                                                </div>
                                                
                                                </div>
                                                <div class="clearfix">
                                                    <div class="span5 columns">
                                                        <label>Account</label>
                                                        <div class="input">
                                                            <input class="mini" name="accountId" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="span16 columns">
                                                        <div class="input">

                                                            <input type="checkbox" name="status" value="R" />
                                                            <span>Reserved</span>
                                                            <input type="checkbox" name="status" value="C" />
                                                            <span>Confirmed</span>
                                                            <input type="checkbox" name="status" value="TTT" />
                                                            <span>Wait List</span>
                                                            <input type="checkbox" name="status" value="INH" />
                                                            <span>In House</span>
                                                            <input type="checkbox" name="status" value="CLX" />
                                                            <span>Cancel</span>
                                                            <input type="checkbox" name="status" value="N" />
                                                            <span>No Show</span>
                                                            <input type="checkbox" name="status" value="O" />
                                                            <span>Check Out</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="actions" >
                                                    <input type="submit" value="Search" class="btn primary">
                                                    <button class="btn" type="reset">Reset</button>
                                                </div>
                                                <%

                                                    } catch (SQLException e) {
                                                        errorList.add(e.getMessage());
                                                    } finally {
                                                        preparedStatementSelect.close();
                                                        if (dbConnection != null) {
                                                            dbConnection.close();
                                                        }
                                                    }
                                                %>
                                                </fieldset>
                                                </form>

                                                <%
                                                    GroupInfo groupInfo = new GroupInfo(request.getParameter("grpname"), request.getParameter("nationality"), request.getParameter("company"), request.getParameter("arrival"), request.getParameter("departure"), request.getParameter("agent"), request.getParameter("accountId"),request.getParameter("confirmNo"));
                                                    session.setAttribute("groupinfo" + session.getId(), groupInfo);
                                                %>
                                                <jsp:include page="sgroup_1.jsp"/>
                                                </div>
                                                </div>
                                                </div>
                                                </body>
                                                </html>
