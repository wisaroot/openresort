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
<%@page import="com.comis.frontsystem.guestinfo.Individual1"%>
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
        <script type="text/JavaScript">
            function reset1()
            {
    

                var f=document.form;

                f.submit=null;
                
                window.opener.location.href="individual.jsp";
 

            }
        </script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body  >
        <div align="center"  class="content">
            <div class="page-header offset1">
                <h1>Individual</h1>
            </div>
            <div align="center"  >

                <div class="span16 columns" align="center"  >
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
                        int test = 1;

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
                    <form method="post" name="form"
                          action=""  >
                        <fieldset>
                            <legend>Individual Information</legend>
                            <div class="clearfix">
                                <div class="span5 columns">
                                    <label>First</label>
                                    <div class="input">
                                        <input class="span3" name="first"  />
                                    </div>
                                </div>

                                <div class="span6 columns">
                                    <label>Last</label>
                                    <div class="input">
                                        <input class="span3" name="last" />
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix">
                                <div class="span5 columns">

                                </div>
                                <div class="span5 columns">
                                    <label>Nationality</label>
                                    <div class="input">
                                        <select class="span3" name="nationality">
                                            <option value=""> </option>
                                            <%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                                                ResultSet rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {

                                            %>
                                            <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
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
                                    <label>Agent</label>
                                    <div class="input">
                                        <select name="agent" class="span3" >
                                            <option value=""> </option>
                                            <%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT a_id, a_name FROM agent;");
                                                rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                            <%
                                                }
                                            %>
                                            <select>
                                                </div>
                                                </div>
                                                <div class="span5 columns">
                                                    <label>Group</label>
                                                    <div class="input">
                                                        <input class="span3" name="group" />
                                                    </div>
                                                </div>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="span5 columns">
                                                        <label>Room</label>
                                                        <div class="input">
                                                            <input class="mini" name="roomNo" />
                                                        </div>
                                                    </div>
                                                    <div class="span5 columns">
                                                        <label>Account</label>
                                                        <div class="input">
                                                            <input class="mini" name="accountId" />
                                                        </div>
                                                    </div>
                                                    <div class="span5 columns">
                                                        <label>Confirm</label>
                                                        <div class="input">
                                                            <input class="mini" name="confirmNo1" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="span16 columns">
                                                        <div class="input">
                                                            <input type="checkbox" name="status"  id="Check1" value="" checked="true" onclick="CheckOne(this)" />
                                                            <span>All</span>
                                                            <input type="checkbox" name="status"  id="Check2" value="R" onclick="CheckOne(this)"  />
                                                            <span>Reserved</span>
                                                            <input type="checkbox" name="status"  id="Check3" value="C" onclick="CheckOne(this)" />
                                                            <span>Confirmed</span>
                                                            <input type="checkbox" name="status"  id="Check4" value="W" onclick="CheckOne(this)" />
                                                            <span>Wait List</span>
                                                            <input type="checkbox" name="status"  id="Check5" value="I" onclick="CheckOne(this)" />
                                                            <span>In House</span>
                                                            <input type="checkbox" name="status"  id="Check6" value="X" onclick="CheckOne(this)" />
                                                            <span>Cancel</span>
                                                            <input type="checkbox" name="status"  id="Check7" value="N" onclick="CheckOne(this)" />
                                                            <span>No Show</span>
                                                            <input type="checkbox" name="status"  id="Check8" value="O" onclick="CheckOne(this)" />
                                                            <span>Check Out</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div align="center" class="actions" >
                                                    <input name="submit" type="submit" value="Search" class="btn primary"/>

                                                    <button    class="btn" type="reset">Reset</button>
                                                    <button onclick="JavaScript:reset1()" class="btn" >Show All</BUTTON>
                                                </div>
                                                <script language="javascript" type="text/javascript">
                                                    function CheckOne(obj) {
                                                        var grid = obj.parentNode.parentNode.parentNode;
                                                        var inputs = grid.getElementsByTagName("input");
                                                        for (var p = 0; p < inputs.length; p++) {
                                                            if (inputs[p].type == "checkbox") {
                                                                if (obj.checked && inputs[p] != obj && inputs[p].checked) {
                                                                    inputs[p].checked = false;
                                                                }
                                                            }
                                                        }
          
                                                    } 

                                                </script>





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

                                                    if (request.getParameter("submit") == null) {

                                                %>
                                                <jsp:include page="individual_1.jsp"/>

                                                <%} else if ((request.getParameter("submit") != null) && test == 1) {

                                                    String text[] = new String[11];
                                                    String text1 = "y";
                                                    int aa = 0;

                                                    String first = request.getParameter("first");
                                                    if (first.equals("")) {
                                                    } else {
                                                        text[aa] = " guestname.gn_fname LIKE '%" + first + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String last = request.getParameter("last");
                                                    if (last.equals("")) {
                                                    } else {
                                                        text[aa] = " guestname.gn_lname LIKE '%" + last + "%'";
                                                        aa = aa + 1;
                                                    }
                                                    String nationality = request.getParameter("nationality");
                                                    if (nationality.equals("")) {
                                                    } else {
                                                        text[aa] = " n_descr = '" + nationality + "'";
                                                        aa = aa + 1;
                                                    }

                                                    String arrival = request.getParameter("arrival");
                                                    String departure = request.getParameter("departure");
                                                    if (arrival.equals("") && departure.equals("")) {
                                                    } else {
                                                        if (arrival.equals("")) {
                                                            arrival = departure;
                                                        } else if (departure.equals("")) {
                                                            departure = arrival;
                                                        }


                                                        text[aa] = " ga_departure >= '" + arrival + "' and  ga_arrival<='" + arrival + "' or ('" + departure + "' between ga_arrival and ga_departure ) ";
                                                        aa = aa + 1;
                                                    }



                                                    String agent = request.getParameter("agent");
                                                    if (agent.equals("")) {
                                                    } else {
                                                        text[aa] = " a_name LIKE '%" + agent + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String group = request.getParameter("group");
                                                    if (group.equals("")) {
                                                    } else {
                                                        text[aa] = " gri_grpname LIKE '%" + group + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String roomNo = request.getParameter("roomNo");
                                                    if (roomNo.equals("")) {
                                                    } else {
                                                        text[aa] = " gf_roomno LIKE '%" + roomNo + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String accountId = request.getParameter("accountId");
                                                    if (accountId.equals("")) {
                                                    } else {


                                                        text[aa] = "  CAST(ga_accno AS TEXT) LIKE '%" + accountId + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String comfirmNo = request.getParameter("confirmNo1");
                                                    if (comfirmNo.equals("")) {
                                                    } else {
                                                        text[aa] = " CAST(bcf_cfmno AS TEXT) LIKE '%" + comfirmNo + "%'";
                                                        aa = aa + 1;
                                                    }

                                                    String status = request.getParameter("status");
                                                    if (status.equals("")) {
                                                    } else {
                                                       
                                                            text[aa] = " ga_accstat = '" + status + "'";

                                                            aa = aa + 1;
                                                        

                                                    }

                                                    String where = "";
                                                    int i = 0;
                                                    while (i < aa) {
                                                        where = where + text[i];
                                                        i++;
                                                        if (i == aa) {
                                                        } else {
                                                            where = where + " and ";
                                                        }
                                                    }
                                                    if (aa > 0) {
                                                        Individual1 individual = new Individual1(where);
                                                        session.setAttribute("individual" + session.getId(), individual);

                                                        //    Individual individual = new Individual(request.getParameter("first"), request.getParameter("last"), request.getParameter("nationality"), request.getParameter("arrival"), request.getParameter("departure"), request.getParameter("agent"), request.getParameter("group"), request.getParameter("roomNo"), request.getParameter("accountId"), request.getParameter("comfirmNo"), request.getParameter("status"));
                                                        //     session.setAttribute("individual" + session.getId(), individual);
                                                %>

                                                <%--                  <table  class="zebra-striped" >  <tr><td><%=text1%></td></tr></table>
                                                --%>

                                                <jsp:include page="individual_3.jsp"/>
                                                <%
                                                        }
                                                    }



                                                %> 

                                                </div>
                                                </div>
                                                </div>
                                                </body>
                                                </html>
