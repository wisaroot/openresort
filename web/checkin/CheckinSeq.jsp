<%-- 
    Document   : CheckinSeq
    Created on : 21 ส.ค. 2555, 14:22:56
    Author     : SamSung
--%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.checkin.CheckIn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ include file ="../config.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" %>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>

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
        <div class="content">
            <div class="page-header offset1">
                <%
                    String qty = request.getParameter("qty");
                    String bkacc = request.getParameter("bkacc");
                    String acc = request.getParameter("acc");
                    String seq = request.getParameter("seq");
                    String dtl = request.getParameter("dtl");

                    String roomno = request.getParameter("roomno");%>



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

                    <% }
                        ResultSet rs;
                        Connection dbConnection = null;
                        int aa = 0, g1 = 0;
                        PreparedStatement preparedStatementSelect = null;

                        try {
                            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);

                            if (qty == null) {
                                preparedStatementSelect = dbConnection.prepareStatement("SELECT b_qty FROM booking where b_accno= " + bkacc + ";");
                                rs = preparedStatementSelect.executeQuery();

                                while (rs.next()) {
                                    qty = rs.getString(1);
                                }
                    %>

                    <h1>Guest booking  <%= qty%> Rooms </h1>
                    <%  }%>

                    <form method="post"  name="aa" >
                        <div class="span8">

                            <table id="nameList">
                                <thead>
                                    <tr>

                                        <th>#ACC</th>
                                        <th>#BookNo</th>

                                        <th>Room</th>
                                        <th>Name</th>

                                        <th>Checkin</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%


                                        String selectSQL = "  SELECT gf_accno,gf_bkaccno,gf_roomno,gn_fname||gn_lname FROM gfolio left join gaccount on gf_accno= ga_accno left join guestname on gn_guestno=ga_guestno WHERE gf_bkaccno =? order by gf_accno ASC ;";




                                        preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
                                        preparedStatementSelect.setInt(1, Converter.parseInt((String) request.getParameter("bkacc")));
                                        rs = preparedStatementSelect.executeQuery();

                                        while (rs.next()) {
                                            aa++;

                                    %>
                                    <tr>    <td><%=(Converter.isEmpty(rs.getString(1)) ? "" : rs.getString(1))%></td>
                                        <td><%=(Converter.isEmpty(rs.getString(2)) ? "" : rs.getString(2))%></td>
                                        <td><%=(Converter.isEmpty(rs.getString(3)) ? "" : rs.getString(3))%></td>
                                        <td><%=(Converter.isEmpty(rs.getString(4)) ? "" : rs.getString(4))%></td>

                                        <td>

                                            <div class="clearfix">

                                                <div class="input">
                                                    IN-H   </div>
                                            </div>

                                        </td>

                                    </tr>

                                    <%
                                                if (rs.getString(1) == rs.getString(2)) {
                                                    g1 = 1;
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
                                        int i = 1, inh = aa;

                                        if (aa == 0) {  //never chekin
                                            while (i <= Converter.parseInt(qty)) {
                                    %> <tr>  <td>-</td><td>-</td><td>-</td><td>-</td>  <td>

                                            <div class="clearfix">

                                                <div class="input">
                                                    <a href="<%=request.getContextPath() + "/checkin/newcheckin.jsp?acc=" + bkacc + "&bkacc=" + bkacc + "&dtl=" + dtl + "&seq=" + seq + "&roomno=" + roomno%>"  class="btn info">...</a>


                                                </div>
                                            </div>

                                        </td></tr> <%
                                                i++;
                                            }
                                        } else if ((aa != 0) && (aa < Converter.parseInt(qty))) {  // alreday ck but iqty< qty 
                                            seq = Integer.toString(aa);
                                            while (inh < Converter.parseInt(qty)) {
                                        %>

                                    <tr>  <td>-</td><td>-</td><td>-</td><td>-</td>  <td>

                                            <div class="clearfix">

                                                <div class="input">
                                                    <a href="<%=request.getContextPath() + "/checkin/newguest.jsp?bkacc=" + bkacc + "&dtl=" + dtl + "&seq=" + seq + "&roomno=" + roomno%>"  class="btn info">...</a>


                                                </div>
                                            </div>

                                        </td></tr>
                                        <%     inh++;
                                            }
                                        }
                                        %>
                                </tbody>
                            </table>
                            <div class="actions">
                                <input type="hidden" name="bkacc" value="<%=(String) request.getParameter("bkacc")%>"/>
                                <input type="hidden" name="dtl" value="<%=(String) request.getParameter("dtl")%>"/>

                                <%--    <input type="submit" class="btn primary" value="Check In" onClick = "javascript:return valid_data();" />
                                --%>   </div>
                        </div>
                    </form>

                </div>
            </div> </div>

    </body>
</html>
