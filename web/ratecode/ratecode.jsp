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
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.util.List,java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Front System</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript">
            function chooseRate(){
                var index=$('input[name=rateCheck]:checked').index('input[name=rateCheck]');
		var value=$('input[name=rateCheck]:checked').val();
                var p=window.opener;
                p.$('#rateCode').val(value);
                p.$('#room').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(2)').html());
                p.$('#service').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(3)').html());
                p.$('#tax').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(4)').html());
                p.$('#extraBed').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(5)').html());
                p.$('#extraBedService').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(6)').html());
                p.$('#extraBedTax').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(7)').html());
                p.$('#abf').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(8)').html());
                p.$('#lunch').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(9)').html());
                p.$('#dinner').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(10)').html());
                p.$('#discount').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(11)').html());
                p.$('#total').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(12)').html());
            }
        </script>
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body>
        

        <div class="container">

            <div class="content">
                <div class="row">
                    <div class="span16 columns">
                            <%
                                    int minPg=1;
                                    int maxPg=10;
                                    int pgInterval=10;
                                    int pgLimit=5;
                                    String pg=(String)request.getParameter("pg");
                                    if(pg==null)pg="1";
                                    int iPg=Integer.parseInt(pg);
                            %>
                            <table class="zebra-striped" id="tbRateCode">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Description</th>
                                        <th>Room</th>
                                        <th>Service</th>
                                        <th>Tax</th>
                                        <th>Extra Bed</th>
                                        <th>Extra Bed Service</th>
                                        <th>Extra Bed Tax</th>
                                        <th>Abf</th>
                                        <th>Lunch</th>
                                        <th>Dinner</th>
                                        <th>Discount</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                                String query=(String)request.getParameter("q");
                                List<String> errorList=(ArrayList)session.getAttribute("errors"+session.getId());
                                errorList=new ArrayList<String>();
                                session.setAttribute("errors"+session.getId(), errorList);
                                Connection dbConnection = null;
                                PreparedStatement preparedStatementSelect = null;
                                String selectSQL="SELECT rc_id, rc_descr, rc_room, rc_service, rc_tax, rc_extrabed, rc_extbedserv, rc_extbedtax, rc_abf, rc_lunch, rc_dinner, rc_discount, (rc_room+ rc_service+ rc_tax+ rc_extrabed+ rc_extbedserv+ rc_extbedtax+rc_abf+ rc_lunch+ rc_dinner- rc_discount) as total FROM ratecode"+(query!=null?" where rc_descr ilike ('%"+query+"%')":"")+" order by rc_id asc limit "+pgLimit+" offset "+((iPg-1)*pgLimit);
                                String maxRateSQL="select count(*) from ratecode"+(query!=null?" where rc_descr ilike ('%"+query+"%')":"");
                                try{
                                   dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                                    preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                                    
                                    ResultSet rs=preparedStatementSelect.executeQuery();

                                    while(rs.next()){ %>
                                        <tr>
                                            <td><input type="radio" value="<%=rs.getString(1)%>" name="rateCheck" onclick="chooseRate()"/></td>
                                            <td><%=rs.getString(2)%></td>
                                            <td><%=rs.getString(3)%></td>
                                            <td><%=rs.getString(4)%></td>
                                            <td><%=rs.getString(5)%></td>
                                            <td><%=rs.getString(6)%></td>
                                            <td><%=rs.getString(7)%></td>
                                            <td><%=rs.getString(8)%></td>
                                            <td><%=rs.getString(9)%></td>
                                            <td><%=rs.getString(10)%></td>
                                            <td><%=rs.getString(11)%></td>
                                            <td><%=rs.getString(12)%></td>
                                            <td><%=rs.getString(13)%></td>
                                        </tr>
                              <%
                                    }
                                    preparedStatementSelect = dbConnection.prepareStatement(maxRateSQL);
                                    
                                    rs=preparedStatementSelect.executeQuery();

                                    while(rs.next()){
                                        maxPg=(rs.getInt(1)/pgLimit)+(rs.getInt(1)%pgLimit>0?1:0);
                                    }
                                    
                                }catch(SQLException e){
                                    errorList.add(e.getMessage());
                                }finally{
                                    preparedStatementSelect.close();
                                    if(dbConnection!=null)
                                        dbConnection.close();
                                }
                            %>
                            </tbody>
                            <tfoot>
                                <tr><td colspan="9">
                            <div class="pagination">
                                
                                <ul>
                                <li class="prev <% if(pg==null||pg.equals("1")){%> disabled<%}%>"><a href="<%=request.getContextPath()+"/ratecode/ratecode.jsp?pg="+(pg!=null?Integer.parseInt(pg)-1:"1")+(query!=null?"&q="+query:"")%>">&larr; Previous</a></li>
                                <%  
                                    
                                    int start=minPg+(iPg%pgInterval>0&&iPg<pgInterval?(pgInterval*(iPg/pgInterval)):(iPg%pgInterval>0&&iPg>pgInterval?pgInterval*(iPg/pgInterval):pgInterval*((iPg/pgInterval)-1)));
                                    int end=start+pgInterval;
                                    if(end>maxPg)end=maxPg+1;
                                    for(int i=start;i<end;i++){
                                %>
                                <li class="<% if(i==iPg){%>active<% } %>"><a href="<%=request.getContextPath()+"/ratecode/ratecode.jsp?pg="+i+(query!=null?"&q="+query:"")%>"><%=i%></a></li>
                                <%
                                    }
                                %>
                                <li class="next <% if(iPg>=maxPg){%> disabled <% } %>"><a href="<%=request.getContextPath()+"/ratecode/ratecode.jsp?pg="+(pg!=null?Integer.parseInt(pg)+1:"2")+(query!=null?"&q="+query:"")%>">Next &rarr;</a></li>
                                </ul>
                            </div></td>
                            <td colspan="4">
                                <div style="height:36px;margin:18px 0;"><ul style="float:left;margin:0;"><li style="display:inline;">
                                <form action="<%=request.getContextPath() + "/ratecode/ratecode.jsp"%>">
                                    <div class="inline-inputs">
                                    <input type="text" name="q" value="" class="span3" />
                                    <button class="btn primary" type="submit">Search</button>
                                    </div>
                                </form></li></ul></div></td>
                            </tr>
                            </tfoot>
                            </table>
                           
		<% if(errorList!=null&&errorList.size()>0){ %>	
                        <div class="alert-message block-message error offset1">
                                <p>
                                        <%
                                            
                                            if(errorList!=null){
                                                for(String error:errorList){
                                                    out.println(error+"<br/>");
                                                }
                                                errorList = new ArrayList<String>();
                                                session.setAttribute("errors" + session.getId(), errorList);
                                            }
                                        %>
                                </p>
                        </div>
        
		<% } %>
                    <div class="actions">
                        <button class="btn primary offset-two-thirds" onclick="self.close()">Close</button>
                    </div>
                    </div>
                    
                </div>
                
            </div>
        </div>                            
    </body>
</html>
