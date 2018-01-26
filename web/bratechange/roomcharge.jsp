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
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Charge</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript">
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
            function isNumber(num) {
                return (typeof num == 'string' || typeof num == 'number') && !isNaN(num - 0) && num !== '';
            }
            function dateDiff(startDate, endDate) {
                // set startDate to the beginning of the day
                var end=Date.parse(endDate);
                var start=Date.parse(startDate);
                var millisecondsPerDay = 1000 * 60 * 60 * 24;
                var millisBetween = end-start;
                var days = millisBetween / millisecondsPerDay;

                // Round down.
                return Math.floor(days);
            }
            function clearDateRates(dlist){
                dlist.remove();
            }
            function createDateRates(start,end,dlist){
                
                var millisecondsPerDay = 1000 * 60 * 60 * 24;
                var startDate=Date.parse(start);
                for(var i=0;i<=dateDiff(start,end);i++){
                    var d = new Date(startDate+(millisecondsPerDay*(i)));
                    var date=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
                    var name=date;
                    var value=date;
                    dlist.append(new Option(name, value));
		
                }
            }
            function loadRoomChargeSchedule(rd,acc,seq){
                $.getJSON('roomcharge_1.jsp?bd='+rd+'&acc='+acc+'&seq='+seq, function(data) {
                    
                    $.each(data, function(key, val) {
                        
                        $('#'+key).val(val);
                        
                    });
                    
                });
	
            }
            function saveRoomChargeSchedule(key){
                var roomChargeSchedule = $('#bRateChange').serialize();
                $.post("roomcharge_2.jsp", roomChargeSchedule, function(data) {if(data=='failed'){alert("Unable to save: "+key);}});
            }
            $(document).ready(function(){
                clearDateRates($('#days option'));
                //use jsp define date for testing
            <%
                String acc = (String)request.getParameter("acc");
                String arrival = (String)request.getParameter("arr");
                String departure = (String)request.getParameter("dep");
                String seq = (String)request.getParameter("seq");
            %>
                    createDateRates('<%=arrival%>','<%=departure%>',$('#days'));
                    var isFirst=false;
                    var key="";
                    $('.openrate').bind('change',function(){
                        sumRate();
                    });
                    $('#days').bind('click',function(){
                        if(!isFirst){
                            key=$('#days :selected').val();
                            $('#cDate').html(key);
                            $('#chgDate').val(key);
                            loadRoomChargeSchedule(key,'<%=acc%>','<%=seq%>');
	        		
                            isFirst=true;
                        }else{
                            saveRoomChargeSchedule(key);
                            key=$('#days :selected').val();
                            $('#cDate').html(key);
                            $('#chgDate').val(key);
                            loadRoomChargeSchedule(key,'<%=acc%>','<%=seq%>');
	        		
                        }
                    });
                });
            
        </script>
    </head>
    
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Room Charge</h1>
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

                    <div class="span3 columns offset2">

                        <select id="days" multiple="multiple" size="10" class="span3">
                        </select>

                    </div>

                    <form id="bRateChange" method="post" action="">
                        <fieldset>
                            <div class="span5 columns">
                                <div class="alert-message block-message info">
                                    <p><strong><span id="cDate">&nbsp;</span></strong><input type="hidden" id="chgDate" name="chgDate" /></p>
                                    <input type="hidden" name="accountId" value="<%=acc%>"/>
                                    <div class="clearfix">
                                        <label>Rate Code</label>
                                        <div class="input">
                                            <input type="text" name="rateCode" value="OPN"
                                                   class="span2" readonly/>
                                            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Room</label>
                                        <div class="input">
                                            <input type="text" name="room" id="room"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Service</label>
                                        <div class="input">
                                            <input type="text" name="service" id="service"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Tax</label>
                                        <div class="input">
                                            <input type="text" name="tax" id="tax"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Extra Bed</label>
                                        <div class="input">
                                            <input type="text" name="extraBed" id="extraBed"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Extra Bed - Service</label>
                                        <div class="input">
                                            <input type="text" name="extraBedService" id="extraBedService"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="span5">
                                <div class="alert-message block-message info">
                                    <div class="clearfix">
                                        <label>Extra Bed - Tax</label>
                                        <div class="input">
                                            <input type="text" name="extraBedTax" id="extraBedTax"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>ABF</label>
                                        <div class="input">
                                            <input type="text" name="abf" id="abf"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Lunch</label>
                                        <div class="input">
                                            <input type="text" name="lunch" id="lunch"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Dinner</label>
                                        <div class="input">
                                            <input type="text" name="dinner" id="dinner"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Discount</label>
                                        <div class="input">
                                            <input type="text" name="discount" id="discount"
                                                   class="span2 openrate" value="0"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Total</label>
                                        <div class="input">
                                            <input type="text" name="total" id="total"
                                                   class="span2" value="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="actions">
                            <button class="btn primary offset-two-thirds" onclick="self.close()">Close</button>
                        </div>
                    </form>

                </div>
            </div>
    </body>
</html>
