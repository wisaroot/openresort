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
<%@page import="com.comis.frontsystem.checkin.GFolio"%>
<%@page import="java.sql.SQLException"%>
 <%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Check In</title>
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
    <%@ include file="editcheckin_1.jsp" %>
    <%@ include file="newcheckin_1.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Edit Check In</h1>
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
                        GFolio gFolio = getGFolio(user1, pw, url, driver,(String) request.getParameter("gf"),  errorList);
                        BookingDetailsCK bookingDetails = getBookingDetails(user1, pw, url, driver,gFolio.getBookAccountId(), gFolio.getDtl(),gFolio.getBookAccountId(), errorList);
                        Connection dbConnection = null;
                        PreparedStatement preparedStatementSelect = null;


                        try {
                           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                    %>
                    
                    <div class="row">&nbsp;</div>
                    
                    <!-- content here -->
                    <form  method="post" action="editcheckin_2.jsp">
                        <fieldset>
                            <legend>Booking Details Form</legend>
                            <div class="row">
                                <div class="span6">
                                    <div class="clearfix">
                                        <a href="?bkacc=<%=request.getParameter("bkacc")%>&dtl=<%=request.getParameter("dtl")%>" class="btn info offset1 disabled">New Guest</a>
                                    </div>
                                    <div class="clearfix">
                                        <label>Adult</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="adult"
                                                       class="span1" value="<%=gFolio.getAdult()%>"/>&nbsp;
                                                Child <input type="text" name="child"
                                                             class="span1" value="<%=gFolio.getChild()%>"/>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <input type="hidden"  name="gFolioId" value="<%=request.getParameter("gf")%>"/>
                                    <input type="hidden"  name="acc" value="<%=gFolio.getAccountId()%>"/>
                                    <input type="hidden"  name="bkacc" value="<%=gFolio.getBookAccountId()%>"/>
                                    <input type="hidden"  value="<%=gFolio.getDtl()%>" name="dtl"/>
                                          

                                    <div class="clearfix">
                                        <label>Arrival</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="arrival" id="arrival"
                                                       class="span2" value="<%=bookingDetails.getArrival()%>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Departure</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="departure" id="departure"
                                                       class="span2" value="<%=bookingDetails.getDeparture()%>" /> 
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
                                                <option value="<%=rs.getString(1)%>" <%=(rs.getString(1).equals(gFolio.getRoomType())?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Bed Type</label>
                                        <div class="input">
                                            <select name="bedType" class="span3">
                                                <%
                                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT bt_id, bt_descr FROM bedtype;");
                                                    rs = preparedStatementSelect.executeQuery();
                                                    while (rs.next()) {
                                                %>
                                                <option value="<%=rs.getString(1)%>" <%=(rs.getString(1).equals(bookingDetails.getBedType())?"selected=\"selected\"":"")%>><%=rs.getString(2)%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Block Room</label>
                                        <div class="input">
                                            <input type="text" name="roomNo" id="roomNo" class="span2" value="<%=gFolio.getRoomNo()%>"/>
                                            <button class="btn info"  onclick="window.open('../blockroom/blockroom.jsp?acc='+acc.value+'&bt='+bedType.value+'&rt='+roomType.value+'&arr='+arrival.value+'&dep='+departure.value+'&dtl='+dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Rate</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="rateCode" id="rateCode" class="span2" value="<%=gFolio.getRateCode()%>"/>
                                                <button id="rateCodeBt" class="btn info" onclick="window.open('../ratecode/ratecode.jsp', '_blank', 'height=700, width=1000');return false;">...</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Room Charge Schedule</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <button class="btn info" onclick="window.open('../gratechange/roomcharge.jsp?acc='+acc.value+'&arr='+arrival.value+'&dep='+departure.value+'&seq='+dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clearfix">
                                        <label><input type="checkbox" name="compliment" value="t" <%=(gFolio.getCompliment().equalsIgnoreCase("t")?"checked=\"checked\"":"")%>/> </label>
                                        <div class="input">
                                            <ul class="inputs-list">
                                                <li><label><span>Complimentary?</span></label></li>
                                            </ul>

                                        </div>
                                    </div>
                                        <div class="clearfix">
                                        <label>Compliment By </label>
                                        <div class="input">
                                            <input type="text" name="compBy" class="span2" value="<%=gFolio.getCompBy()%>"/>
                                        </div>
                                    </div>
                                    

                                </div>
                                <!-- Rate Details -->

                                <script type="text/javascript">
                                    
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
                                            $("#rateCode").val("<%=gFolio.getRateCode()%>");
                                            
                                        }
                                        else{
                                            $(".openrate").addClass("disabled").attr("readonly","");
                                            $("#rateCodeBt").removeClass("disabled").removeAttr("disabled");
                                            $("#rateCode").val("<%=gFolio.getRateCode()%>");
                                            clearOpenRate();
                                        }
                                    }
                                </script>
                                <div class="span5">
                                    <div class="alert-message block-message info">
                                        <div class="clearfix">
                                            <label id="l" style="display: block;padding-left: 15px;text-indent: -15px;">
                                                <input type="checkbox" value="OPN" onclick="openRate(this)" style="width: 13px;height: 15px;padding: 0;margin:0;vertical-align: bottom;position: relative;top: -1px;overflow: hidden;" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"checked=\"checked\"":"")%>>&nbsp;&nbsp;
                                                <strong>Open Rate?</strong>
                                            </label>
                                        </div>
                                        <div class="clearfix">
                                            <label>Room</label>
                                            <div class="input">
                                                <input type="text" name="room" id="room"
                                                       class="span2 openrate" value="<%=gFolio.getRoom()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>

                                        </div>
                                        <div class="clearfix">
                                            <label>Service</label>
                                            <div class="input">
                                                <input type="text" name="service" id="service"
                                                       class="span2 openrate" value="<%=gFolio.getService()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Tax</label>
                                            <div class="input">
                                                <input type="text" name="tax" id="tax"
                                                       class="span2 openrate" value="<%=gFolio.getTax()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Room</label>
                                            <div class="input">
                                                <input type="text" name="extraBed" id="extraBed"
                                                       class="span2 openrate" value="<%=gFolio.getExtraBed()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Service</label>
                                            <div class="input">
                                                <input type="text" name="extraBedService" id="extraBedService"
                                                       class="span2 openrate" value="<%=gFolio.getExtraBedService()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Tax</label>
                                            <div class="input">
                                                <input type="text" name="extraBedTax" id="extraBedTax"
                                                       class="span2 openrate" value="<%=gFolio.getExtraBedTax()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>ABF</label>
                                            <div class="input">
                                                <input type="text" name="abf" id="abf"
                                                       class="span2 openrate" value="<%=gFolio.getAbf()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Lunch</label>
                                            <div class="input">
                                                <input type="text" name="lunch" id="lunch"
                                                       class="span2 openrate" value="<%=gFolio.getLunch()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Dinner</label>
                                            <div class="input">
                                                <input type="text" name="dinner" id="dinner"
                                                       class="span2 openrate" value="<%=gFolio.getDinner()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Discount</label>
                                            <div class="input">
                                                <div class="inline-inputs">
                                                    <input type="text" name="discount" id="discount"
                                                       class="span2 openrate" value="<%=gFolio.getDiscount()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
                                                    By <input type="text" name="discountBy" class="span2" value="<%=gFolio.getDiscountBy()%>"/>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label><strong>Total</strong></label>
                                            <div class="input">
                                                <input type="text" name="total" id="total"
                                                       class="span2 openrate" value="<%=gFolio.getTotal()%>" <%=(gFolio.getRateCode().equalsIgnoreCase("OPN")?"":"readonly=\"true\"")%>/>
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
                            <input type="submit" value="Re-Check In" class="btn primary offset-two-thirds" >
                        </div>
                    </form>
                    <script type="text/javascript">
                            
                    </script>
                </div>
            </div>
        </div>
    </body>
</html>
