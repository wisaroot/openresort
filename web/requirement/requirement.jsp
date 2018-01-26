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
                var index=$('input[name=requirementCheck]:checked').index('input[name=requirementCheck]');
		var value=$('input[name=requirementCheck]:checked').val();
                var p=window.opener;
                p.$('#requirement').val(value);
                p.$('#requirementName').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(1)').html());
                p.$('#department').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(2)').html());
                p.$('#amount').val($('#tbRateCode tbody tr:eq('+(index)+') td:eq(3)').html());
              
                       p.$("#charge").attr("checked","checked");
                      
                 
                var chgType=$('input[name=requirementCheck]:checked').closest("tr").find("input[name=chargeType]").val();
                
                p.$.each(p.$("input[name=chgType]"),function(o){
                    
                    if(p.$("#chgType"+(o)).val()==chgType && chgType!=""){
                        p.$("#chgType"+(o)).attr('checked','checked');
                        return false;
                    }
                });
                p.changePeriod(chgType);
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
                                        <th>Name</th>     
                                        <th>Dept no</th>
                                        <th>Amount</th>
                                        <th>Charge type</th>
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
                                String selectSQL="SELECT rq_reqno, \"name\", rq_deptno, rq_amount, rq_chargetype, case when rq_chargetype='D' then 'Charge daily except arrival' else case when rq_chargetype='R' then 'Charge daily except departure (charge with room)' else case when rq_chargetype='O' then 'Charge once on first day (arrival)' else case when rq_chargetype='L' then 'Charge once on last day (departure)' else '' end end end end as rq_chargetypename FROM requirement "+(query!=null?" where \"name\" ilike ('%"+query+"%')":"")+" order by rq_reqno asc limit "+pgLimit+" offset "+((iPg-1)*pgLimit);
                                String maxRateSQL="select count(*) from requirement"+(query!=null?" where \"name\" ilike ('%"+query+"%')":"");
                                try{
                                    dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                                    preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                                    
                                    ResultSet rs=preparedStatementSelect.executeQuery();

                                    while(rs.next()){ %>
                                        <tr>
                                            <td><input type="radio" value="<%=rs.getString(1)%>" name="requirementCheck" onclick="chooseRate()"/></td>
                                            <td><%=rs.getString(2)%></td>
                                            <td><%=rs.getString(3)%></td>
                                            <td><%=rs.getString(4)%></td>
                                            <td><input type="hidden" name="chargeType" value="<%=rs.getString(5)%>" /><%=rs.getString(6)%></td>
                                            
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
                                <tr><td colspan="3">
                            <div class="pagination">
                                
                                <ul>
                                <li class="prev <% if(pg==null||pg.equals("1")){%> disabled<%}%>"><a href="<%=request.getContextPath()+"/requirement/requirement.jsp?pg="+(pg!=null?Integer.parseInt(pg)-1:"1")+(query!=null?"&q="+query:"")%>">&larr; Previous</a></li>
                                <%  
                                    
                                    int start=minPg+(iPg%pgInterval>0&&iPg<pgInterval?(pgInterval*(iPg/pgInterval)):(iPg%pgInterval>0&&iPg>pgInterval?pgInterval*(iPg/pgInterval):pgInterval*((iPg/pgInterval)-1)));
                                    int end=start+pgInterval;
                                    if(end>maxPg)end=maxPg+1;
                                    for(int i=start;i<end;i++){
                                %>
                                <li class="<% if(i==iPg){%>active<% } %>"><a href="<%=request.getContextPath()+"/requirement/requirement.jsp?pg="+i+(query!=null?"&q="+query:"")%>"><%=i%></a></li>
                                <%
                                    }
                                %>
                                <li class="next <% if(iPg>=maxPg){%> disabled <% } %>"><a href="<%=request.getContextPath()+"/requirement/requirement.jsp?pg="+(pg!=null?Integer.parseInt(pg)+1:"2")+(query!=null?"&q="+query:"")%>">Next &rarr;</a></li>
                                </ul>
                            </div></td>
                            <td colspan="3">
                                <div style="height:36px;margin:18px 0;"><ul style="float:left;margin:0;"><li style="display:inline;">
                                <form action="<%=request.getContextPath() + "/requirement/requirement.jsp"%>">
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
