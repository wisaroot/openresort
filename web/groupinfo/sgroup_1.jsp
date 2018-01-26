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
<%@page import="com.comis.frontsystem.groupinfo.GroupInfo"%>
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
<%
    List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());

%>	

<!-- content here -->
<%
    int minPg = 1;
    int maxPg = 10;
    int pgInterval = 10;
    int pgLimit = 5;
    String pg = (String) request.getParameter("pg");
    if (pg == null) {
        pg = "1";
    }
    int iPg = Integer.parseInt(pg);
%>
<table class="zebra-striped" >
    <thead>
        <tr>
            <th class="blue header">ACC#</th>
            <th class="blue header">CFM#</th>
            <th class="blue header">STAT</th>
            <th class="blue header">Group</th>
            <th class="blue header">Arrival</th>
            <th class="blue header">Departure</th>
            <th class="blue header">Agent</th>
            <th class="blue header">Nationality</th>
            <th class="blue header">Company</th>
            <th class="blue header">BKK</th>
            <th class="blue header">C/I</th>
        </tr>
    </thead>
    <tbody>
        <%
            GroupInfo groupInfo = (GroupInfo) session.getAttribute("groupinfo" + session.getId());
            
            errorList = (ArrayList) session.getAttribute("errors" + session.getId());
            errorList = new ArrayList<String>();
            session.setAttribute("errors" + session.getId(), errorList);
            Connection dbConnection = null;
            PreparedStatement preparedStatementSelect = null;
            String data=extractData(groupInfo);
            String selectSQL = "SELECT   gaccount.ga_accno,   gaccount.ga_acctype,   gaccount.ga_accstat,   gaccount.ga_walkin,   gaccount.ga_arrival,   gaccount.ga_departure,   gaccount.ga_agentno,   groupinfo.gri_natno,   groupinfo.gri_company,   booking.b_seq,   booking.b_qty,   booking.b_inhqty,   groupinfo.gri_grpname,   gfolio.gf_folno,bcf_cfmno FROM   public.gaccount left join public.booking on ga_accno=b_accno left join  public.groupinfo on ga_grpno=gri_grpno left join  public.gfolio on gf_accno=ga_accno and gf_bkaccno=b_accno and gf_bookseq=b_seq left join public.bconfirm on bcf_accno=ga_accno "+(data.equals("")?"WHERE ":data+" AND ")+"  ga_acctype='G' " + " order by ga_accno asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);
            String maxRateSQL = "SELECT  count(*) FROM   public.gaccount left join public.booking on ga_accno=b_accno left join  public.groupinfo on ga_grpno=gri_grpno left join  public.gfolio on gf_accno=ga_accno and gf_bkaccno=b_accno and gf_bookseq=b_seq "+(data.equals("")?"WHERE ":data+" AND ")+" ga_acctype='G'";
            System.out.println(selectSQL);
            try {
                
                dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                
                
 
                ResultSet rs = preparedStatementSelect.executeQuery();

                while (rs.next()) {%>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(15)%></td>
            <td><%=rs.getString(3)%></td>
           
            <td><%=rs.getString(13)%></td>

            <td><%=rs.getString(5)%></td>

            <td><%=rs.getString(6)%></td>
            <td><%=rs.getString(7)%></td>
            <td><%=rs.getString(8)%></td>
            <td><%=rs.getString(9)%></td>
            <td><%=rs.getString(11)%></td>
            <td><a href='<%=request.getContextPath()+"/grcheckin/checkin.jsp?acc="+rs.getString(1)+"&dtl="+rs.getString(10) %>' class="btn info"><%=rs.getString(12)%></a></td>
        </tr>
        <%
                }
                preparedStatementSelect = dbConnection.prepareStatement(maxRateSQL);
                
                rs = preparedStatementSelect.executeQuery();

                while (rs.next()) {
                    maxPg = (rs.getInt(1) / pgLimit) + (rs.getInt(1) % pgLimit > 0 ? 1 : 0);
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
    <tfoot>
        <tr>
            <td colspan="18">
                <div class="pagination">

                    <ul>
                        <li class="prev <% if (pg == null || pg.equals("1")) {%> disabled<%}%>"><a href="<%=request.getContextPath() + "/grcheckin/group_1.jsp?pg=" + (pg != null ? Integer.parseInt(pg) - 1 : "1")%>">&larr; Previous</a></li>
                        <%

                            int start = minPg + (iPg % pgInterval > 0 && iPg < pgInterval ? (pgInterval * (iPg / pgInterval)) : (iPg % pgInterval > 0 && iPg > pgInterval ? pgInterval * (iPg / pgInterval) : pgInterval * ((iPg / pgInterval) - 1)));
                            int end = start + pgInterval;
                            if (end > maxPg) {
                                end = maxPg + 1;
                            }
                            for (int i = start; i < end; i++) {
                        %>
                        <li class="<% if (i == iPg) {%>active<% }%>"><a href="<%=request.getContextPath() + "/grcheckin/group_1.jsp?pg=" + i%>"><%=i%></a></li>
                        <%
                            }
                        %>
                        <li class="next <% if (iPg >= maxPg) {%> disabled <% }%>"><a href="<%=request.getContextPath() + "/grcheckin/group_1.jsp?pg=" + (pg != null ? Integer.parseInt(pg) + 1 : "2")%>">Next &rarr;</a></li>
                    </ul>
                </div>
            </td>

        </tr>
    </tfoot>
</table>
<%!
    public String extractData(GroupInfo groupInfo) {
        String data = "";
        
        if (!Converter.isEmpty(groupInfo.getNationality())) {
            data+=extractStringField(data, "gri_natno",groupInfo.getNationality());
        }
        if (!Converter.isEmpty(groupInfo.getArrival())) {
            data+=extractDateField(data, "ga_arrival",groupInfo.getArrival());
        }
        if (!Converter.isEmpty(groupInfo.getDeparture())) {
            data+=extractDateField(data, "ga_departure",groupInfo.getDeparture());
        }
        if (!Converter.isEmpty(groupInfo.getCompany())) {
            data+=extractStringField(data, "gri_company",groupInfo.getCompany());
        }
        if (!Converter.isEmpty(groupInfo.getAgent())) {
            data+=extractIntegerField(data, "ga_agentno",groupInfo.getAgent());
        }
        if (!Converter.isEmpty(groupInfo.getName())) {
            data+=extractStringField(data, "gri_grpname",groupInfo.getName());
        }
        if (!Converter.isEmpty(groupInfo.getAccountId())) {
            data+=extractIntegerField(data, "ga_accno",groupInfo.getAccountId());
        }
        if (!Converter.isEmpty(groupInfo.getConfirmNo())) {
            data+=extractIntegerField(data, "bcf_cfmno",groupInfo.getConfirmNo());
        }
        return data;
    }

    public String extractStringField(String data, String fieldName,String value) {
        if (data.equals("")) {
            data = " WHERE lower(" + fieldName + ") like lower('"+value+"%') ";
        } else {
            data = " AND lower(" + fieldName + ") like lower('"+value+"%') ";
        }
        return data;
    }

    public String extractIntegerField(String data, String fieldName,String value) {
        if (data.equals("")) {
            data = " WHERE " + fieldName + " = "+value+" ";
        } else {
            data = " AND " + fieldName + " = "+value+" ";
        }
        return data;
    }

    public String extractDateField(String data, String fieldName,String value) {
        if (data.equals("")) {
            data = " WHERE " + fieldName + " = '"+value+"' ";
        } else {
            data = " AND " + fieldName + " = '"+value+"' ";
        }
        return data;
    }
%>                                   
