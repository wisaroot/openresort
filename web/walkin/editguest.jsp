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
<%@ include file ="../config.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Guest</title>
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
    <%@ include file="editguest_1.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Edit Guest</h1>
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
                        Guest guest=getGuest(user1, pw, url, driver,(String)request.getParameter("acc"),errorList);
                        
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
                    <form  method="post" action="editguest_2.jsp">
                        <fieldset>
                            <legend>Guest Form</legend>
                            <input type="hidden" name="accountId" value="<%=guest.getAccountId()%>"/>

                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    # <span class="uneditable-input span2"><%=(guest.getAccountId()==null||guest.getAccountId().equals("")?"&lt;AUTO GEN&gt;":guest.getAccountId())%></span> &nbsp; 
                                    <input type="checkbox" name="confidential" value="Y" <%=(guest.getConfidential().equalsIgnoreCase("Y")?"checked=\"checked\"":"")%>/> <span><strong>Confidential?</strong></span>
                                    &nbsp; <input type="checkbox" name="coa" value="Y" <%=(guest.getCoa().equalsIgnoreCase("Y")?"checked=\"checked\"":"")%>/> <span><strong>Cash On Available(COA)?</strong></span>
                                </div>
                            </div>    
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    VIP <select class="span3" name="vip">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT v_id, v_descr, v_keepday FROM vip;");
                                            ResultSet rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getVip().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>/><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; Reserved By <select name="reserveBy" class="span3">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT rsvtypeno, \"name\" FROM resvtype;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getReserveBy().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Follio Pattern <select class="span3" name="follioPattern">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT fp_id, fp_descr FROM folpattern;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getFollioPattern().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Title <select class="span2" name="title" id="title">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT t_id, t_descr, t_sex FROM title;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getTitle().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Last <input type="text" class="span3" name="last" id="last" value="<%=guest.getLast()%>"/> &nbsp; 
                                    First <input type="text" class="span3" name="first" id="first" value="<%=guest.getFirst()%>"/> &nbsp; 
                                    Middle <input type="text" class="span3" name="middle" id="middle" value="<%=guest.getMiddle()%>"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Sex <select class="span2" name="sex">
                                        <option value="0" <%=(guest.getSex().equalsIgnoreCase("0")?"selected=\"selected\"":"")%>>Not specify</option>
                                        <option value="1" <%=(guest.getSex().equalsIgnoreCase("1")?"selected=\"selected\"":"")%> >Male</option>
                                        <option value="2" <%=(guest.getSex().equalsIgnoreCase("2")?"selected=\"selected\"":"")%>>Female</option>
                                    </select> &nbsp; 
                                    Origin <select class="span3" onchange="getAgent(this.value)" name="origin">
                                        <option value=""></option>
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT o_id, o_descr || ' - ' || o_id as o_descr FROM origin;");
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getOrigin().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%> ><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp;
                                    Book By <input type="text" class="span2" name="bookBy" value="<%=guest.getBookBy()%>"/> &nbsp; 

                                    <script>
                                        function getAgent(a){
                                            $.ajax( '<%=request.getContextPath()%>/guest/getagent.jsp?oid='+a ).done(function(data) { 
                                                $('#agent').children().remove();
                                                $('#agent').append(data);
                                            })
                                        }
                                    </script>
                                    Agent <select class="span4" name="agent" id="agent">
                                       <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT a_id, a_name FROM agent where o_id=?;");
                                            preparedStatementSelect.setString(1,guest.getOrigin());
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getAgent().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%> ><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp;   
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Nationality <select class="span3" name="nationality">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT n_id, n_descr FROM nationality;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getNationality().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Birthdate <input type="text" class="span2" name="birthDate" value="<%=guest.getBirthDate()%>"/> &nbsp; 
                                    Company <input type="text" class="span2" name="company" value="<%=guest.getCompany()%>"/> &nbsp; 
                                    Position <input type="text" class="span2" name="position" value="<%=guest.getPosition()%>"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Credit Card <select class="span3" name="creditCard">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT m_id,m_descr FROM media where m_grp='23';");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getCreditCard().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Card No <input type="text" class="span3" name="cardNo" value="<%=guest.getCardNo()%>"/> &nbsp; 
                                    Credit Limit <input type="text" class="span2" name="creditLimit" value="<%=guest.getCreditLimit()%>"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Address <input type="text" class="span6" name="address1" value="<%=guest.getAddress1()%>"/> &nbsp; 
                                    <input type="text" class="span6" name="address2" value="<%=guest.getAddress2()%>"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Phone <input type="text" class="span3" name="phone" value="<%=guest.getPhone()%>"/> &nbsp; 
                                    Fax   <input type="text" class="span3" name="fax" value="<%=guest.getFax()%>"/> &nbsp; 
                                    Country <select class="span3" name="country">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT ct_id, ct_descr FROM country;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>" <%=(guest.getCountry().equalsIgnoreCase(rs.getString(1))?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Email <input type="text" class="span3" name="email" value="<%=guest.getEmail()%>"/> &nbsp; 
                                    Passport <input type="text" class="span3" name="passport" value="<%=guest.getPassport()%>"/> &nbsp; 
                                       Voucher <input type="text" class="span3" name="voucher" value="<%=guest.getVoucher()%>"/> &nbsp; 
                              
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Arrival Date <input type="text" class="span2" name="arrival" value="<%=guest.getArrival()%>"/> &nbsp; 
                                    Time <input type="text" class="span2" name="arrTime" value="<%=guest.getArrTime()%>"/> &nbsp;
                                    From <input type="text" class="span3" name="arrFrom" value="<%=guest.getArrFrom()%>"/> &nbsp; 
                                    By <input type="text" class="span3" name="arrBy" value="<%=guest.getArrBy()%>"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Departure Date <input type="text" class="span2" name="departure" value="<%=guest.getDeparture()%>"/> &nbsp; 
                                    Time <input type="text" class="span2" name="depTime" value="<%=guest.getDepTime()%>"/> &nbsp;
                                    To <input type="text" class="span3" name="depTo" value="<%=guest.getDepTo()%>"/> &nbsp; 
                                    By <input type="text" class="span3" name="depBy" value="<%=guest.getDepBy()%>"/> &nbsp; 
                                </div>
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
                        <div class="actions"><input type="submit" value="Next" class="btn primary offset-two-thirds" ></div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
