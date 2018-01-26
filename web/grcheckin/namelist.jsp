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
        <title>Name List</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
    </head>
    <body>
           <script language = "javaScript">
            function valid_data()
            {

                if (document.aa.chk.checked == false) {
                    alert( 'Please select before checkin . ');
                    document.aa.chk.focus();
                    return false ;
                }
             
       
            }//end of function 

        </script>
        <div class="content">
            <div class="page-header offset1">
                <h1>Name List</h1>
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
                    <script type="text/javascript">
                        function checkAll(){
                            $("input[type='checkbox']").attr('checked',$('#chkAll').is(':checked'));
                        }
                        
                        $(document).ready(function(){
                            $("input[type='checkbox']").bind("click",function(){
                               
                                   if($(this).is(':checked')){
                                       var index=$('input[name=chk]:checked').index('input[name=chk]');
                                       $("#details").load($('#nameList tbody tr:eq('+(index)+')').attr("url"));
                                   }else{
                                       $("#details").empty();
                                   }
                            }); 
                        });
                        
                    </script>
                    <div class="span16">
                        <div class="row">
                            <form method="post" action="namelist_1.jsp" name="aa" >
                                <div class="span8">

                                    <table id="nameList">
                                        <thead>
                                            <tr>
                                                <th><input type="checkbox" id="chkAll" onclick="checkAll()"/></th>
                                                <th>#ACC</th>
                                                <th>#BookNo</th>
                                               
                                                <th>Room</th>
                                                <th>Name</th>
                                                <th>Type</th>
                                                <th>Rate</th>
                                                <th>Arrival</th>
                                                <th>Depart</th>
                                                 <th>N-Seq</th>
                                                 <th>Status</th>
                                                <th>Guest</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                
                                
                                
                                
                                Connection dbConnection = null;
                                PreparedStatement preparedStatementSelect = null;
                                String selectSQL = "SELECT nl_ownaccno,nl_accno, nl_dtlseq, nl_seq, nl_roomno,nl_fname||' ' || nl_mname||' ' || nl_lname as nl_name,nl_roomtypeno,nl_bedtypeno,nl_arrdate,nl_depdate,nl_rateno, nl_status,nl_roomno FROM namelist WHERE nl_status not in ('I','O') and nl_accno=? and nl_dtlseq=? order by nl_seq asc;";
                                
                                
                                try {
                                    
                                   dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                                    preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                                    preparedStatementSelect.setInt(1,Converter.parseInt((String)request.getParameter("bkacc")));
                                    preparedStatementSelect.setInt(2,Converter.parseInt((String)request.getParameter("dtl")));
                                    ResultSet rs = preparedStatementSelect.executeQuery();
                                    
                                    while (rs.next()) {

%>
                                            <tr url='newnamelist.jsp?acc=<%=(rs.getString(1)==null?"":rs.getString(1))%>&bkacc=<%=rs.getString(2)%>&dtl=<%=rs.getString(3)%>&seq=<%=rs.getString(4)%>&rateNo=<%=rs.getString(8)%>&roomNo=<%=(rs.getString(10)==null?"":rs.getString(10).trim())%>'>
                                                <td>
                                                    <input type="checkbox" name="chk"  value="<%=rs.getString(1)%>:<%=rs.getString(2)%>:<%=rs.getString(3)%>:<%=rs.getString(4)%>"/></td>
                                                <td><%=(Converter.isEmpty(rs.getString(1))?"":rs.getString(1))%></td>
                                                  <td><%=(Converter.isEmpty(rs.getString(2))?"":rs.getString(2))%></td>
                                                <td><%=(Converter.isEmpty(rs.getString(5))?"":rs.getString(5))%></td>
                                                <td><%=(Converter.isEmpty(rs.getString(6))?"":rs.getString(6))%></td>
                                                <td><%=(Converter.isEmpty(rs.getString(7))?"":rs.getString(7))%></td>
                                                <td><%=(Converter.isEmpty(rs.getString(8))?"":rs.getString(8))%></td>
                                                <td><%=(Converter.isEmpty(rs.getString(9))?"":rs.getString(9))%></td>
                                                 <td><%=(Converter.isEmpty(rs.getString(10))?"":rs.getString(10))%></td>
                                                  <td><%=(Converter.isEmpty(rs.getString(4))?"":rs.getString(4))%></td>
                                                   <td><%=(Converter.isEmpty(rs.getString(12))?"":rs.getString(12))%></td>
                                                
                                             <td>
                                                    <% 
                    if (rs.getString(1) == null  ) {
                %>
                   <a class="btn info" onclick="window.open('newguest.jsp?bkacc=<%=rs.getString(2)%>&dtl=<%=rs.getString(3)%>&seqq=<%=rs.getString(4)%>', '_blank', 'scrollbars=1,height=700, width=1000');return false;">...</a>
                                               <%
                }else if(rs.getString(1) != null && rs.getString(5) == null) { 
               %>
                 <div class="clearfix">
                                        <label>Block Room</label>
                                        <div class="input">
                                            <button class="btn info"  onclick="window.open('blockroom.jsp?acc=<%=rs.getString(2)%>&bt=<%=rs.getString(8)%>&rt=<%=rs.getString(7)%>&arr=<%=rs.getString(9)%>&dep=<%=rs.getString(10)%>&dtl=<%=rs.getString(3)%>&seq=<%=rs.getString(4)%>', '_blank', 'height=700, width=1000');return false;">...</button>
                                        </div>
                                    </div>
                <%
              
                    }  else  {
                        
                            %>
                            ...
                             <%        
                        }
                        %>
                                             </td>
                                            
                                            </tr>
                                            
                                        <%
                                                }
                                                

                                            } catch (SQLException e) {
                                                errorList.add(e.getMessage());
                                            } finally {
                                                preparedStatementSelect.close();
                                                if (dbConnection != null) {
                                                    dbConnection.close();
                                                }
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                    <div class="actions">
                                        <input type="hidden" name="bkacc" value="<%=(String) request.getParameter("bkacc")%>"/>
                                        <input type="hidden" name="dtl" value="<%=(String) request.getParameter("dtl")%>"/>
                                      
                                        <input type="submit" class="btn primary" value="Check In" onClick = "javascript:return valid_data();" />
                                    </div>
                                </div>
                            </form>
                            <div class="span8" id="details">
                                <!-- Load details -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
