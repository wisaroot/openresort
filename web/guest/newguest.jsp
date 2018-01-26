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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Guest</title>
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
        <script language="javascript" type="text/javascript">  
            var xmlHttp  
            var xmlHttp
            function showState(str){ 
                if (typeof XMLHttpRequest != "undefined"){
                    xmlHttp= new XMLHttpRequest();
                }
                else if (window.ActiveXObject){
                    xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
                }
                if (xmlHttp==null){
                    alert ("Browser does not support XMLHTTP Request")
                    return
                } 
                var url= "agent.jsp";
                url += "?count=" +str;
                xmlHttp.onreadystatechange = stateChange;
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
            function stateChange(){   
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
                    document.getElementById("agent").innerHTML=xmlHttp.responseText   
                }   
            }   
        </script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>New Guest</h1>
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
                            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

                            //String accountId, String confidential, String coa, String vip, String reserveBy, String follioPattern,
                            //String title, String last, String first, String middle, String sex, String origin, String bookBy,
                            //String agent, String nationality, String birthDate, String company, String position, String creditCard,
                            //String cardNo, String creditLimit, String address1, String address2, String phone, String fax,
                            //String country, String email, String passport, String arrival, String arrTime, String arrFrom,
                            //String arrBy, String departure, String depTime, String depTo, String depBy
%>
                    <form  method="post" name="aa" action="newguest_1.jsp">
                        <fieldset>
                            <legend>Guest Form</legend>
                            <input type="hidden" name="accountId" value=""/>

                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    # <span class="uneditable-input span2">&lt;AUTO GEN&gt;</span> &nbsp; 
                                    <input type="checkbox" name="confidential" value="Y"/> <span><strong>Confidential?</strong></span>
                                    &nbsp; <input type="checkbox" name="coa" value="Y"/> <span><strong>Cash On Available(COA)?</strong></span>
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
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; Reserved By <select name="reserveBy" class="span3">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT rsvtypeno, \"name\" FROM resvtype;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
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
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
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
                                    Title <select class="span2" name="title">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT t_id, t_descr, t_sex FROM title;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Last <input type="text" class="span3" name="last"/> &nbsp; 
                                    First <input type="text" class="span3" name="first"/> &nbsp; 
                                    Middle <input type="text" class="span3" name="middle"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Sex <select class="span2" name="sex">
                                        <option value="0">Not specify</option>
                                        <option value="1">Male</option>
                                        <option value="2">Female</option>
                                    </select> &nbsp; 
                                  
                                   

                                    Origin <select class="span3" onchange="showState(this.value)" name="origin">
                                        <option value=""></option>
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT o_id, o_descr || ' - ' || o_id as o_descr FROM origin;");
                                            rs = preparedStatementSelect.executeQuery();

                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp;

                                  
                                    Book By <input type="text" class="span2" name="bookBy"/> &nbsp; 
                                    

                                    Agent <select name="agent" id="agent" >  
                                        <option value='-1'></option>  
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
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Birthdate <input type="text" class="span2" name="birthDate" id="birthDate"/> &nbsp; 
                                    Company <input type="text" class="span2" name="company"/> &nbsp; 
                                    Position <input type="text" class="span2" name="position"/> &nbsp; 
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
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                    Card No <input type="text" class="span3" name="cardNo"/> &nbsp; 
                                    Credit Limit <input type="text" class="span2" name="creditLimit"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Address <input type="text" class="span6" name="address1"/> &nbsp; 
                                    <input type="text" class="span6" name="address2"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Phone <input type="text" class="span3" name="phone"/> &nbsp; 
                                    Fax   <input type="text" class="span3" name="fax"/> &nbsp; 
                                    Country <select class="span3" name="country">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT ct_id, ct_descr FROM country;");
                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%
                                            }
                                        %>
                                    </select> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Email <input type="text" class="span3" name="email"/> &nbsp; 
                                    Passport <input type="text" class="span3" name="passport"/> &nbsp; 
                                     Voucher <input type="text" class="span3" name="voucher"/> &nbsp;
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Arrival Date <input type="text" class="span2" name="arrival" id="arrival"/> &nbsp; 
                                    Time <input type="text" class="span2" name="arrTime"/> &nbsp;
                                    From <input type="text" class="span3" name="arrFrom"/> &nbsp; 
                                    By <input type="text" class="span3" name="arrBy"/> &nbsp; 
                                </div>
                            </div>
                            <div class="clearfix">
                                <label>&nbsp;</label>
                                <div class="inline-inputs">
                                    Departure Date <input type="text" class="span2" name="departure" id="departure"/> &nbsp; 
                                    Time <input type="text" class="span2" name="depTime"/> &nbsp;
                                    To <input type="text" class="span3" name="depTo"/> &nbsp; 
                                    By <input type="text" class="span3" name="depBy"/> &nbsp; 
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
