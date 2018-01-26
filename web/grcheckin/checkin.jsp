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

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%@include file="checkin_1.jsp"%>
<%
    if (request.getParameter("gf") == null) {

        // List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
        String accountId = request.getParameter("acc");
        String dtl = "";
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        int aa = 0, bb = 0;
        String booking = "";
        ResultSet rs;
        try {

            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);






            preparedStatementSelect = dbConnection.prepareStatement("SELECT count(b_accno) FROM booking where b_accno= " + accountId + ";");
            rs = preparedStatementSelect.executeQuery();

            while (rs.next()) {
                aa = rs.getInt(1);
            }
            if (aa == 0) {
                response.sendRedirect(request.getContextPath() + "/booking/newdetails.jsp?acc=" + accountId);

            }
            if (aa > 1) {  //seq case more than1
%>
<table class="zebra-striped" id="tbRateCode">
    <thead>
        <tr id='tbl' bgColor=#8080a6 >

            <th class="blue header">#b-seq</th>
            <th class="blue header">Account</th>
            <th class="blue header">Quantity</th>
            <th class="blue header">Arrival</th>
            <th class="blue header">Departure</th>
            <th class="blue header">Check In</th>
        </tr>
    </thead>
    <tbody>

        <%
            preparedStatementSelect = dbConnection.prepareStatement("SELECT b_seq,b_accno,b_qty,b_arrdate,b_depdate,b_inhqty from booking where b_accno= " + accountId + " order by b_seq asc ;");
            rs = preparedStatementSelect.executeQuery();
            while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(5)%></td>
            <%  // check finish checkin all?
                if (Converter.parseInt(rs.getString(3)) == Converter.parseInt(rs.getString(6)) && (Converter.parseInt(rs.getString(3)) > 0)) {
            %><td>...</td><%                              } else {
            %>
            <td><a class="btn info" href="checkseq.jsp?bkacc=<%=rs.getString(2)%>&dtl=<%=rs.getString(1)%>">Checkin</a></td>


            <%
                    }
                }
            %> </tr> </tbody>
</table>
<%
            } else {
                preparedStatementSelect = dbConnection.prepareStatement("select count(*) from namelist where nl_accno=" + accountId + "and  nl_dtlseq = " + 0 + ";");
                rs = preparedStatementSelect.executeQuery();
                while (rs.next()) {
                    bb = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }



        errorList = new ArrayList<String>();
        session.setAttribute("errors" + session.getId(), errorList);


        if (aa == 1) {
            dtl = "0";
            WebUser user = (WebUser) session.getAttribute("" + session.getId());


            if (bb == 0) { //not have namelist

                response.sendRedirect("newnamelist.jsp?bkacc=" + accountId + "&dtl=" + dtl);
            } else {


                response.sendRedirect("namelist.jsp?bkacc=" + accountId + "&dtl=" + dtl);

            }
        }
    }
%>