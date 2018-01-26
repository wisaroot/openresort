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
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
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
        <title>New Group</title>
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
               $("#birthDate").datepicker({dateFormat : 'yy-mm-dd', yearRange: '1950:2070' ,changeMonth: true, changeYear: true})
            });
        </script>
    </head>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>New Group</h1>
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
                    <form method="post" action="newgroup_1.jsp">
                        <fieldset>
                            <legend>Group Form</legend>
                            <input type="hidden" name="accountId" value=""/>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    # <span class="uneditable-input span2">&lt;AUTO GEN&gt;</span> &nbsp; 
                                    Group Name <input type="text" name="grpname" class="span3"/>
                                    &nbsp; <input type="checkbox" name="coa" value="Y"/> <span><strong>Cash On Available(COA)?</strong></span>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Reserve By <select name="reserveBy" class="span3"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT rsvtypeno, \"name\" FROM resvtype;");
                                            ResultSet rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                        Origin <select name="origin" class="span3" onchange="getAgent(this.value)"><option></option><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT o_id, o_descr || ' - ' || o_id as o_descr FROM origin;");
                                            rs = preparedStatementSelect.executeQuery();
                                            
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                    
                                    &nbsp; Follio <select name="follioPattern" class="span3"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT fp_id, fp_descr FROM folpattern;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    VIP <select name="vip" class="span3"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT v_id, v_descr, v_keepday FROM vip;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                    Book By <input type="text" name="bookBy" class="span3"/>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Agent <select name="agent" id="agent" class="span3"><script>
                                        function getAgent(a){
                                            $.ajax( '<%=request.getContextPath()%>/guest/getagent.jsp?oid='+a ).done(function(data) { 
                                                $('#agent').children().remove();
                                                $('#agent').append(data);
                                            })
                                        }
                                    </script></select>
                                    Company <input type="text" name="company" class="span3"/>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Nationality <select name="nationality" class="span3"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                    Country <select name="country" class="span3"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT ct_id, ct_descr FROM country;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                    Credit Limit <input type="text" name="creditLimit" class="span3"/>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Phone No. <input type="text" name="phone" class="span3"/> &nbsp;
                                    Fax No. <input type="text" name="fax" class="span3"/> &nbsp;
                                    Email <input type="text" name="email" class="span3"/>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Visa Type <select name="visaType" class="span2"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT vs_id, vs_descr FROM visatype;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select> &nbsp;
                                    Issue <input type="text" name="issue" class="span2"/> &nbsp;
                                    Expire <input type="text" name="expire" class="span2"/> &nbsp;
                                    Entry Point <select name="entry" class="span2"><%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT e_id, e_descr FROM entrypoint;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %></select>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                      Arrival Date <input type="text" class="span2" name="arrival" id="arrival"/> &nbsp; 
                                 
                                    Time <input type="text" name="arrTime" class="span2" /> &nbsp;
                                    From <input type="text" name="arrFrom" class="span2" /> &nbsp;
                                    By <input type="text" name="arrBy" class="span2" /> &nbsp;
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                      Departure Date <input type="text" class="span2" name="departure" id="departure"/> &nbsp; 
                                  
                                    Time <input type="text" name="depTime" class="span2" /> &nbsp;
                                    To <input type="text" name="depTo" class="span2" /> &nbsp;
                                    By <input type="text" name="depBy" class="span2" /> &nbsp;
                                </div>
                            </div>
                        </fieldset>
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
                        <div class="actions"><input type="submit" value="Next" class="btn primary offset-two-thirds" ></div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
