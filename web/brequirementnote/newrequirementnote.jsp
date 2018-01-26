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
  
<%@page import="com.comis.frontsystem.guest.Guest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file="../guest/editguest_1.jsp" %>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Requirement Note</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/flick/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
		$("#fromDate").datepicker({dateFormat : 'yy-mm-dd'});
               $("#endDate").datepicker({dateFormat : 'yy-mm-dd'});
            });
        </script>
    </head>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Requirement Note</h1>
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

                    %>
                    <script type="text/javascript">
                        $(document).ready(function(){requirementClick();});
                        function requirementClick(){
                            $("#requirement").val($('input[name=rCheck]:checked').val());
                            $("#department").val($('input[name=rCheck]:checked').closest("tr").find("input[name=depId]").val());
                            $("#requirementName").val($('input[name=rCheck]:checked').closest("tr").find("span[name=rName]").text());
                            $("#amount").val($('input[name=rCheck]:checked').closest("tr").find("span[name=rAmount]").text());
                            $("#fromDate").val($('input[name=rCheck]:checked').closest("tr").find("span[name=rfDate]").text());
                            $("#endDate").val($('input[name=rCheck]:checked').closest("tr").find("span[name=reDate]").text());
                            $("#eventTime").val($('input[name=rCheck]:checked').closest("tr").find("input[name=reTime]").val());
                            $("#remark").val($('input[name=rCheck]:checked').closest("tr").find("input[name=rem]").val())
                            var rfcId=$('input[name=rCheck]:checked').closest("tr").find("span[name=rfcId]").text();
                            if(rfcId=="Y")
                                $("#charge").attr("checked","checked");
                            else
                                $("#charge").removeAttr("checked");
                            var chgId=$('input[name=rCheck]:checked').closest("tr").find("input[name=chgId]").val();
                
                            $.each($("input[name=chgType]"),function(o){
                    
                                if($("#chgType"+(o)).val()==chgId && chgId!=""){
                                    $("#chgType"+(o)).attr('checked','checked');
                                    return false;
                                }
                            });
                            changePeriod(chgId);
                        }
                        function changePeriod(chgType){
                            $('#fromDate').val('');
                            $('#endDate').val('');
                            var millisecondsPerDay = 1000 * 60 * 60 * 24;
                            var endDate;
                            var startDate;
                            if($('#rCheck').is(':checked')){
                                startDate=Date.parse($('input[name=rCheck]:checked').closest("tr").find("span[name=rfDate]").text());
                                endDate=Date.parse($('input[name=rCheck]:checked').closest("tr").find("span[name=reDate]").text());
                            }else{
                                startDate=Date.parse('<%=guest.getArrival()%>');
                                endDate=Date.parse('<%=guest.getDeparture()%>');
                            }
                            
                            if(chgType=='D'){
                                var d = new Date(startDate+(millisecondsPerDay*(1)));
                                $('#fromDate').val(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate());
                                $('#endDate').val('<%=guest.getDeparture()%>');
                            }else if(chgType=='R'){
                                var d = new Date(endDate-(millisecondsPerDay*(1)));
                                $('#fromDate').val('<%=guest.getArrival()%>');
                                $('#endDate').val(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate());
                            } else if(chgType=='O'){
                                $('#fromDate').val('<%=guest.getArrival()%>');
                                $('#endDate').val('<%=guest.getArrival()%>');
                            }else if(chgType=='L'){
                                $('#fromDate').val('<%=guest.getDeparture()%>');
                                 $('#endDate').val('<%=guest.getDeparture()%>');
                            }else{
                                $('#fromDate').val('');
                                $('#endDate').val('');
                            }
                        }
                        
                    </script>
                    <!-- content here -->
                    <div class="row">
                        <div class="span14 offset2">
                            <table>
                                <colgroup>
                                    <col style="width: 25px;">
                                    <col style="width: 150px;">
                                    <col style="width: 50px;">
                                    <col style="width: 50px;">
                                    <col style="width: 25px;">
                                    <col style="width: 100px;">
                                    <col style="width: 50px;">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th class="blue header">Description</th>
                                        <th class="blue header">From</th>
                                        <th class="blue header">End</th>
                                        <th class="blue header">Charge</th>
                                        <th class="blue header">Amount</th>
                                        <th class="blue header">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        boolean isFirst=true;
                                        preparedStatementSelect = dbConnection.prepareStatement("SELECT   brequire.brq_accno,   brequire.brq_reqno,   requirement.\"name\",   brequire.brq_fromdate,   brequire.brq_eventtime,   brequire.brq_enddate,   brequire.brq_chargeflag,   brequire.brq_deptno,   department.d_name,   brequire.brq_amount,   brequire.brq_chargetype,   brequire.brq_remark FROM   public.brequire,   public.requirement,   public.department WHERE   brequire.brq_reqno = requirement.rq_reqno AND  brequire.brq_deptno = department.d_id AND brq_accno=?;");
                                        preparedStatementSelect.setInt(1, Converter.parseInt(request.getParameter("acc")));
                                        ResultSet rs = preparedStatementSelect.executeQuery();
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><input type="radio" name="rCheck" id="rCheck" value="<%=rs.getString(2)%>" onclick="requirementClick()" <%=(isFirst?"checked=\"checked\"":"")%>/><label for="rCheck" style="width:25px;">&nbsp;</label></td>
                                        <td><input type="hidden" name="depId" value="<%=rs.getString(8)%>"><span name="rName"><%=rs.getString(9)%></span></td>
                                        <td><span name="rfDate"><%=rs.getString(4)%></span></td>
                                        <td><span name="reDate"><%=rs.getString(6)%></span><input type="hidden" name="reTime" value="<%=(rs.getString(5) == null ? "" : rs.getString(5))%>" /></td>
                                        <td><input type="hidden" name="chgId" value="<%=rs.getString(11)%>"/><span name="rfcId"><%=rs.getString(7)%></span></td>
                                        <td><span name="rAmount"><%=rs.getString(10)%></span><input type="hidden" name="rem" value="<%=rs.getString(12)%>"></td>
                                        <td><a href="newrequirementnote_2.jsp?req=<%=rs.getString(2)%>&from=<%=rs.getString(4)%>&acc=<%=rs.getString(1)%>" class="btn info">-</a></td>
                                    </tr>
                                    <%
                                             if(isFirst)isFirst=false;
                                        }
                                    %> 
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <form method="post" action="newrequirementnote_1.jsp">
                        <fieldset>

                            <div class="row">
                                <div class="span15 offset1">
                                    <div class="clearfix">
                                        <label>Requirement</label>
                                        <div class="input">
                                            <input type="hidden" name="accountId" id="accountId" value="<%=guest.getAccountId()%>"/>
                                            <input type="hidden" name="requirement" id="requirement"/>
                                            <input type="hidden" name="department" id="department"/>
                                            <input type="text" class="span3" name="requirementName" id="requirementName"/>&nbsp;<button class="btn info" onclick="window.open('../requirement/requirement.jsp', '_blank', 'height=700, width=1000');return false;">...</button>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label><input type="checkbox" value="Y" name="charge" id="charge"/></label>
                                        <div class="input">
                                            <ul class="inputs-list">
                                                <li><label><span>Charge ?</span> </label></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label>Amount</label>
                                        <div class="input">
                                            <input type="text" class="span2" name="amount" id="amount"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label id="optionsRadio">Requirement Type</label>
                                        <div class="input">
                                            <ul class="inputs-list">
                                                <li><label> <input type="radio" name="chgType" id="chgType0" onclick="changePeriod(this.value)"
                                                                   value="D" /> <span>Daily, exclude arrival</span>
                                                    </label></li>
                                                <li><label> <input type="radio" name="chgType" id="chgType1" onclick="changePeriod(this.value)"
                                                                   value="R" /> <span>Daily, exclude departure</span>
                                                    </label></li>
                                                <li><label> <input type="radio" name="chgType" id="chgType2" onclick="changePeriod(this.value)"
                                                                   value="O" /> <span>Once, on arrival</span>
                                                    </label></li>
                                                <li><label> <input type="radio" name="chgType" id="chgType3" onclick="changePeriod(this.value)"
                                                                   value="L" /> <span>Once, on departure</span>
                                                    </label></li>
                                                <li><label> <input type="radio" name="chgType" id="chgType4" onclick="changePeriod(this.value)"
                                                                   value="C" /> <span>Custom period</span>
                                                    </label></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label path="fromDate">Period</label>
                                        <div class="input">
                                            <div class="inline-inputs">
                                                <input type="text" name="fromDate" id="fromDate" class="span2" />
                                                to
                                                <input type="text" name="endDate" id="endDate" class="span2" />
                                                &nbsp;
                                                <input type="text" name="eventTime" id="eventTime" class="span2" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label path="remark">Remark</label>
                                        <div class="input">
                                            <textarea name="remark" rows="3" id="remark" class="span6"></textarea>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <label path="note">Note</label>
                                        <div class="input">
                                            <textarea name="note" rows="3" id="note" class="span6" ><%
                                                preparedStatementSelect = dbConnection.prepareStatement("SELECT bn_note FROM bnote where bn_accno=?;");
                                                preparedStatementSelect.setInt(1, Converter.parseInt(request.getParameter("acc")));
                                                rs = preparedStatementSelect.executeQuery();
                                                while (rs.next()) {
                                            %><%=rs.getString(1)%><%                                                
                                                }
                                            %></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="actions">
                                <input type="submit" class="btn primary" value="Save Changes" />
                                <a class="btn info" href="<%=request.getContextPath()%>/booking/bookingdetails.jsp?acc=<%=(String) request.getParameter("acc")%>">Skip</a>
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
                </div>
            </div>
        </div>
    </body>
</html>