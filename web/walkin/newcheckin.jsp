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
<%@page import="com.comis.frontsystem.booking.BookingDetails"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
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
        <title>Walk In</title>
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
                <h1>Walk In</h1>
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
                    %>

                    <!-- content here -->
                    <form  method="post" action="newcheckin_2.jsp">
                        <fieldset>
                            <legend>Booking Details Form</legend>
                            <div class="row">
                                <div class="span6">

                                    <div class="clearfix">
                                        <label>Adult</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="adult"
                                                       class="span1" value="0"/>&nbsp;
                                                Child <input type="text" name="child"
                                                             class="span1" value="0"/>
                                            </div>
                                        </div>
                                    </div>


                                    <input type="hidden"  name="acc" id="acc" value="<%=request.getParameter("acc")%>"/>
                                    <input type="hidden"  name="dtl" id="dtl" value="0"/>
                                    

                                    <div class="clearfix">
                                        <label>Arrival</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="arrival" id="arrival"
                                                       class="span2" value="<%=request.getParameter("arr")%>"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Departure</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="departure" id="departure"
                                                       class="span2" value="<%=request.getParameter("dep")%>" /> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Room Type</label>
                                        <div class="input">
                                            <select name="roomType" class="span3" >
                                                <%
                                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT rt_id, rt_descr FROM roomtype;");
                                                    ResultSet rs = preparedStatementSelect.executeQuery();
                                                    while (rs.next()) {
                                                %>
                                                <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Bed Type</label>
                                        <div class="input">
                                            <select name="bedType"class="span3">
                                                <%
                                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT bt_id, bt_descr FROM bedtype;");
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
                                    <div class="clearfix">
                                        <label>Block Room</label>
                                        <div class="input">
                                            <input type="text" name="roomNo" id="roomNo" class="span2" value="<%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT bl_roomno FROM block WHERE bl_accno=? and bl_dtlseq=? and bl_arrdate=? and bl_depdate=? and bl_seq=?;");
                                                preparedStatementSelect.setInt(1, Converter.parseInt(request.getParameter("acc")));
                                                preparedStatementSelect.setInt(2, 0);
                                                preparedStatementSelect.setDate(3, Converter.parseSQLDate(request.getParameter("arr")));
                                                preparedStatementSelect.setDate(4, Converter.parseSQLDate(request.getParameter("dep")));
                                                preparedStatementSelect.setInt(5, 0);
                                                rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {
                                                   %><%=rs.getString(1)%><%
                                                    }
                                                   %>"/>
                                            <button class="btn info"  onclick="window.open('blockroom.jsp?acc='+acc.value+'&bt='+bedType.value+'&rt='+roomType.value+'&arr='+arrival.value+'&dep='+departure.value+'&qty=1&dtl='+dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
                                        </div>
                                    </div>
                                  
                                              <div class="clearfix">
                                        <label>Rate</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="rateCode" id="rateCode" class="span2" />
                                                <button id="rateCodeBt" class="btn info" onclick="window.open('../ratecode/ratecode.jsp', '_blank', 'height=700, width=1000');return false;">...</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Room Charge Schedule</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <button class="btn info" onclick="window.open('../gratechange/roomcharge.jsp?acc='+acc.value+'&arr='+arrival.value+'&dep='+departure.value+'&seq='+dtl.value+'&rc=COM', '_blank', 'height=700, width=1000');return false;">...</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clearfix">
                                        <label><input type="checkbox" name="compliment" value="t" /> </label>
                                        <div class="input">
                                            <ul class="inputs-list">
                                                <li><label><span>Complimentary?</span></label></li>
                                            </ul>

                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Compliment By </label>
                                        <div class="input">
                                            <input type="text" name="compBy" class="span2"/>
                                        </div>
                                    </div>


                                </div>
                                <!-- Rate Details -->

                                <script type="text/javascript">
                                    $(document).ready(function(){
                                        clearOpenRate(); 
                                        $('.openrate').bind('change',function(){
                                            sumRate();
                                        });
                                    });
                                    function sumRate(){
                                        var sum=0;
                                        sum+=parseFloatRate('room');
                                        sum+=parseFloatRate('service');
                                        sum+=parseFloatRate('tax');
                                        sum+=parseFloatRate('extraBed');
                                        sum+=parseFloatRate('extraBedService');
                                        sum+=parseFloatRate('extraBedTax');
                                        sum+=parseFloatRate('abf');
                                        sum+=parseFloatRate('lunch');
                                        sum+=parseFloatRate('dinner');
                                        sum-=parseFloatRate('discount');
                                        $('#total').val(sum.toFixed(2));
                                    }
                                    function parseFloatRate(id){
	
                                        if(!isNumber($('#'+id).val())){
                                            return 0;
                                        }
                                        else{
                                            return parseFloat($('#'+id).val());
                                        }
                                    }
                                    function clearOpenRate(){
                                        $("#room").val(0.0);
                                        $("#service").val(0.0);
                                        $("#tax").val(0.0);
                                        $("#extraBed").val(0.0);
                                        $("#extraBedService").val(0.0);
                                        $("#extraBedTax").val(0.0);
                                        $("#abf").val(0.0);
                                        $("#lunch").val(0.0);
                                        $("#dinner").val(0.0);
                                        $("#discount").val(0.0);
                                        $("#total").val(0.0);
                                    }
                                    function isNumber(num) {
                                        return (typeof num == 'string' || typeof num == 'number') && !isNaN(num - 0) && num !== '';
                                    }
                                    function parseFloatRate(id){
	
                                        if(!isNumber($('#'+id).val())){
                                            return 0;
                                        }
                                        else{
                                            return parseFloat($('#'+id).val());
                                        }
                                    }
                                    function openRate(c){
                                        if(c.checked){
                                            $(".openrate").removeClass("disabled").removeAttr("readonly"); 
                                            $("#rateCodeBt").addClass("disabled").attr("disabled","");
                                            $("#rateCode").val("OPN");
                                            
                                        }
                                        else{
                                            $(".openrate").addClass("disabled").attr("readonly","");
                                            $("#rateCodeBt").removeClass("disabled").removeAttr("disabled");
                                            $("#rateCode").val("");
                                            clearOpenRate();
                                        }
                                    }
                                </script>
                                <div class="span5">
                                    <div class="alert-message block-message info">

                                        <div class="clearfix">
                                            <label>Room</label>
                                            <div class="input">
                                                <input type="text" name="room" id="room"
                                                       class="span2 openrate"  />
                                            </div>

                                        </div>
                                        <div class="clearfix">
                                            <label>Service</label>
                                            <div class="input">
                                                <input type="text" name="service" id="service"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Tax</label>
                                            <div class="input">
                                                <input type="text" name="tax" id="tax"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Room</label>
                                            <div class="input">
                                                <input type="text" name="extraBed" id="extraBed"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Service</label>
                                            <div class="input">
                                                <input type="text" name="extraBedService" id="extraBedService"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Tax</label>
                                            <div class="input">
                                                <input type="text" name="extraBedTax" id="extraBedTax"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>ABF</label>
                                            <div class="input">
                                                <input type="text" name="abf" id="abf"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Lunch</label>
                                            <div class="input">
                                                <input type="text" name="lunch" id="lunch"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Dinner</label>
                                            <div class="input">
                                                <input type="text" name="dinner" id="dinner"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Discount</label>
                                            <div class="input">
                                                <div class="inline-inputs">
                                                    <input type="text" name="discount" id="discount"
                                                           class="span2 openrate" />
                                                    By <input type="text" name="discountBy" class="span2"/>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label><strong>Total</strong></label>
                                            <div class="input">
                                                <input type="text" name="total" id="total"
                                                       class="span2 openrate" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <%

                                } catch (SQLException e) {
                                    errorList.add(e.getMessage());
                                    throw e;
                                } finally {
                                    preparedStatementSelect.close();
                                    if (dbConnection != null) {
                                        dbConnection.close();
                                    }
                                }
                            %>
                        </fieldset>
                        <div class="actions">
                            <input type="submit" value="Check In" class="btn primary offset-two-thirds" >
                        </div>
                    </form>
                    <script type="text/javascript">
                            
                    </script>
                </div>
            </div>
        </div>
    </body>
</html>
