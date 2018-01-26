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
<%@page import="com.comis.frontsystem.guestinfo.Individual1"%>
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
    int pgLimit = 10;
    String pg = (String) request.getParameter("pg");
    if (pg == null) {
        pg = "1";
    }
    int iPg = Integer.parseInt(pg);
%>
<table  class="zebra-striped" >
    <thead>

        <tr>
            <th class="blue header">ACC#</th>
            <th class="blue header">CFM#</th>
            <th class="blue header">RM#</th>
            <th class="blue header">STAT</th>
            <th class="blue header">Guest Name</th>
            <th class="blue header">Group</th>
            <th class="blue header">Arrival</th>
            <th class="blue header">Departure</th>
            <th class="blue header">Agent</th>
            <th class="blue header">Nationality</th>
            <th class="blue header">Company</th>

            <th class="blue header">C/I</th>
        </tr>
    </thead>
    <tbody>
        <%

            Individual1 individual = (Individual1) session.getAttribute("individual" + session.getId());
            //individual.
            errorList = (ArrayList) session.getAttribute("errors" + session.getId());
            errorList = new ArrayList<String>();
            session.setAttribute("errors" + session.getId(), errorList);
            Connection dbConnection = null;
            PreparedStatement preparedStatementSelect = null;
            String data = extractData(individual);
            String selectSQL = "select ga_accno, case when bcf_cfmno >0 then bcf_cfmno else 0 end , case when gf_roomno is not null then gf_roomno else '' end, ga_accstat,gn_fname||' '||gn_lname as guestname, case when (ga_grpno is not null and coalesce(ga_guestno,0) = 0) "
                    + "      then   gri_grpname   else ''  end ,ga_arrival,  ga_arrtime,ga_departure, "
                    + "    ga_deptime,case when a_name is not null then a_name else '' end ,n_descr,case when gi_company is not null then gi_company else '' end, "
                    + "      gf_folno,ga_walkin from gaccount left join   gfolio  on ga_accno=gf_accno   left join  BCONFIRM on ga_accno=bcf_accno   left join guestname "
                    + "      on guestname.gn_guestno=gaccount.ga_guestno "
                    + "   left join agent on a_id = ga_agentno left join groupinfo on gri_grpno = ga_grpno "
                    + "        left join   guestinfo on gi_guestno = ga_guestno left join nationality on  nationality.n_id=gi_natno  "
                    + "   where  " + data + "     GROUP BY gaccount.ga_accno,bconfirm.bcf_cfmno,gfolio.gf_roomno,gaccount.ga_accstat, "
                    + "    guestname.gn_fname,guestname.gn_lname ,gaccount.ga_grpno,gaccount.ga_guestno,groupinfo.gri_grpname, "
                    + "    gaccount.ga_arrival,gaccount.ga_arrtime,gaccount.ga_departure,gaccount.ga_deptime,agent.a_name,nationality.n_descr,guestinfo.gi_company, "
                    + "      gfolio.gf_folno,gaccount.ga_acctype,gaccount.ga_walkin  order by ga_accno asc  limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);

            /*         String selectSQL = "  select ga_accno,bcf_cfmno,gf_roomno,ga_accstat,gn_fname||' '||gn_lname as guestname, case when (ga_grpno is not null and coalesce(ga_guestno,0) = 0) "
            + "    then   gri_grpname   else null  end,ga_arrival,  ga_arrtime,ga_departure, "
            + "   ga_deptime,a_name,n_descr,gi_company,b_qty,b_inhqty,b_seq+1 as b_seq, "
            + " gf_folno,b_accno,ga_acctype,ga_walkin from gaccount left join booking on ga_accno=b_accno left join  BCONFIRM on b_accno=bcf_accno left join gfolio on gf_accno=ga_accno  left join guestname "
            + "on guestname.gn_guestno=gaccount.ga_guestno "
            + " left join agent on a_id = ga_agentno left join groupinfo on gri_grpno = ga_grpno"
            + " left join   guestinfo on gi_guestno = ga_guestno left join nationality on  nationality.n_id=gi_natno  where  " +data+ "  GROUP BY gaccount.ga_accno,bconfirm.bcf_cfmno,gfolio.gf_roomno,gaccount.ga_accstat,"
            + "guestname.gn_fname,guestname.gn_lname ,gaccount.ga_grpno,gaccount.ga_guestno,groupinfo.gri_grpname, "
            + " gaccount.ga_arrival,gaccount.ga_arrtime,gaccount.ga_departure,gaccount.ga_deptime,agent.a_name,nationality.n_descr,guestinfo.gi_company,booking.b_qty "
            + " ,booking.b_inhqty ,gfolio.gf_folno,booking.b_accno,gaccount.ga_acctype,gaccount.ga_walkin,booking.b_seq  order by ga_accno asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);
             */
            //((b_seq = (select max(b_seq) as seq  from booking where b_accno =ga_accno)) or       b_accno IS NULL ) and
            // String selectSQL = "select ga_accno,bcf_cfmno,gf_roomno,ga_accstat,t_id,gn_fname,gn_mname,gn_lname,gri_grpname,ga_arrival,ga_arrtime,ga_departure,ga_deptime,a_name,n_descr,gi_company,b_qty,b_inhqty,b_seq,gf_folno,b_accno,ga_acctype,ga_walkin from search_guestinfo_i " + extractData(individual) + " order by ga_accno asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);
//String selectSQL = "select gf_accno,bcf_cfmno,gf_roomno,ga_accstat,gn_fname||gn_lname,gri_grpname,ga_arrival,ga_departure,a_name,n_descr,gi_company,b_qty,b_inhqty,b_seq from search_guestinfo_i " + extractData(individual) + " order by gf_accno asc limit " + pgLimit + " offset " + ((iPg - 1) * pgLimit);

            //       String maxRateSQL = "select count(*) from search_guestinfo_i" + extractData(individual);
          
  String maxRateSQL = "select count(*) from ( select ga_accno, case when bcf_cfmno >0 then bcf_cfmno else 0 end , case when gf_roomno is not null then gf_roomno else '' end, ga_accstat,gn_fname||' '||gn_lname as guestname, case when (ga_grpno is not null and coalesce(ga_guestno,0) = 0) "
                    + "      then   gri_grpname   else ''  end ,ga_arrival,  ga_arrtime,ga_departure, "
                    + "    ga_deptime,case when a_name is not null then a_name else '' end ,n_descr,case when gi_company is not null then gi_company else '' end, "
                    + "      gf_folno,ga_walkin from gaccount left join   gfolio  on ga_accno=gf_accno   left join  BCONFIRM on ga_accno=bcf_accno   left join guestname "
                    + "      on guestname.gn_guestno=gaccount.ga_guestno "
                    + "   left join agent on a_id = ga_agentno left join groupinfo on gri_grpno = ga_grpno "
                    + "        left join   guestinfo on gi_guestno = ga_guestno left join nationality on  nationality.n_id=gi_natno  "
                    + "   where  " + data + "     GROUP BY gaccount.ga_accno,bconfirm.bcf_cfmno,gfolio.gf_roomno,gaccount.ga_accstat, "
                    + "    guestname.gn_fname,guestname.gn_lname ,gaccount.ga_grpno,gaccount.ga_guestno,groupinfo.gri_grpname, "
                    + "    gaccount.ga_arrival,gaccount.ga_arrtime,gaccount.ga_departure,gaccount.ga_deptime,agent.a_name,nationality.n_descr,guestinfo.gi_company, "
                    + "      gfolio.gf_folno,gaccount.ga_acctype,gaccount.ga_walkin  order by ga_accno asc  ) as aa ";

   try {

               dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                preparedStatementSelect = dbConnection.prepareStatement(selectSQL);



                ResultSet rs = preparedStatementSelect.executeQuery();

                while (rs.next()) {%>
               
        <tr>
            
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=rs.getString(4)%><% if (rs.getString(15).equals("Y")) {
                    out.println("NH-W");
                } else if (rs.getString(15).equals("N")) {
                    out.println("NH-H");
                } else {
                    out.println("");
                }
                %></td>
                <%--     <td><%=rs.getString(5)%>&nbsp;<%=rs.getString(6)%>&nbsp;<%=rs.getString(7)%>&nbsp;<%=rs.getString(8)%></td>
                --%>

            <td><%=rs.getString(5)%></td><td><%=rs.getString(6)%></td>

            <td><%=rs.getString(7)%><br/><%=rs.getString(8)%></td>
            <td><%=rs.getString(9)%><br/><%=rs.getString(10)%></td>
            <td><%=rs.getString(11)%></td>
            <td><%=rs.getString(12)%></td>
            <td><%=rs.getString(13)%></td>

           <td>
                <%
                    if (rs.getString(3) .length() !=0 && rs.getString(3).equals("...") && rs.getString(6) == null ) {
                %>
                <button href="#" class="btn info" onclick="window.open('individual_3.jsp?acc=<%=rs.getString(1)%>&dtl=<%=rs.getString(1)%>', '_blank', 'height=700, width=1000');return false;"><%=rs.getString(1)%></button>
                <%
                }else if(rs.getString(3) .length() !=0 && rs.getString(3).equals("...") && rs.getString(6) != null) { 
               %>
                <button href="#" class="btn info" onclick="window.open('individual_88.jsp?acc=<%=rs.getString(1)%>&dtl=<%=rs.getString(1)%>', '_blank', 'height=700, width=1000');return false;"><%=rs.getString(1)%></button>
                <%
              
                    } else if(rs.getString(3).length() ==0 && rs.getString(5).length()>0 ){ 
                 
              
                %>  <a href="<%=request.getContextPath() + "/checkin/checkin.jsp?acc=" + rs.getString(1) + "&roomno=" + (rs.getString(3) == null ? "" : rs.getString(3)) +  (rs.getString(14) == null ? "" : "&gf=" + rs.getString(14))%>" class="btn info">...</a>
               <%
                     } else if(rs.getString(3).length() !=0 && rs.getString(5).length()>0 ){ 
                 
              
                %>  <a href="<%=request.getContextPath() + "/checkin/checkin.jsp?acc=" + rs.getString(1) + "&roomno=" + (rs.getString(3) == null ? "" : rs.getString(3)) +  (rs.getString(14) == null ? "" : "&gf=" + rs.getString(14))%>" class="btn info">...</a>
               <%
                    } else{ 
                  
              
                %>
                  <a href="<%=request.getContextPath() +"/grcheckin/checkin.jsp?acc="+rs.getString(1) %>"  class="btn info">...</a>
             
                 <%
                    }
                %>
            </td>
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
                        <li class="prev <% if (pg == null || pg.equals("1")) {%> disabled<%}%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + (pg != null ? Integer.parseInt(pg) - 1 : "1")%>">&larr; Previous</a></li>
                        <%

                            int start = minPg + (iPg % pgInterval > 0 && iPg < pgInterval ? (pgInterval * (iPg / pgInterval)) : (iPg % pgInterval > 0 && iPg > pgInterval ? pgInterval * (iPg / pgInterval) : pgInterval * ((iPg / pgInterval) - 1)));
                            int end = start + pgInterval;
                            if (end > maxPg) {
                                end = maxPg + 1;
                            }
                            for (int i = start; i < end; i++) {
                        %>
                        <li class="<% if (i == iPg) {%>active<% }%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + i%>"><%=i%></a></li>
                        <%
                            }
                        %>
                        <li class="next <% if (iPg >= maxPg) {%> disabled <% }%>"><a href="<%=request.getContextPath() + "/guestinfo/individual.jsp?pg=" + (pg != null ? Integer.parseInt(pg) + 1 : "2")%>">Next &rarr;</a></li>
                    </ul>
                </div>
            </td>

        </tr>
    </tfoot>
</table>
<%!
    public String extractData(Individual1 individual) {
        String data = "";
        if (!Converter.isEmpty(individual.getFirst())) {
            data += individual.getFirst();

        }

        return data;
    }


%>                                   
