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
<%@page import="com.comis.frontsystem.guest.Guest"%>
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
        <title>Booking Details</title>

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
                if(!$("input[name='compliment']").is(':checked'))
                    $("form").append("<input type=\"hidden\" name=\"compliment\" id=\"c2\" value=\"n\"/>");
                $("input[name='compliment']").click(function(){
                    if($("input[name='compliment']").is(':checked')){
                        $("#c2").remove();
                    }else{
                        $("form").append("<input type=\"hidden\" name=\"compliment\" id=\"c2\" value=\"n\"/>");
                    }
                });
                $("input[name='adult']").val("0");
                $("input[name='child']").val("0");
                $("input[name='qty']").val("0");
                $("input[name='allotQty']").val("0");
        });
        function validate(){
            var adult=$("input[name='adult']").val();
            var child=$("input[name='child']").val();
            var qty=$("input[name='qty']").val();
            var allot=$("input[name='allotQty']").val();
            var patt=/\D/g;
            var pass=true;
            
            if(adult.length==0||patt.test(adult)){
                $("input[name='adult']").val("0");
                pass =pass&&false;
            }
            if(child.length==0||patt.test(child)){
                $("input[name='child']").val("0");
                pass =pass&&false;
            }
            if(qty.length==0||patt.test(qty)||qty==0){
                $("input[name='qty']").val("1");
                pass =pass&&false;
            }
            if(allot.length==0||patt.test(allot)){
                $("input[name='allotQty']").val("0");
                pass =pass&&false;
            }
            return pass;
        }       
        </script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <%@ include file="../guest/editguest_1.jsp" %>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>New Booking Details</h1>
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
                        Guest guest = getGuest(user1, pw, url, driver,(String) request.getParameter("acc"), errorList);
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
                    <form  method="post" action="newbookingdetails_1.jsp" onsubmit="return validate()">
                        <fieldset>
                            <legend>Booking Details Form</legend>
                            <div class="row">
                                <div class="span6">
                                    <div class="clearfix">
                                        <label>Adult</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="adult"
                                                       class="span1" />&nbsp;
                                                Child <input type="text" name="child"
                                                             class="span1" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clearfix">
                                        <label>Qty</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="qty"
                                                       class="span1" />&nbsp;
                                                <%
                                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT (select a_name from agent where a_id=?) as a_name ,allotment.am_id,   allotment.am_dstart,   allotment.am_dend,   allotment.am_qty,   allotment.cutoff1 FROM   public.allotment WHERE   ag_id = ? AND   am_dstart <= ? AND (am_dend-cutoff1) >= ? ;");
                                                    preparedStatementSelect.setInt(1, Converter.parseInt(guest.getAgent()));
                                                    preparedStatementSelect.setInt(2, Converter.parseInt(guest.getAgent()));
                                                    preparedStatementSelect.setDate(3, Converter.parseSQLDate(guest.getArrival()));
                                                    preparedStatementSelect.setDate(4, Converter.parseSQLDate(guest.getDeparture()));
                                                    ResultSet rs = preparedStatementSelect.executeQuery();

                                                %>
                                                AllotQty <input type="text" name="allotQty"
                                                                class="span1" value="<% while (rs.next()) {
                                                                        out.print(rs.getString(5));
                                                                    }%>"/>

                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden"  name="acc" value="<%=guest.getAccountId()%>"/>
                                    <%
                                        preparedStatementSelect = dbConnection.prepareStatement("select case when (select count(b_seq) from booking where b_accno=?) =0 then 0 else (select b_seq+1 from booking where b_accno=? order by b_seq desc limit 1) end");
                                        preparedStatementSelect.setInt(1, Converter.parseInt(guest.getAccountId()));
                                        preparedStatementSelect.setInt(2, Converter.parseInt(guest.getAccountId()));
                                        rs = preparedStatementSelect.executeQuery();
                                        while (rs.next()) {
                                    %>
                                    <input type="hidden"  value="<%=rs.getString(1)%>" name="dtl"/>
                                    <%
                                        }
                                    %>        

                                    <div class="clearfix">
                                        <label>Arrival</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="arrival" id="arrival"
                                                       class="span2" value="<%=guest.getArrival()%>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Departure</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="departure" id="departure"
                                                       class="span2" value="<%=guest.getDeparture()%>" /> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Room Type</label>
                                        <div class="input">
                                            <select name="roomType" class="span3" >
                                                <%
                                                    preparedStatementSelect = dbConnection.prepareStatement("SELECT rt_id, rt_descr FROM roomtype;");
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
                                        <label>Bed Type</label>
                                        <div class="input">
                                            <select name="bedType" class="span3">
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
                                            <button class="btn info"  onclick="window.open('../blockroom/blockroom.jsp?acc='+acc.value+'&bt='+bedType.value+'&rt='+roomType.value+'&arr='+arrival.value+'&dep='+departure.value+'&qty='+qty.value+'&dtl='+dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
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
                                                <button class="btn info" onclick="window.open('../bratechange/roomcharge.jsp?acc='+acc.value+'&arr='+arrival.value+'&dep='+departure.value+'&seq='+dtl.value, '_blank', 'height=700, width=1000');return false;">...</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clearfix">
                                        <label><input type="checkbox" name="compliment" value="t"/> </label>
                                        <div class="input">
                                            <ul class="inputs-list">
                                                <li><label><span>Complimentary?</span></label></li>
                                            </ul>

                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Charge to</label>
                                        <div class="input">
                                            <select name="chargeTo" class="span3"><option value="B">Booking Account</option><option value="O">Own Account</option></select>
                                        </div>
                                    </div>

                                </div>
                                <!-- Rate Details -->

                                <script type="text/javascript">
                                $(document).ready(function(){
                                    $('.openrate').change(function(){
                                            
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
                                    });
                                    clearOpenRate();
                                });
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
                                            <label id="l" style="display: block;padding-left: 15px;text-indent: -15px;">
                                                <input type="checkbox" value="OPN" onclick="openRate(this)" style="width: 13px;height: 15px;padding: 0;margin:0;vertical-align: bottom;position: relative;top: -1px;overflow: hidden;">&nbsp;&nbsp;
                                                <strong>Open Rate?</strong>
                                            </label>
                                        </div>
                                        <div class="clearfix">
                                            <label>Room</label>
                                            <div class="input">
                                                <input type="text" name="room" id="room"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>

                                        </div>
                                        <div class="clearfix">
                                            <label>Service</label>
                                            <div class="input">
                                                <input type="text" name="service" id="service"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Tax</label>
                                            <div class="input">
                                                <input type="text" name="tax" id="tax"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Room</label>
                                            <div class="input">
                                                <input type="text" name="extraBed" id="extraBed"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Service</label>
                                            <div class="input">
                                                <input type="text" name="extraBedService" id="extraBedService"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Extra Bed - Tax</label>
                                            <div class="input">
                                                <input type="text" name="extraBedTax" id="extraBedTax"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>ABF</label>
                                            <div class="input">
                                                <input type="text" name="abf" id="abf"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Lunch</label>
                                            <div class="input">
                                                <input type="text" name="lunch" id="lunch"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Dinner</label>
                                            <div class="input">
                                                <input type="text" name="dinner" id="dinner"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Discount</label>
                                            <div class="input">
                                                <input type="text" name="discount" id="discount"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label><strong>Total</strong></label>
                                            <div class="input">
                                                <input type="text" name="total" id="total"
                                                       class="span2 openrate" readonly="true"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span5">
                                    <div class="alert-message block-message info">
                                        <%
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT (select a_name from agent where a_id=?) as a_name ,allotment.am_id,   allotment.am_dstart,   allotment.am_dend,   allotment.am_qty,   allotment.cutoff1 FROM   public.allotment WHERE   ag_id = ? AND   am_dstart <= ? AND (am_dend-cutoff1) >= ? ;");
                                            preparedStatementSelect.setInt(1, Converter.parseInt(guest.getAgent()));
                                            preparedStatementSelect.setInt(2, Converter.parseInt(guest.getAgent()));
                                            preparedStatementSelect.setDate(3, Converter.parseSQLDate(guest.getArrival()));
                                            preparedStatementSelect.setDate(4, Converter.parseSQLDate(guest.getDeparture()));
                                            rs = preparedStatementSelect.executeQuery();
                                            String agent="";
                                            String allotmentNo="";
                                            String start="";
                                            String end="";
                                            String cutoff="";
                                            while(rs.next()){
                                                agent=rs.getString(1);
                                                allotmentNo=rs.getString(2);
                                                start=rs.getString(3);
                                                end=rs.getString(4);
                                                cutoff=rs.getString(6);
                                            }
                                        %>


                                        <div class="clearfix">
                                            <label style="width:200px; text-align:left;">
                                                <strong>Allotment Availability</strong>
                                            </label>
                                        </div>
                                        <div class="clearfix">
                                            <label>Agent</label>
                                            <div class="input">
                                                <input type="text" name="agent" 
                                                       class="span2" value="<%=agent%>"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Allotment No.</label>
                                            <div class="input">
                                                <input type="text" name="allotmentId"
                                                       class="span2" value="<%=allotmentNo%>" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Start</label>
                                            <div class="input">
                                                <input type="text" name="allotmentStart" 
                                                       class="span2" value="<%=start%>" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>End</label>
                                            <div class="input">
                                                <input type="text" name="allotmentEnd"
                                                       class="span2" value="<%=end%>"/>
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                            <label>Cut off</label>
                                            <div class="input">
                                                <input type="text" name="allotmentCutoff"
                                                       class="span2" value="<%=cutoff%>"/>
                                            </div>
                                        </div>

                                    </div>
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
                        <div class="actions">
                            <input type="submit" value="Next" class="btn primary offset-two-thirds" >
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
